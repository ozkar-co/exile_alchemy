-- creates the ceramic alembic node

local alambic_nodebox = {
  -- bottom pot
  { -0.25, -0.125, -0.25, 0.25, 0, 0.25 },
  { -0.375, -0.25, -0.375, 0.375, -0.125, 0.375 },
  { -0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125 },
  { -0.25, -0.5, -0.25, 0.25, -0.375, 0.25 },
  -- Top pot
  { -0.375, 0, -0.375, 0.375, 0.125, 0.375 },
  { -0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125 },
  { -0.1875, 0.25, -0.1875, 0.1875, 0.325, 0.1875 },
  { -0.0625, 0.325, -0.0625, 0.0625, 0.4, 0.0625 },
  -- Tube
  { -0.05, 0.4, -0.475, 0.05, 0.475, 0.025 },
  { -0.05, -0.2, -0.475, 0.05, 0.4, -0.4 },
  { -0.05, -0.2, -0.475, 0.05, -0.1, 0 },
}

local pot_nodebox = {
  { -0.25, 0.375, -0.25, 0.25, 0.5, 0.25 }, -- NodeBox1
  { -0.375, -0.25, -0.375, 0.375, 0.3125, 0.375 }, -- NodeBox2
  { -0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125 }, -- NodeBox3
  { -0.25, -0.5, -0.25, 0.25, -0.375, 0.25 }, -- NodeBox4
  { -0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125 }, -- NodeBox5
}

local mash_pile_nodebox = {
  { -0.3, -0.5, -0.3, 0.3, -0.3, 0.3 },
  { -0.25, -0.3, -0.25, 0.25, -0.1, 0.25 },
  { -0.2, -0.1, -0.2, 0.2, 0, 0.2 },
}

local smaller_mash_pile_nodebox = {
  { -0.25, -0.45, -0.25, 0.25, -0.3, 0.25 },
  { -0.2, -0.3, -0.2, 0.2, -0.15, 0.2 },
  { -0.15, -0.15, -0.15, 0.15, -0.05, 0.15 },
}

local clay_amphora_nodebox = {
  { -0.0625, 0.1875, -0.25, 0, 0.25, -0.0625 },
  { -0.0625, 0.125, -0.0625, 0.0625, 0.4375, 0.0625 },
  { -0.1875, 0.0625, -0.1875, 0.1875, 0.125, 0.1875 },
  { -0.25, 0, -0.25, 0.25, 0.0625, 0.25 },
  { -0.25, -0.3125, -0.25, 0.25, 0, 0.25 },
  { -0.1875, -0.375, -0.1875, 0.1875, -0.3125, 0.1875 },
  { -0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875 },
  { -0.125, -0.4375, -0.125, 0.125, -0.375, 0.125 },
  { -0.125, 0.125, -0.125, 0.125, 0.1875, 0.125 },
  { -0.125, 0.375, -0.125, 0.125, 0.4375, 0.125 },
  { -0.0625, -0.0625, -0.3125, 0, 0.25, -0.25 },
  { 0, -0.0625, 0.25, 0.0625, 0.25, 0.3125 },
  { 0, 0.1875, 0.0625, 0.0625, 0.25, 0.25 },
}

local clay_crucible_nodebox = {
  { -0.125, -0.5, -0.125, 0.125, -0.4375, 0.125 }, -- base
  { -0.125, -0.4375, 0.125, 0.125, -0.125, 0.1875 }, -- side1
  { -0.125, -0.4375, -0.1875, 0.125, -0.125, -0.125 }, -- side2
  { 0.125, -0.4375, -0.125, 0.1875, -0.125, 0.125 }, -- side3
  { -0.1875, -0.4375, -0.125, -0.125, -0.125, 0.125 }, -- side4
}

local clay_mortar_nodebox = {
  { -0.125, -0.5, -0.125, 0.125, -0.375, 0.125 }, -- base
  { -0.125, -0.375, 0.125, 0.125, 0, 0.25 }, -- side1
  { -0.125, -0.375, -0.25, 0.125, 0, -0.125 }, -- side2
  { 0.125, -0.375, -0.125, 0.25, 0, 0.125 }, -- side3
  { -0.25, -0.375, -0.125, -0.125, 0, 0.125 }, -- side4
  { -0.125, -0.4375, -0.125, 0, 0.125, 0 }, -- pestle
  { -0.1875, -0.4375, -0.1875, 0.1875, -0.3125, 0.1875 }, -- base2
  { -0.1875, -0.4375, -0.1875, -0.125, 0, 0.1875 }, -- side5
  { 0.125, -0.4375, -0.1875, 0.1875, 0, 0.1875 }, -- side6
}

local glass_retort_nodebox = {
  { 0.0625, -0.5, -0.1875, 0.375, -0.0625, 0.125 },
  { 0, -0.4375, -0.25, 0.4375, -0.125, 0.1875 },
  { -0.125, -0.1875, -0.125, 0.3125, 0, 0.0625 },
  { -0.25, -0.1875, -0.125, -0.125, -0.0625, 0.0625 },
  { -0.0625, -0.25, -0.125, 0, -0.1875, 0.0625 },
  { -0.3125, -0.25, -0.0625, -0.1875, -0.125, 0 },
  { -0.375, -0.25, -0.0625, -0.3125, -0.1875, 0 },
}

local glass_vessel_nodebox = {
  { -0.25, -0.5, -0.25, 0.25, -0.375, 0.25 },
  { -0.1875, -0.375, -0.1875, 0.1875, -0.1875, 0.1875 },
  { -0.125, -0.1875, -0.125, 0.125, -0.0625, 0.125 },
  { -0.0625, -0.0625, -0.0625, 0.0625, 0.125, 0.0625 },
  { -0.0625, 0.125, -0.125, 0.0625, 0.1875, 0.125 },
  { -0.125, 0.125, -0.0625, 0.125, 0.1875, 0.0625 },
}

local alchemy_bench_nodebox = {
  { -0.4375, 0, -0.4375, 0.4375, 0.125, 0.4375 }, -- top
  { -0.375, -0.5, -0.375, -0.25, 0, -0.25 }, -- leg4
  { -0.375, -0.5, 0.25, -0.25, 2.98023e-08, 0.375 }, -- leg3
  { 0.25, -0.5, 0.25, 0.375, 2.98023e-08, 0.375 }, -- leg2
  { 0.25, -0.5, -0.375, 0.375, 2.98023e-08, -0.25 }, -- leg1
  { -0.3125, -0.125, -0.3125, 0.3125, 1.49012e-08, 0.3125 }, -- apron
  { -0.3125, 0.125, -0.3125, -0.125, 0.1875, -0.125 }, -- retort1
  { 0.125, 0.125, 0.1875, 0.3125, 0.25, 0.375 }, -- crucible
  { -0.3125, 0.1875, -0.3125, -0.1875, 0.25, -0.125 }, -- retort2
  { -0.25, 0.25, -0.25, -0.125, 0.3125, -0.1875 }, -- retort3
  { -0.0625, 0.125, 0.0625, 0.125, 0.3125, 0.25 }, -- mortar
}

minetest.register_node("tech:alembic", {
  description = "Ceramic Alembic",
  drawtype = "nodebox",
  tiles = { "tech_pottery.png" },
  node_box = {
    type = "fixed",
    fixed = alambic_nodebox,
  },
  liquids_pointable = true,
  groups = { cracky = 3, oddly_breakable_by_hand = 3 },
  paramtype = "light",
  paramtype2 = "facedir",
  sounds = nodes_nature.node_sound_stone_defaults(),
  groups = { cracky = 3, oddly_breakable_by_hand = 3 },

  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    inv:set_size("main", alembic_inv_size)
    meta:set_string("formspec", get_alembic_formspec(pos))

    update_alembic_infotext(pos)

    local timer = minetest.get_node_timer(pos)
    timer:start(alembic_check_interval)
  end,

  on_timer = alembic_process,

  on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    local player_name = clicker:get_player_name()
    minetest.show_formspec(player_name, "composter:alembic", get_alembic_formspec(pos))
  end,

  on_destruct = function(pos)
    -- drops its contents when broken
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if inv then
      local items = inv:get_list("main")
      for _, item in ipairs(items) do
        if not item:is_empty() then
          minetest.add_item(pos, item)
        end
      end
    end
  end,

  allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
    return 0
  end,

  allow_metadata_inventory_put = function(pos, listname, index, stack, player)
    return 0
  end,
})

--unfired
minetest.register_node("tech:alembic_unfired", {
  description = S("Ceramic Alembic (unfired)"),
  tiles = {
    "nodes_nature_clay.png",
  },
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = alambic_nodebox,
  },
  groups = { dig_immediate = 3, temp_pass = 1, heatable = 20 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_construct = function(pos)
    --length(i.e. difficulty of firing), interval for checks (speed)
    ncrafting.set_firing(pos, base_firing, firing_int)
  end,
  on_timer = function(pos, elapsed)
    --finished product, length
    return ncrafting.fire_pottery(pos, "tech:alembic_unfired", "tech:alembic", base_firing)
  end,
})

--Pot of wiha must, must be left to ferment
minetest.register_node("tech:wiha_must_pot", {
  description = S("Wiha Must (unfermented)"),
  tiles = {
    "tech_pot_wiha_must.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),

  on_dig = function(pos, node, digger)
    -- save ferment progress
    if minetest.is_protected(pos, digger:get_player_name()) then
      return false
    end

    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")

    local new_stack = ItemStack("tech:wiha_must_pot")
    local stack_meta = new_stack:get_meta()
    stack_meta:set_int("ferment", ferment)

    minetest.remove_node(pos)
    local player_inv = digger:get_inventory()
    if player_inv:room_for_item("main", new_stack) then
      player_inv:add_item("main", new_stack)
    else
      minetest.add_item(pos, new_stack)
    end
  end,

  on_construct = function(pos)
    --duration of ferment
    local meta = minetest.get_meta(pos)
    meta:set_int("ferment", math.random(300, 360))
    --ferment
    minetest.get_node_timer(pos):start(5)
  end,

  after_place_node = function(pos, placer, itemstack, pointed_thing)
    local meta = minetest.get_meta(pos)
    local stack_meta = itemstack:get_meta()
    local ferment = stack_meta:get_int("ferment")
    if ferment > 0 then
      meta:set_int("ferment", ferment)
    end
  end,

  on_timer = function(pos, elapsed)
    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")
    if ferment < 1 then
      minetest.swap_node(pos, { name = "tech:wiha_cider_pot" })
      --minetest.check_for_falling(pos)
      return false
    else
      --ferment if at right temp
      local temp = climate.get_point_temp(pos)
      if temp > 10 and temp < 34 then
        meta:set_int("ferment", ferment - 1)
      end
      return true
    end
  end,
})

minetest.register_node("tech:wiha_cider_pot", {
  description = S("Wiha Cider"),
  tiles = {
    "tech_pot_wiha_cider.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})

minetest.register_node("tech:vinegar_pot", {
  description = S("Vinegar Pot"),
  tiles = {
    "tech_pot_vinegar.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})

-- wiha
minetest.register_node("tech:mashed_wiha", {
  description = S("Mashed Wiha"),
  tiles = { "tech_mashed_wiha.png" },
  inventory_image = "tech_mashed_wiha_inv.png",
  stack_max = minimal.stack_max_large,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = mash_pile_nodebox,
  },
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, edible = 1, compostable = 12 },
  sounds = nodes_nature.node_sound_dirt_defaults(),

  on_construct = function(pos)
    minetest.get_node_timer(pos):start(math.random(10, 20))
  end,
  on_timer = function(pos, elapsed)
    if climate.get_point_temp(pos) > 90 then
      minetest.swap_node(pos, { name = "tech:burnt_dregs" })
      return false
    end
    if math.random() > 0.9 then
      minimal.switch_node(pos, { name = "tech:wiha_dregs" })
      return false
    end
    return true
  end,
})

minetest.register_node("tech:wiha_dregs", {
  description = S("Wiha Dregs"),
  tiles = { "tech_wiha_dregs.png" },
  inventory_image = "tech_wiha_dregs_inv.png",
  stack_max = minimal.stack_max_large,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = smaller_mash_pile_nodebox,
  },
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, heatable = 100, compostable = 6 },
  sounds = nodes_nature.node_sound_dirt_defaults(),

  on_construct = function(pos)
    minetest.get_node_timer(pos):start(math.random(30, 60))
  end,
  on_timer = function(pos, elapsed)
    if climate.get_point_temp(pos) > 90 then
      minetest.swap_node(pos, { name = "tech:burnt_dregs" })
      return false
    end
    return true
  end,
})

minetest.register_node("tech:burnt_dregs", {
  description = S("Burnt Dregs"),
  tiles = { "tech_burnt_dregs.png" },
  inventory_image = "tech_burnt_dregs_inv.png",
  stack_max = minimal.stack_max_large,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = smaller_mash_pile_nodebox,
  },
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9, flammable = 1 },
  sounds = nodes_nature.node_sound_dirt_defaults(),

  on_burn = function(pos)
    if math.random() < 0.5 then
      minimal.switch_node(pos, { name = "tech:wood_ash" })
      minetest.check_for_falling(pos)
    else
      minetest.remove_node(pos)
    end
  end,
})

minetest.register_node("tech:crushed_basalt", {
  description = S("Crushed Basalt"),
  tiles = { "tech_crushed_basalt.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9 },
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:crushed_gneiss", {
  description = S("Crushed Gneiss"),
  tiles = { "tech_crushed_gneiss.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9 },
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:crushed_granite", {
  description = S("Crushed Granite"),
  tiles = { "tech_crushed_granite.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9 },
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:quartz_powder", {
  description = S("Quartz Powder"),
  tiles = { "tech_quartz_powder.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = { crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9 },
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

--------------------
-- Clay Equipment --
--------------------

minetest.register_node("tech:clay_crucible_unfired", {
  description = S("Elemental Crucible (unfired)"),
  tiles = {
    "nodes_nature_clay.png",
  },
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_crucible_nodebox,
  },
  groups = { dig_immediate = 3, temp_pass = 1, heatable = 20 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_construct = function(pos)
    --length(i.e. difficulty of firing), interval for checks (speed)
    ncrafting.set_firing(pos, base_firing, firing_int)
  end,
  on_timer = function(pos, elapsed)
    --finished product, length
    return ncrafting.fire_pottery(pos, "tech:clay_crucible_unfired", "tech:clay_crucible", base_firing)
  end,
})

minetest.register_node("tech:clay_crucible", {
  description = S("Elemental Crucible"),
  tiles = {
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_crucible_nodebox,
  },
  groups = { dig_immediate = 3, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})

minetest.register_node("tech:clay_mortar_unfired", {
  description = S("Alchemy Mortarium (unfired)"),
  tiles = {
    "nodes_nature_clay.png",
  },
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_mortar_nodebox,
  },
  groups = { dig_immediate = 3, temp_pass = 1, heatable = 20 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_construct = function(pos)
    --length(i.e. difficulty of firing), interval for checks (speed)
    ncrafting.set_firing(pos, base_firing, firing_int)
  end,
  on_timer = function(pos, elapsed)
    --finished product, length
    return ncrafting.fire_pottery(pos, "tech:clay_crucible_unfired", "tech:clay_mortar", base_firing)
  end,
})

minetest.register_node("tech:clay_mortar", {
  description = S("Alchemy Mortarium"),
  tiles = {
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_mortar_nodebox,
  },
  groups = { dig_immediate = 3, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})

---------------------
-- Glass Equipment --
---------------------

minetest.register_node("tech:glass_retort", {
  description = S("Glass Retort"),
  tiles = {
    "tech_clear_glass.png",
  },
  inventory_image = "tech_glass_retort_inv.png",
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = glass_retort_nodebox,
  },
  sunlight_prpagates = true,
  groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  use_texture_alpha = c_alpha.blend,
  selection_box = {
    type = "fixed",
    fixed = { -0.375, -0.5, -0.25, 0.4375, 0, 0.1875 },
  },
})

minetest.register_node("tech:glass_vessel", {
  description = S("Glass Vessel"),
  tiles = {
    "tech_clear_glass.png",
  },
  inventory_image = "tech_glass_vessel_inv.png",
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = glass_vessel_nodebox,
  },
  sunlight_prpagates = true,
  groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  use_texture_alpha = c_alpha.blend,
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, 0.1875, 0.3125 },
  },
})

--- Alchemy Bench

minetest.register_node("tech:alchemy_bench", {
  description = S("Alchemy Bench"),
  tiles = {
    "tech_alchemy_bench_top.png",
    "tech_alchemy_bench_bottom.png",
    "tech_alchemy_bench_side1.png",
    "tech_alchemy_bench_side2.png",
    "tech_alchemy_bench_side3.png",
    "tech_alchemy_bench_side4.png",
  },
  use_texture_alpha = c_alpha.blend,
  -- inventory_image = "tech_alchemy_bench_inv.png",
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = alchemy_bench_nodebox,
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("alchemy_bench", 2, { x = 8, y = 3 }),
})

minetest.register_node("tech:acrimoniac_amphora", {
  description = S("Acrimoniac Amphora"),
  tiles = {
    "tech_acrimoniac_amphora.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})

minetest.register_node("tech:vitriol_vessel", {
  description = S("Vitriol Vessel"),
  tiles = {
    "tech_vitriol_vessel_top.png",
    "tech_vitriol_vessel_bottom.png",
    "tech_vitriol_vessel_side.png",
  },
  inventory_image = "tech_vitriol_vessel_inv.png",
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = glass_vessel_nodebox,
  },
  sunlight_prpagates = true,
  groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  use_texture_alpha = c_alpha.blend,
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, 0.1875, 0.3125 },
  },
})

minetest.register_node("tech:elixir_vitae", {
  description = S("Elixir Vitae"),
  tiles = {
    "tech_elixir_vitae_top.png",
    "tech_elixir_vitae_bottom.png",
    "tech_elixir_vitae_side.png",
  },
  inventory_image = "tech_elixir_vitae_inv.png",
  drawtype = "nodebox",
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = glass_vessel_nodebox,
  },
  sunlight_prpagates = true,
  groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  use_texture_alpha = c_alpha.blend,
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, 0.1875, 0.3125 },
  },
})

minetest.register_node("tech:soap_uncured", {
  description = S("Soap (uncured)"),
  tiles = { "tech_soap_uncured.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16 },
  },
  groups = {
    snappy = 3,
    falling_node = 1,
    dig_immediate = 3,
  },
  sounds = nodes_nature.node_sound_dirt_defaults(),
  on_construct = function(pos)
    minetest.get_node_timer(pos):start(math.random(120, 300))
  end,
  on_timer = function(pos, elapsed)
    minetest.swap_node(pos, { name = "tech:soap" })
    return true
  end,
})

minetest.register_node("tech:soap", {
  description = S("Soap"),
  tiles = { "tech_soap.png" },
  stack_max = minimal.stack_max_heavy,
  paramtype = "light",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -3 / 16, -0.5, -2 / 16, 3 / 16, -4 / 16, 2 / 16 },
  },
  groups = {
    crumbly = 3,
    falling_node = 1,
    dig_immediate = 3,
  },
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

-- ferment sugar to get alcohol
minetest.register_node("tech:tartaris_syrup_amphora", {
  description = S("Tartaris Syrup (unfermented)"),
  tiles = {
    "tech_pot_tartaris_syrup.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),

  on_dig = function(pos, node, digger)
    -- save ferment progress
    if minetest.is_protected(pos, digger:get_player_name()) then
      return false
    end

    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")

    local new_stack = ItemStack("tech:tartaris_syrup_amphora")
    local stack_meta = new_stack:get_meta()
    stack_meta:set_int("ferment", ferment)

    minetest.remove_node(pos)
    local player_inv = digger:get_inventory()
    if player_inv:room_for_item("main", new_stack) then
      player_inv:add_item("main", new_stack)
    else
      minetest.add_item(pos, new_stack)
    end
  end,

  on_construct = function(pos)
    --duration of ferment
    local meta = minetest.get_meta(pos)
    meta:set_int("ferment", math.random(300, 360))
    --ferment
    minetest.get_node_timer(pos):start(5)
  end,

  after_place_node = function(pos, placer, itemstack, pointed_thing)
    local meta = minetest.get_meta(pos)
    local stack_meta = itemstack:get_meta()
    local ferment = stack_meta:get_int("ferment")
    if ferment > 0 then
      meta:set_int("ferment", ferment)
    end
  end,

  on_timer = function(pos, elapsed)
    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")
    if ferment < 1 then
      minetest.swap_node(pos, { name = "tech:fermented_tartaris_syrup_amphora" })
      --minetest.check_for_falling(pos)
      return false
    else
      --ferment if at right temp
      local temp = climate.get_point_temp(pos)
      if temp > 10 and temp < 34 then
        meta:set_int("ferment", ferment - 1)
      end
      return true
    end
  end,
})

minetest.register_node("tech:fermented_tartaris_syrup_amphora", {
  description = S("Fermented Tartaris Syrup"),
  tiles = {
    "tech_pot_fermented_tartaris_syrup.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
  },
  drawtype = "nodebox",
  stack_max = 1, --minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = clay_amphora_nodebox,
  },
  groups = { dig_immediate = 3, pottery = 1, temp_pass = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
})
