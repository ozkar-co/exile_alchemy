crafting.register_recipe({
	type = "glass_furnace",
	output = "exile_alchemy:clear_glass_tube 2",
	items = { "tech:clear_glass_ingot" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "pottery_wheel",
	output = "exile_alchemy:alembic_unfired 1",
	items = {
		"nodes_nature:clay_wet 4",
		"exile_alchemy:clear_glass_tube 2",
	},
	level = 2,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "exile_alchemy:mashed_wiha 1",
	items = { "nodes_nature:wiha 6" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "exile_alchemy:wiha_must_pot 1",
	items = {
		"exile_alchemy:mashed_wiha 4",
		"tech:clay_water_pot_freshwater",
	},
	level = 1,
	always_known = true,
})
