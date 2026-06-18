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
	liquids_pointable = true,
	groups = { cracky = 3, oddly_breakable_by_hand = 3, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:get_inventory():set_size("main", exile_alchemy.alembic_inv_size)
		exile_alchemy.update_alembic_infotext(pos)
		minetest.get_node_timer(pos):start(exile_alchemy.alembic_check_interval)
	end,

	on_timer = exile_alchemy.alembic_process,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if not clicker or not clicker:is_player() then
			return itemstack
		end
		minetest.show_formspec(
			clicker:get_player_name(),
			"exile_alchemy:alembic",
			exile_alchemy.get_alembic_formspec(pos)
		)
		return itemstack
	end,

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

	allow_metadata_inventory_move = function()
		return 0
	end,

	allow_metadata_inventory_put = function()
		return 0
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "exile_alchemy:alembic" then
		return
	end
	-- Inventory changes refresh via timer; no extra fields yet.
end)
