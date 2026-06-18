local S = minetest.get_translator("exile_alchemy")

local function register_flammable_item(name, desc, texture)
	minetest.register_craftitem(name, {
		description = desc,
		inventory_image = texture,
		stack_max = minimal.stack_max_medium * 2,
		groups = { flammable = 1 },
	})
end

register_flammable_item("exile_alchemy:salt", S("Salt"), "exile_alchemy_salt.png")
register_flammable_item("exile_alchemy:alcohol", S("Alcohol"), "exile_alchemy_alcohol.png")
register_flammable_item("exile_alchemy:sugar", S("Sugar"), "exile_alchemy_sugar.png")

minetest.register_craftitem("exile_alchemy:vinegar", {
	description = S("Vinegar"),
	inventory_image = "exile_alchemy_vinegar.png",
	stack_max = minimal.stack_max_medium * 2,
	groups = { flammable = 1 },

	on_use = function(itemstack, user, pointed_thing)
		exile_alchemy.add_effect(user, "nausea", 2)
		return HEALTH.use_item(itemstack, user, 0, 5, -5, -15, 0)
	end,
})

minetest.register_craftitem("exile_alchemy:dregs", {
	description = S("Dregs"),
	inventory_image = "exile_alchemy_dregs.png",
	stack_max = minimal.stack_max_medium,
})

minetest.register_craftitem("exile_alchemy:clear_glass_tube", {
	description = S("Clear Glass Tube"),
	inventory_image = "exile_alchemy_glass_vessel_inv.png",
	stack_max = minimal.stack_max_medium,
})
