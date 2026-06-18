local S = minetest.get_translator("exile_alchemy")

exile_alchemy.alembic_inv_size = 4
exile_alchemy.alembic_check_interval = 20
exile_alchemy.alembic_working_temperature = 100
exile_alchemy.alembic_max_temperature = 200
exile_alchemy.ambient_temperature_time = 300

exile_alchemy.alembic_processes = {
	["tech:clay_water_pot_salt_water"] = {
		products = { "exile_alchemy:salt 2" },
		subproduct = "tech:clay_water_pot_freshwater",
		time = 120,
		product_label = S("Salt"),
	},
	["tech:tang"] = {
		products = { "exile_alchemy:alcohol 1" },
		subproduct = "tech:clay_water_pot_freshwater",
		time = 180,
		product_label = S("Alcohol"),
	},
	["exile_alchemy:wiha_wine_pot"] = {
		products = { "exile_alchemy:alcohol 1" },
		subproduct = "tech:clay_water_pot_freshwater",
		time = 180,
		product_label = S("Alcohol"),
	},
	["tech:tang_unfermented"] = {
		products = { "exile_alchemy:sugar 12" },
		subproduct = "exile_alchemy:dregs_pot",
		time = 240,
		product_label = S("Sugar"),
	},
	["exile_alchemy:wiha_must_pot"] = {
		products = { "exile_alchemy:sugar 12" },
		subproduct = "exile_alchemy:dregs_pot",
		time = 240,
		product_label = S("Sugar"),
	},
	["exile_alchemy:wiha_cider_pot"] = {
		products = { "exile_alchemy:vinegar 1" },
		subproduct = "exile_alchemy:dregs_pot",
		time = 150,
		product_label = S("Vinegar"),
	},
}

function exile_alchemy.get_alembic_process(below_name)
	return exile_alchemy.alembic_processes[below_name]
end

function exile_alchemy.get_alembic_formspec(pos)
	local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
	local below_node = minetest.get_node(below_pos)
	local process = exile_alchemy.get_alembic_process(below_node.name)
	local label
	if process then
		label = S("Processing: @1", process.product_label)
	else
		label = S("Processing: Nothing")
	end

	return "size[8,4.8]"
		.. "label[0,0;" .. minetest.formspec_escape(label) .. "]"
		.. "list[current_name;main;3,0.7;2,2]"
		.. "list[current_player;main;0,3;8,4;]"
		.. "listring[current_name;main]"
		.. "listring[current_player;main]"
end

local function alembic_contents_text(inv)
	if inv:is_empty("main") then
		return S("empty")
	end
	local parts = {}
	for i = 1, inv:get_size("main") do
		local stack = inv:get_stack("main", i)
		if not stack:is_empty() then
			table.insert(
				parts,
				stack:get_count()
					.. " "
					.. minetest.registered_items[stack:get_name()].description
			)
		end
	end
	return table.concat(parts, ". ")
end

function exile_alchemy.update_alembic_infotext(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
	local below_node = minetest.get_node(below_pos)
	local process = exile_alchemy.get_alembic_process(below_node.name)
	local temp = climate.get_point_temp(below_pos)
	local infotext_lines = {}

	if process then
		if temp > exile_alchemy.alembic_max_temperature then
			table.insert(infotext_lines, "Status: " .. S("Temperature too high"))
		elseif temp <= exile_alchemy.alembic_working_temperature then
			table.insert(infotext_lines, "Status: " .. S("Temperature too low"))
		else
			table.insert(
				infotext_lines,
				"Status: " .. S("Processing @1", process.product_label)
			)
		end
	else
		table.insert(infotext_lines, "Status: " .. S("Inactive"))
		table.insert(
			infotext_lines,
			"Note: "
				.. S(
					"To distill products, place the alembic over a clay pot filled with liquids and apply heat."
				)
		)
	end

	table.insert(infotext_lines, "Contents: " .. alembic_contents_text(inv))
	minimal.infotext_merge(pos, infotext_lines, meta)
end

function exile_alchemy.alembic_process(pos, elapsed)
	local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
	local below_node = minetest.get_node(below_pos)
	local process = exile_alchemy.get_alembic_process(below_node.name)
	local meta = minetest.get_meta(pos)

	if not process then
		meta:set_float("remaining", 0)
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	local temp = climate.get_point_temp(below_pos)
	if temp > exile_alchemy.alembic_max_temperature then
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	local time
	if temp > exile_alchemy.alembic_working_temperature then
		time = process.time
	else
		time = exile_alchemy.ambient_temperature_time
	end

	local remaining = math.max(0, (meta:get_float("remaining") or time) - elapsed)
	local inv = meta:get_inventory()

	if remaining <= 0 then
		for _, product in ipairs(process.products) do
			inv:add_item("main", product)
		end
		minetest.swap_node(below_pos, { name = process.subproduct })
		meta:set_float("remaining", time)
	else
		meta:set_float("remaining", remaining)
	end

	exile_alchemy.update_alembic_infotext(pos)
	return true
end
