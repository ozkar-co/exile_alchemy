local modpath = minetest.get_modpath(minetest.get_current_modname())

exile_alchemy = rawget(_G, "exile_alchemy") or {}

dofile(modpath .. "/nodes/nodeboxes.lua")
dofile(modpath .. "/common/fermentation.lua")
dofile(modpath .. "/common/alembic.lua")
dofile(modpath .. "/items/basic.lua")
dofile(modpath .. "/items/mashed_wiha.lua")
dofile(modpath .. "/nodes/alembic.lua")
dofile(modpath .. "/nodes/wiha.lua")
dofile(modpath .. "/crafts/recipes.lua")
