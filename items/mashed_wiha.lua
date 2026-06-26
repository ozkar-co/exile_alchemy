local S = minetest.get_translator("exile_alchemy")

minetest.register_craftitem("exile_alchemy:mashed_wiha", {
	description = S("Mashed Wiha"),
	inventory_image = "exile_alchemy_mashed_wiha_inv.png",
	stack_max = EXILE.stack_max_medium,
	groups = { flammable = 1 },

	on_use = function(itemstack, user, pointed_thing)
		-- 90% of eating 6 wiha: {0, 24, 12, 0, 0} -> {0, 22, 11, 0, 0}
		return HEALTH.use_item(itemstack, user, 0, 22, 11, 0, 0)
	end,
})
