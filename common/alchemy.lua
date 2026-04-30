--[[

Processes:

calcination, distillation, dissolution, fermentation, mixing.

Code Names:

Osidian: Nightstone
Olivine: Peridot
Sulfur: Brimstone
Zeolites: Nephritic Stone
Sulfuric Acid: Vitriol
Alumina: Star Dust
Potassium Carbonate: Tartar Salt
Potassium Nitrate: Saltpeter
Gunpowder: Serpentine
Caustic Slurry: Acrimoniac
Caustic Soda: Death Salt
Feldspar: Aurifex
Vermicastings: Terra Essence
Amonia: Primordial Soil Extract
Alchemical Fertilizer: Terravita Tonic
Sulfa drug: Panacea
Thermite: Pyroforge Synthesis
Aluminium Sulfide: Inferno Igniter
Alchemical Fuel: Alchymia Flamis
Nitric Acid: Nitorium Nitrum
Aqua Regia: Alkahest



-- Alembic

The alembic is a device used to distill products from liquids stored in clay
pots. It can operate at temperatures higher than the given temperature
(default = 100°C), but it can also work at ambient temperature, taking much
longer (default = 300 seconds, 5 minutes).

Each process involves a source, which is the clay pot located under the alembic.
The process takes a specific amount of time and produces a certain number of
products, leaving the subproduct in the clay pot. A single process can produce
multiple products, but only one subproduct.

If there isn't enough space in the alembic's inventory, any additional products
will be lost. The alembic has a set number of inventory slots (default = 4) and
doesn't have a GUI. Products can be retrieved by right-clicking the alembic or
by removing it.


]]

alembic_inv_size = 4 -- slots
alembic_check_interval = 20 -- seconds
alembic_working_temperature = 100 -- celcius
ambient_temperature_time = 300 -- seconds

alembic_processes = {
    -- source: products, subproduct and time in seconds
    ["tech:clay_water_pot_salt_water"] = {
        products = { "tech:salt 2" },
        subproduct = "tech:clay_water_pot_freshwater",
        time = 120,
    },
    ["tech:tang"] = {
        products = { "tech:alcohol 1" },
        subproduct = "tech:clay_amphora_freshwater",
        time = 180,
    },
    ["tech:clay_water_pot_freshwater"] = {
        products = {},
        subproduct = "tech:clay_water_pot",
        time = 60,
    },
    ["tech:wiha_must_pot"] = {
        products = { "tech:sugar 12" },
        subproduct = "tech:clay_amphora_freshwater",
        time = 90,
    },
    ["tech:wiha_cider_pot"] = {
        products = { "tech:wiha_dregs" },
        subproduct = "tech:vinegar_pot",
        time = 150,
    },
    ["tech:acrimoniac_amphora"] = {
        products = { "tech:death_salt" },
        subproduct = "tech:clay_amphora",
        time = 150,
    },
    ["tech:tartaris_syrup_amphora"] = {
        products = { "tech:alcohol 12" },
        subproduct = "tech:clay_amphora",
        time = 150,
    },
    ["tech:tang_unfermented"] = {
        products = { "tech:sugar 12" },
        subproduct = "tech:clay_amphora_freshwater",
        time = 90,
    },
    ["tech:clay_water_pot_potash"] = {
        products = { "tech:potash" },
        subproduct = "tech:clay_water_pot",
        time = 60,
    },
}

function get_alembic_formspec(pos)
    local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
    local below_node = minetest.get_node(below_pos)
    if alembic_processes[below_node.name] then
        process = minetest.registered_items[below_node.name].description
    else
        process = "Nothing"
    end
    local formspec = "size[8,4.8]"
        .. "label[0,0;Processing: "
        .. process
        .. "]"
        .. "list[current_name;main;3,0.7;2,2]"
        .. "list[current_player;main;0,3;8,4;]"
        .. "listring[current_name;main]"
        .. "listring[current_player;main]"
    return formspec
end

function alembic_process(pos, elapsed)
    -- get block under alembic
    local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
    local below_node = minetest.get_node(below_pos)

    -- get current temperature of the below block
    local temp = climate.get_point_temp(below_pos, below_node)

    -- only continue if the block below is a clay pot with a valid source
    local process = alembic_processes[below_node.name]
    if not process then
        update_alembic_infotext(pos)
        -- stop the execution and try again later
        return true
    end

    -- determine time based on temperature
    local time
    if temp > alembic_working_temperature then
        time = process.time
    else
        time = ambient_temperature_time
    end

    -- take meta and inventory
    local meta = minetest.get_meta(pos)
    local remaining = math.max(0, (meta:get_float("remaining") or time) - elapsed)
    local inv = meta:get_inventory()

    -- if time elapsed, replace below block
    if remaining <= 0 then
        for _, product in ipairs(process.products) do
            inv:add_item("main", product)
        end
        minetest.swap_node(below_pos, { name = process.subproduct })
        meta:set_float("remaining", time)
    else
        meta:set_float("remaining", remaining)
    end
    update_alembic_infotext(pos)
    -- keep the timer running
    return true
end

function update_alembic_infotext(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local infotext = ""
    -- get block under alembic
    local below_pos = { x = pos.x, y = pos.y - 1, z = pos.z }
    local below_node = minetest.get_node(below_pos)
    -- if below node is processable add info to infotext
    if alembic_processes[below_node.name] then
        infotext = S("Processing ") .. minetest.registered_items[below_node.name].description .. "."
        minimal.infotext_set_key(pos, "Status", infotext)
        minimal.infotext_del_key(pos, "Note")
    else
        -- if below node is not processable add default note to infotext
        infotext = S("To distill products, place the alembic over a clay pot filled with liquids and apply heat.")
        minimal.infotext_set_key(pos, "Note", infotext)
        minimal.infotext_set_key(pos, "Status", S("Inactive"))
    end
    -- add inventory info to the infotext
    if inv:is_empty("main") then
        infotext = S("empty")
    else
        infotext = ""
        --loop through each slot in the alembic inventory
        for i = 1, inv:get_size("main") do
            local stack = inv:get_stack("main", i)
            if not stack:is_empty() then
                infotext = infotext
                    .. stack:get_count()
                    .. " "
                    .. minetest.registered_items[stack:get_name()].description
                    .. ". "
            end
        end
    end
    minimal.infotext_set_key(pos, "Contents", infotext)
end
