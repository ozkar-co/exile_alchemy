local S = minetest.get_translator("exile_alchemy")
local random = math.random

crafting.register_group_desc("wiha_vinegar", S("Wiha Vinegar"))

local pot_groups = { dig_immediate = 2, pottery = 1, temp_pass = 1, drug = 1 }

liquid_store.register_liquid("exile_alchemy:wiha_must_liquid", {
	flowing = false,
	force_renew = false,
})

liquid_store.register_stored_liquid("exile_alchemy:wiha_must_pot", {
	source = "exile_alchemy:wiha_must_liquid",
	empty = "tech:clay_water_pot",
	description = S("Wiha Must (unfermented)"),
	add_liquid_tile = "exile_alchemy_pot_wiha_must.png",
	node_box = "container",
	groups = pot_groups,
})

liquid_store.register_liquid("exile_alchemy:wiha_wine_liquid", {
	flowing = false,
	force_renew = false,
})

liquid_store.register_stored_liquid("exile_alchemy:wiha_wine_pot", {
	source = "exile_alchemy:wiha_wine_liquid",
	empty = "tech:clay_water_pot",
	description = S("Wiha Wine"),
	add_liquid_tile = "exile_alchemy_pot_wiha_wine.png",
	node_box = "container",
	groups = pot_groups,
})

liquid_store.register_liquid("exile_alchemy:wiha_cider_liquid", {
	flowing = false,
	force_renew = false,
	groups = { "vinegar", "wiha_vinegar" },
})

liquid_store.register_stored_liquid("exile_alchemy:wiha_cider_pot", {
	source = "exile_alchemy:wiha_cider_liquid",
	empty = "tech:clay_water_pot",
	description = S("Wiha Cider (Vinegar)"),
	add_liquid_tile = "exile_alchemy_pot_wiha_cider.png",
	node_box = "container",
	groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
})

exile_alchemy.register_ferment_overrides("exile_alchemy:wiha_must_pot", {
	on_complete = function(pos)
		minetest.swap_node(pos, { name = "exile_alchemy:wiha_wine_pot" })
		exile_alchemy.start_ferment_at(pos)
	end,
})

exile_alchemy.register_ferment_overrides("exile_alchemy:wiha_wine_pot", {
	on_complete = function(pos)
		minetest.swap_node(pos, { name = "exile_alchemy:wiha_cider_pot" })
	end,
})

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
