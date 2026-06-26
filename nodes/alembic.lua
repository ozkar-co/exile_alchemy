local S = minetest.get_translator("exile_alchemy")

minetest.register_node("exile_alchemy:alembic_unfired", {
	description = S("Ceramic Alembic (unfired)"),
	drawtype = "nodebox",
	stack_max = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "nodes_nature_clay.png" },
	node_box = {
		type = "fixed",
		fixed = exile_alchemy.alambic_nodebox,
	},
	groups = { dig_immediate = 3, pottery = 1, temp_pass = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		ncrafting.set_firing(pos, ncrafting.base_firing, ncrafting.firing_int)
	end,
	on_timer = function(pos)
		return ncrafting.fire_pottery(
			pos,
			"exile_alchemy:alembic_unfired",
			"exile_alchemy:alembic",
			ncrafting.base_firing
		)
	end,
})

minetest.register_node("exile_alchemy:alembic", {
	description = S("Ceramic Alembic"),
	drawtype = "nodebox",
	stack_max = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "tech_pottery.png" },
	node_box = {
		type = "fixed",
		fixed = exile_alchemy.alambic_nodebox,
	},
	groups = { cracky = 3, oddly_breakable_by_hand = 3, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:get_inventory():set_size("main", exile_alchemy.alembic_inv_size)
		meta:set_float("remaining", 0)
		meta:set_string("process_source", "")
		exile_alchemy.update_alembic_infotext(pos)
		minetest.get_node_timer(pos):start(exile_alchemy.alembic_check_interval)
	end,

	on_timer = exile_alchemy.alembic_process,

	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if not inv then
			return
		end
		for _, item in ipairs(inv:get_list("main")) do
			if not item:is_empty() then
				minetest.add_item(pos, item)
			end
		end
	end,

	on_infotext = exile_alchemy.alembic_on_infotext,
})
