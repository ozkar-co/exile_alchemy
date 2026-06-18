local S = minetest.get_translator("exile_alchemy")
local random = math.random

local pot_groups = { dig_immediate = 2, pottery = 1, temp_pass = 1, drug = 1 }

liquid_store.register_stored_liquid(
	"exile_alchemy:wiha_must_liquid",
	"exile_alchemy:wiha_must_pot",
	"tech:clay_water_pot",
	exile_alchemy.pot_tiles("exile_alchemy_pot_wiha_must.png"),
	exile_alchemy.pot_nodebox,
	S("Wiha Must (unfermented)"),
	pot_groups
)

liquid_store.register_stored_liquid(
	"exile_alchemy:wiha_wine_liquid",
	"exile_alchemy:wiha_wine_pot",
	"tech:clay_water_pot",
	exile_alchemy.pot_tiles("exile_alchemy_pot_wiha_must.png"),
	exile_alchemy.pot_nodebox,
	S("Wiha Wine"),
	pot_groups
)

liquid_store.register_stored_liquid(
	"exile_alchemy:wiha_cider_liquid",
	"exile_alchemy:wiha_cider_pot",
	"tech:clay_water_pot",
	exile_alchemy.pot_tiles("exile_alchemy_pot_wiha_cider.png"),
	exile_alchemy.pot_nodebox,
	S("Wiha Cider"),
	pot_groups
)

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

local function drink_wiha_wine(pos, clicker)
	local meta = clicker:get_meta()
	if meta:get_int("thirst") >= 100 then
		return
	end

	meta:set_int("thirst", 100)
	meta:set_int("energy", minimal.math_clamp(meta:get_int("energy") + 120, 1000, 0))
	meta:set_int("hunger", minimal.math_clamp(meta:get_int("hunger") + 40, 1000, 0))

	if random() < 0.75 then
		HEALTH.add_new_effect(clicker, { "Drunk", 1 })
	end

	minetest.swap_node(pos, { name = "tech:clay_water_pot" })
	minetest.sound_play("nodes_nature_slurp", {
		pos = pos,
		max_hear_distance = 3,
		gain = 0.25,
	})
end

local function drink_wiha_cider(pos, clicker)
	local meta = clicker:get_meta()
	if meta:get_int("thirst") >= 100 then
		return
	end

	meta:set_int("thirst", minimal.math_clamp(meta:get_int("thirst") + 60, 100, 0))
	meta:set_int("energy", minimal.math_clamp(meta:get_int("energy") + 40, 1000, 0))
	meta:set_int("hunger", minimal.math_clamp(meta:get_int("hunger") + 20, 1000, 0))

	exile_alchemy.add_effect(clicker, "nausea", 1)

	minetest.swap_node(pos, { name = "tech:clay_water_pot" })
	minetest.sound_play("nodes_nature_slurp", {
		pos = pos,
		max_hear_distance = 3,
		gain = 0.25,
	})
end

minetest.override_item("exile_alchemy:wiha_wine_pot", {
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker and clicker:is_player() then
			drink_wiha_wine(pos, clicker)
		end
	end,
})

minetest.override_item("exile_alchemy:wiha_cider_pot", {
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker and clicker:is_player() then
			drink_wiha_cider(pos, clicker)
		end
	end,
})

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
