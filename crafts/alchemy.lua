crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:alembic_unfired 1",
	items = { "nodes_nature:clay_wet 5", "tech:stick 2" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 5",
	items = { "tech:alembic_unfired" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:mashed_wiha 1",
	items = { "nodes_nature:wiha 12" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:wiha_must_pot 1",
	items = { "tech:mashed_wiha", "nodes_nature:nebiyi 6", "tech:clay_amphora_freshwater" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_basalt",
	items = { "group:basalt_cobble 8" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_gneiss",
	items = { "group:gneiss_cobble 8" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_granite",
	items = { "group:granite_cobble 8" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:quartz_powder",
	items = { "tech:crushed_gneiss" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:clay_amphora_unfired 1",
	items = { "nodes_nature:clay_wet 5" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 5",
	items = { "tech:clay_amphora_unfired" },
	level = 1,
	always_known = true,
})

-- clay equipement

crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:clay_crucible_unfired 1",
	items = { "nodes_nature:clay_wet 4", "tech:broken_pottery" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 4",
	items = { "tech:clay_crucible_unfired", "tech:broken_pottery" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:clay_mortar_unfired 1",
	items = { "nodes_nature:clay_wet 5" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 5",
	items = { "tech:clay_mortar_unfired" },
	level = 1,
	always_known = true,
})

-- glass equipment

crafting.register_recipe({
	type = "glass_furnace",
	output = "tech:glass_retort",
	items = { "tech:green_glass_ingot", "tech:charcoal", "tech:salt" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "glass_furnace",
	output = "tech:glass_vessel",
	items = { "tech:clear_glass_ingot", "tech:charcoal", "tech:salt" },
	level = 1,
	always_known = true,
})

-- alchemy Bench

crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:alchemy_bench",
	items = {
		"tech:iron_ingot 1",
		"nodes_nature:maraka_log 2",
		"tech:glass_retort",
		"tech:clay_crucible",
		"tech:clay_mortar",
	},
	level = 1,
	always_known = true,
})

-- alchemy recipes
crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:nightstone",
	items = {
		"group:basalt_cobble",
		"tech:alcohol",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:nephritic_stone",
	items = {
		"nodes_nature:volcanic_ash",
		"tech:potash",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:activated_carbon",
	items = {
		"tech:crushed_charcoal_block",
		"tech:alcohol",
		"tech:nephritic_stone",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:brimstone",
	items = {
		"tech:roasted_iron_ore",
		"nodes_nature:volcanic_ash",
		"tech:alcohol",
		"tech:nephritic_stone",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:star_dust",
	items = {
		"nodes_nature:clay",
		"tech:aurifex",
		"tech:nephritic_stone",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:saltpeter",
	items = {
		"nodes_nature:clay_wet",
		"tech:wood_ash",
		"tech:sugar",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:serpentine",
	items = {
		"tech:crushed_charcoal_block",
		"nodes_nature:clay_wet",
		"tech:brimstone",
		"tech:sugar",
		"tech:alcohol",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:soap_uncured",
	items = {
		"tech:death_salt",
		"tech:tartar_salt",
		"tech:vegetable_oil",
		"tech:alcohol",
		"tech:salt",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:tartar_salt",
	items = {
		"tech:crushed_lime",
		"tech:potash",
		"tech:salt",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:aluminium_mix",
	items = {
		"tech:crushed_charcoal_block",
		"tech:tartar_salt",
		"tech:star_dust",
		"tech:alcohol",
		"tech:peridot",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:acrimoniac_amphora",
	items = {
		"tech:quicklime",
		"tech:salt",
		"tech:nightstone",
		"tech:vinegar_pot",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:vitriol_vessel",
	items = {
		"tech:iron_ingot",
		"tech:glass_vessel",
		"tech:brimstone",
		"tech:peridot",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:aurifex",
	items = {
		"tech:crushed_gneiss",
		"tech:crushed_granite",
		"tech:brimstone",
		"tech:nightstone",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:elixir_vitae",
	items = {
		"tech:quartz_powder",
		"tech:serpentine",
		"tech:star_dust",
		"tech:alcohol",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:peridot",
	items = {
		"tech:crushed_basalt",
		"tech:alcohol",
	},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "alchemy_bench",
	output = "tech:fermented_tartaris_syrup_amphora",
	items = {
		"tech:tartar_salt",
		"tech:sugar 12",
		"tech:clay_amphora_freshwater",
	},
	level = 1,
	always_known = true,
})
