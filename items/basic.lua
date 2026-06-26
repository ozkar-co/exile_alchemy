local S = minetest.get_translator("exile_alchemy")

local function register_flammable_item(name, desc, texture)
	minetest.register_craftitem(name, {
		description = desc,
		inventory_image = texture,
		stack_max = EXILE.stack_max_medium * 2,
		groups = { flammable = 1 },
	})
end

local function eat_with_binge(itemstack, user, thirst, hunger, energy, binge_key, effect_id)
	if not minetest.is_player(user) then
		return itemstack
	end

	local stack = HEALTH.use_item(itemstack, user, 0, thirst, hunger, energy, 0)
	if stack == nil then
		return
	end

	if exile_alchemy.record_binge(user, binge_key) then
		local severity = exile_alchemy.has_effect(user, effect_id) and 2 or 1
		exile_alchemy.add_effect(user, effect_id, severity)
	end

	return stack
end

minetest.register_craftitem("exile_alchemy:salt", {
	description = S("Salt"),
	inventory_image = "exile_alchemy_salt.png",
	stack_max = EXILE.stack_max_medium * 2,
	groups = { flammable = 1 },

	on_use = function(itemstack, user, pointed_thing)
		return eat_with_binge(itemstack, user, -4, 2, 0, "salt", "salt_sickness")
	end,
})

minetest.register_craftitem("exile_alchemy:sugar", {
	description = S("Sugar"),
	inventory_image = "exile_alchemy_sugar.png",
	stack_max = EXILE.stack_max_medium * 2,
	groups = { flammable = 1 },

	on_use = function(itemstack, user, pointed_thing)
		return eat_with_binge(itemstack, user, 0, 10, 40, "sugar", "sugar_overload")
	end,
})

register_flammable_item("exile_alchemy:alcohol", S("Alcohol"), "exile_alchemy_alcohol.png")

minetest.register_craftitem("exile_alchemy:acetic_acid", {
	description = S("Acetic Acid"),
	inventory_image = "exile_alchemy_vinegar.png",
	stack_max = EXILE.stack_max_medium * 2,
	groups = { flammable = 1 },

	on_use = function(itemstack, user, pointed_thing)
		exile_alchemy.add_effect(user, "nausea", 3)
		return HEALTH.use_item(itemstack, user, 0, 0, -10, -25, 0)
	end,
})

minetest.register_alias("exile_alchemy:vinegar", "exile_alchemy:acetic_acid")

minetest.register_craftitem("exile_alchemy:dregs", {
	description = S("Dregs"),
	inventory_image = "exile_alchemy_dregs.png",
	stack_max = EXILE.stack_max_medium,
})

minetest.register_craftitem("exile_alchemy:clear_glass_tube", {
	description = S("Clear Glass Tube"),
	inventory_image = "exile_alchemy_glass_tube.png",
	stack_max = EXILE.stack_max_medium,
})
