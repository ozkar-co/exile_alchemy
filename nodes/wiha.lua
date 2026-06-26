local S = minetest.get_translator("exile_alchemy")
local random = math.random

crafting.register_group_desc("wiha_vinegar", S("Wiha Vinegar"))

local pot_groups = { dig_immediate = 2, pottery = 1, temp_pass = 1, drug = 1 }
local ferment_time = { min = 300, max = 360 }
local ferment_temp = { min = 10, max = 34 }

local function wiha_ferment_callbacks(ferment_to)
	return {
		_ferment_time = ferment_time,
		_ferment_temp_range = ferment_temp,
		_ferment_to = ferment_to,
		on_construct = function(pos)
			ncrafting.ferment_on_construct(pos)
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing, nmeta, imeta)
			ncrafting.ferment_after_place(pos, placer, itemstack, pointed_thing, nmeta, imeta)
		end,
		on_timer = function(pos, elapsed)
			return ncrafting.ferment_on_timer(pos, elapsed)
		end,
		preserve_metadata = function(pos, oldnode, oldmeta, drops, imeta)
			ncrafting.ferment_preserve_metadata(pos, oldnode, oldmeta, drops[1], imeta)
		end,
		_preserve_metadata = function(pos, oldnode, oldmeta, transferred_stack)
			ncrafting.ferment_preserve_metadata(pos, oldnode, oldmeta, transferred_stack)
		end,
	}
end

local function register_wiha_pot(name, liquid, overlay, description, groups, ferment_to)
	local def = {
		source = liquid,
		empty = "tech:clay_water_pot",
		description = description,
		add_liquid_tile = overlay,
		node_box = "container",
		groups = groups,
	}
	if ferment_to then
		for key, value in pairs(wiha_ferment_callbacks(ferment_to)) do
			def[key] = value
		end
	end
	liquid_store.register_stored_liquid(name, def)
end

liquid_store.register_liquid("exile_alchemy:wiha_must_liquid", {
	flowing = false,
	force_renew = false,
})

liquid_store.register_liquid("exile_alchemy:wiha_wine_liquid", {
	flowing = false,
	force_renew = false,
})

liquid_store.register_liquid("exile_alchemy:wiha_cider_liquid", {
	flowing = false,
	force_renew = false,
	groups = { "vinegar", "wiha_vinegar" },
})

register_wiha_pot(
	"exile_alchemy:wiha_must_pot",
	"exile_alchemy:wiha_must_liquid",
	"exile_alchemy_pot_wiha_must.png",
	S("Wiha Must (unfermented)"),
	pot_groups,
	"exile_alchemy:wiha_wine_pot"
)

register_wiha_pot(
	"exile_alchemy:wiha_wine_pot",
	"exile_alchemy:wiha_wine_liquid",
	"exile_alchemy_pot_wiha_wine.png",
	S("Wiha Wine"),
	pot_groups,
	"exile_alchemy:wiha_cider_pot"
)

register_wiha_pot(
	"exile_alchemy:wiha_cider_pot",
	"exile_alchemy:wiha_cider_liquid",
	"exile_alchemy_pot_wiha_cider.png",
	S("Wiha Cider (Vinegar)"),
	{ dig_immediate = 2, pottery = 1, temp_pass = 1 },
	nil
)

local function drink_wiha_wine(player)
	local meta = player:get_meta()
	if meta:get_int("thirst") >= 100 then
		return false
	end

	meta:set_int("thirst", 100)
	meta:set_int("energy", EXILE.math_clamp(meta:get_int("energy") + 120, 1000, 0))
	meta:set_int("hunger", EXILE.math_clamp(meta:get_int("hunger") + 40, 1000, 0))

	if random() < 0.75 then
		HEALTH.add_new_effect(player, { "Drunk", 1 })
	end

	minetest.sound_play("nodes_nature_slurp", {
		pos = player:get_pos(),
		max_hear_distance = 3,
		gain = 0.25,
	})
	return true
end

local function drink_wiha_cider(player)
	local meta = player:get_meta()
	if meta:get_int("thirst") >= 100 then
		return false
	end

	meta:set_int("thirst", EXILE.math_clamp(meta:get_int("thirst") + 60, 100, 0))
	meta:set_int("energy", EXILE.math_clamp(meta:get_int("energy") + 40, 1000, 0))
	meta:set_int("hunger", EXILE.math_clamp(meta:get_int("hunger") + 20, 1000, 0))

	exile_alchemy.add_effect(player, "nausea", 1)

	minetest.sound_play("nodes_nature_slurp", {
		pos = player:get_pos(),
		max_hear_distance = 3,
		gain = 0.25,
	})
	return true
end

local function register_drinkable_pot(pot_name, liquid_source, empty_pot, drink_fn)
	minetest.override_item(pot_name, {
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type ~= "node" then
				if minetest.is_player(user) and drink_fn(user) then
					if EXILE.player_in_creative(user) then
						return itemstack
					end
					return ItemStack(empty_pot)
				end
				return itemstack
			end
			return liquid_store.on_use_filled_bucket(
				liquid_source,
				empty_pot,
				itemstack,
				user,
				pointed_thing,
				false
			)
		end,

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if not clicker or not clicker:is_player() then
				return
			end
			if not itemstack:is_empty() then
				return
			end
			if drink_fn(clicker) then
				minetest.swap_node(pos, { name = empty_pot })
			end
		end,
	})
end

register_drinkable_pot(
	"exile_alchemy:wiha_wine_pot",
	"exile_alchemy:wiha_wine_liquid",
	"tech:clay_water_pot",
	drink_wiha_wine
)

register_drinkable_pot(
	"exile_alchemy:wiha_cider_pot",
	"exile_alchemy:wiha_cider_liquid",
	"tech:clay_water_pot",
	drink_wiha_cider
)

minetest.register_node("exile_alchemy:dregs_pot", {
	description = S("Clay Pot With Dregs"),
	drawtype = "nodebox",
	stack_max = 1,
	paramtype = "light",
	tiles = exile_alchemy.pot_tiles("exile_alchemy_dregs_overlay.png"),
	node_box = exile_alchemy.pot_nodebox,
	groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	drop = {
		max_items = 2,
		items = {
			{ items = { "exile_alchemy:dregs" } },
			{ items = { "tech:clay_water_pot" } },
		},
	},
})
