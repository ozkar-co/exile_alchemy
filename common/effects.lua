local S = minetest.get_translator("exile_alchemy")
local random = math.random

exile_alchemy.effects = exile_alchemy.effects or {}
exile_alchemy.effect_defs = exile_alchemy.effect_defs or {}

local META_KEY = "exile_alchemy_effects"
local BINGE_META_KEY = "exile_alchemy_binges"
local BINGE_WINDOW = 90
local BINGE_LIMIT = 4
local DEFAULT_TICK = 60
local monoid_id = "exile_alchemy:nausea"

local function get_life_num(player)
	if type(player) ~= "userdata" or not player:is_player() then
		return 0
	end
	return player:get_meta():get_int("lives") or 0
end

local function is_effect_valid(player, life_num)
	if type(life_num) ~= "number" then
		return false
	end
	return life_num == get_life_num(player)
end

local function vomit(player, meta, repeat_min, repeat_max, delay_min, delay_max, t_min, t_max, h_min, h_max)
	local life_num = get_life_num(player)
	local ranrep = random(repeat_min, repeat_max)
	local randel = 0

	for _ = 1, ranrep do
		randel = randel + random(delay_min, delay_max)
		minetest.after(randel, function()
			if not is_effect_valid(player, life_num) then
				return
			end
			if player:get_hp() <= 0 then
				return
			end

			local pos = player:get_pos()
			minetest.sound_play("health_vomit", {
				pos = pos,
				gain = 0.5,
				max_hear_distance = 2,
			})

			local pmeta = player:get_meta()
			local thirst = pmeta:get_int("thirst") - random(t_min, t_max)
			local hunger = pmeta:get_int("hunger") - random(h_min, h_max)
			pmeta:set_int("thirst", math.max(0, thirst))
			pmeta:set_int("hunger", math.max(0, hunger))
		end)
	end
end

local function apply_move_penalty(player, severity)
	local penalty = ({ 0.03, 0.05, 0.10 })[severity] or 0
	player_monoids.speed:add_change(player, 1 - penalty, monoid_id)
	player_monoids.jump:add_change(player, 1 - penalty, monoid_id)
end

local function clear_move_penalty(player)
	player_monoids.speed:del_change(player, monoid_id)
	player_monoids.jump:del_change(player, monoid_id)
end

local function apply_effect_monoid(player, effect_id, severity, penalties)
	local penalty = penalties[severity] or 0
	if penalty <= 0 then
		return
	end
	local id = "exile_alchemy:" .. effect_id
	player_monoids.speed:add_change(player, 1 - penalty, id)
	player_monoids.jump:add_change(player, 1 - penalty, id)
end

local function clear_effect_monoid(player, effect_id)
	local id = "exile_alchemy:" .. effect_id
	player_monoids.speed:del_change(player, id)
	player_monoids.jump:del_change(player, id)
end

local function clear_all_effect_monoids(player)
	clear_move_penalty(player)
	clear_effect_monoid(player, "sugar_overload")
end

function exile_alchemy.get_effects_table(meta)
	return minetest.deserialize(meta:get_string(META_KEY)) or {}
end

local function save_effects_table(meta, effects)
	meta:set_string(META_KEY, minetest.serialize(effects))
end

function exile_alchemy.sync_player_api_state(player, id, severity)
	local st = player_api.get_state(player)
	if severity and severity > 0 then
		if not st:is(id) then
			st:add(id, 0)
		end
		st:set_severity(id, severity)
	else
		st:clear(id)
	end
end

function exile_alchemy.register_effect(id, def)
	exile_alchemy.effect_defs[id] = def

	player_api.register_state({
		mod = "exile_alchemy",
		name = id,
		label = def.label,
		priority = def.priority or 3,
		severity_txt = def.severity_txt,
	})
end

function exile_alchemy.has_effect(player, id)
	if not minetest.is_player(player) then
		return false
	end
	local effects = exile_alchemy.get_effects_table(player:get_meta())
	return effects[id] ~= nil and (effects[id].severity or 0) > 0
end

function exile_alchemy.record_binge(player, key)
	if not minetest.is_player(player) then
		return false
	end

	local meta = player:get_meta()
	local binges = minetest.deserialize(meta:get_string(BINGE_META_KEY)) or {}
	local now = os.time()
	local entry = binges[key]

	if not entry or now - entry.t > BINGE_WINDOW then
		entry = { t = now, n = 1 }
	else
		entry.n = entry.n + 1
	end

	binges[key] = entry
	meta:set_string(BINGE_META_KEY, minetest.serialize(binges))
	return entry.n >= BINGE_LIMIT
end

function exile_alchemy.remove_effect(player, id, amount)
	if not minetest.is_player(player) then
		return
	end

	local meta = player:get_meta()
	local effects = exile_alchemy.get_effects_table(meta)
	local entry = effects[id]
	if not entry then
		return
	end

	amount = amount or 1
	entry.severity = (entry.severity or 1) - amount
	if entry.severity <= 0 then
		effects[id] = nil
		exile_alchemy.sync_player_api_state(player, id, 0)
		local def = exile_alchemy.effect_defs[id]
		if def and def.on_clear then
			def.on_clear(player, meta)
		end
	else
		entry.timer = random(
			exile_alchemy.effect_defs[id].timer_min or 3,
			exile_alchemy.effect_defs[id].timer_max or 6
		)
		exile_alchemy.sync_player_api_state(player, id, entry.severity)
	end

	save_effects_table(meta, effects)
end

function exile_alchemy.add_effect(player, id, severity)
	if not minetest.is_player(player) then
		return
	end

	local def = exile_alchemy.effect_defs[id]
	if not def then
		minetest.log("warning", "exile_alchemy.add_effect: unknown effect " .. id)
		return
	end

	local meta = player:get_meta()
	local effects = exile_alchemy.get_effects_table(meta)
	local entry = effects[id] or { severity = 0, timer = 0 }
	local max_sev = def.max_severity or 4

	if entry.severity > 0 then
		entry.severity = math.min(max_sev, math.max(entry.severity, severity))
	else
		entry.severity = math.min(max_sev, severity)
	end

	entry.timer = random(def.timer_min or 3, def.timer_max or 6)
	effects[id] = entry
	save_effects_table(meta, effects)

	exile_alchemy.sync_player_api_state(player, id, entry.severity)

	if def.on_apply then
		def.on_apply(player, entry.severity, meta)
	end
end

local function tick_player_effects(player, dtime)
	local meta = player:get_meta()
	local effects = exile_alchemy.get_effects_table(meta)
	local ids = {}

	for id in pairs(effects) do
		table.insert(ids, id)
	end

	for _, id in ipairs(ids) do
		local entry = effects[id]
		local def = exile_alchemy.effect_defs[id]
		if def and entry and entry.severity and entry.severity > 0 then
			if def.on_tick then
				def.on_tick(player, entry.severity, meta)
			end

			entry.timer = (entry.timer or 1) - 1
			if entry.timer <= 0 then
				exile_alchemy.remove_effect(player, id, 1)
				effects = exile_alchemy.get_effects_table(meta)
			else
				save_effects_table(meta, effects)
			end
		end
	end
end

local tick_accum = 0
minetest.register_globalstep(function(dtime)
	tick_accum = tick_accum + dtime
	if tick_accum < DEFAULT_TICK then
		return
	end
	tick_accum = 0

	for _, player in ipairs(minetest.get_connected_players()) do
		if player:get_hp() > 0 then
			tick_player_effects(player, DEFAULT_TICK)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local effects = exile_alchemy.get_effects_table(meta)
	for id, entry in pairs(effects) do
		if entry.severity and entry.severity > 0 then
			exile_alchemy.sync_player_api_state(player, id, entry.severity)
		end
	end
end)

minetest.register_on_dieplayer(function(player)
	clear_all_effect_monoids(player)
end)

-- Sour Revulsion (nausea)
exile_alchemy.register_effect("nausea", {
	label = S("Sour Revulsion"),
	priority = 3,
	max_severity = 3,
	severity_txt = { "", S("(queasy)"), S("(nauseous)"), S("(wretching)") },
	timer_min = 3,
	timer_max = 6,

	on_apply = function(player, severity, meta)
		apply_move_penalty(player, severity)
	end,

	on_clear = function(player, meta)
		clear_move_penalty(player)
	end,

	on_tick = function(player, severity, meta)
		apply_move_penalty(player, severity)

		if severity == 1 then
			if random() < 0.2 then
				minetest.sound_play("health_vomit", {
					pos = player:get_pos(),
					gain = 0.25,
					max_hear_distance = 2,
				})
			end
		elseif severity == 2 then
			if random() < 0.5 then
				vomit(player, meta, 1, 2, 1, 8, 3, 8, 2, 5)
			end
		elseif severity >= 3 then
			vomit(player, meta, 2, 4, 1, 6, 8, 15, 5, 10)
			local energy = meta:get_int("energy") - 20
			meta:set_int("energy", math.max(0, energy))
		end
	end,
})

-- Salt sickness (too much salt in a short time)
exile_alchemy.register_effect("salt_sickness", {
	label = S("Salt Sickness"),
	priority = 3,
	max_severity = 2,
	severity_txt = { "", S("(dry mouth)"), S("(parched)") },
	timer_min = 4,
	timer_max = 7,

	on_tick = function(player, severity, meta)
		local thirst = meta:get_int("thirst")
		if severity == 1 then
			meta:set_int("thirst", math.max(0, thirst - random(4, 8)))
		else
			meta:set_int("thirst", math.max(0, thirst - random(8, 14)))
			if random() < 0.25 then
				minetest.sound_play("health_vomit", {
					pos = player:get_pos(),
					gain = 0.2,
					max_hear_distance = 2,
				})
			end
		end
	end,
})

-- Sugar overload (too much sugar in a short time)
exile_alchemy.register_effect("sugar_overload", {
	label = S("Sugar Overload"),
	priority = 3,
	max_severity = 2,
	severity_txt = { "", S("(buzzing)"), S("(crashing)") },
	timer_min = 3,
	timer_max = 6,

	on_apply = function(player, severity, meta)
		apply_effect_monoid(player, "sugar_overload", severity, { 0, 0, 0.05 })
	end,

	on_clear = function(player, meta)
		clear_effect_monoid(player, "sugar_overload")
	end,

	on_tick = function(player, severity, meta)
		apply_effect_monoid(player, "sugar_overload", severity, { 0, 0, 0.05 })

		local energy = meta:get_int("energy")
		if severity == 1 then
			meta:set_int("energy", EXILE.math_clamp(energy + random(8, 15), 1000, 0))
		else
			meta:set_int("energy", EXILE.math_clamp(energy - random(12, 22), 1000, 0))
		end
	end,
})
