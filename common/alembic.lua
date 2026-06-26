local S = minetest.get_translator("exile_alchemy")

exile_alchemy.alembic_inv_size = 4
exile_alchemy.alembic_check_interval = 20
exile_alchemy.alembic_working_temperature = 100
exile_alchemy.alembic_max_temperature = 200

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

local function product_item_name(product_str)
	return product_str:match("^(%S+)")
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

local function alembic_inv_matches_process(inv, process)
	if inv:is_empty("main") then
		return true
	end
	local expected = product_item_name(process.products[1])
	for i = 1, inv:get_size("main") do
		local stack = inv:get_stack("main", i)
		if not stack:is_empty() and stack:get_name() ~= expected then
			return false
		end
	end
	return true
end

local function alembic_has_room(inv, process)
	for _, product in ipairs(process.products) do
		if not inv:room_for_item("main", product) then
			return false
		end
	end
	return true
end

function exile_alchemy.alembic_on_infotext(_pos, nodedef, meta, params)
	params = EXILE.infotext_update_params(meta, params)
	params.description = nodedef.description
	params = EXILE.infotext_get_base_params(nil, meta, params)
	params.status_string = params.status_string or ""
	params.contents_string = params.contents_string or ""
	if params.note == "nil" then
		params.note = nil
	end
	return params.status_string
		.. (params.owner and params.owner ~= "" and "\n" .. params.owner or "")
		.. (params.contents_string ~= "" and "\n" .. params.contents_string or "")
		.. (params.note and "\n" .. params.note or "")
end

function exile_alchemy.update_alembic_infotext(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
	local below_node = minetest.get_node(below_pos)
	local process = exile_alchemy.get_alembic_process(below_node.name)
	local temp = climate.get_point_temp(below_pos)
	local status_string
	local note

	if process then
		note = "nil"
		if not alembic_inv_matches_process(inv, process) then
			status_string = "Status: " .. S("Wrong product in alembic")
		elseif not alembic_has_room(inv, process) then
			status_string = "Status: " .. S("Alembic full")
		elseif temp > exile_alchemy.alembic_max_temperature then
			status_string = "Status: " .. S("Temperature too high")
		elseif temp <= exile_alchemy.alembic_working_temperature then
			status_string = "Status: " .. S("Temperature too low")
		else
			status_string = "Status: " .. S("Processing @1", process.product_label)
		end
	else
		status_string = "Status: " .. S("Inactive")
		note = "Note: "
			.. S(
				"To distill products, place the alembic over a clay pot filled with liquids and apply heat."
			)
	end

	meta:set_string("status_string", status_string)
	meta:set_string("contents_string", "Contents: " .. alembic_contents_text(inv))
	meta:set_string("note", note or "nil")
	EXILE.infotext_set_new(pos, meta)
end

function exile_alchemy.alembic_process(pos, elapsed)
	local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
	local below_node = minetest.get_node(below_pos)
	local process = exile_alchemy.get_alembic_process(below_node.name)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	if not process then
		meta:set_float("remaining", 0)
		meta:set_string("process_source", "")
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	local temp = climate.get_point_temp(below_pos)
	if temp > exile_alchemy.alembic_max_temperature or temp <= exile_alchemy.alembic_working_temperature then
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	if not alembic_inv_matches_process(inv, process) then
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	if not alembic_has_room(inv, process) then
		exile_alchemy.update_alembic_infotext(pos)
		return true
	end

	local source = below_node.name
	if meta:get_string("process_source") ~= source then
		meta:set_string("process_source", source)
		meta:set_float("remaining", process.time)
	end

	local remaining = meta:get_float("remaining")
	if remaining <= 0 then
		remaining = process.time
	end

	remaining = remaining - elapsed

	if remaining <= 0 then
		for _, product in ipairs(process.products) do
			inv:add_item("main", product)
		end
		minetest.swap_node(below_pos, { name = process.subproduct })
		meta:set_float("remaining", process.time)
		meta:set_string("process_source", "")
	else
		meta:set_float("remaining", remaining)
	end

	exile_alchemy.update_alembic_infotext(pos)
	return true
end
