local random = math.random

exile_alchemy.FERMENT_INTERVAL = 5
exile_alchemy.FERMENT_MIN = 300
exile_alchemy.FERMENT_MAX = 360
exile_alchemy.FERMENT_TEMP_MIN = 10
exile_alchemy.FERMENT_TEMP_MAX = 34

function exile_alchemy.get_or_create_ferment(meta)
	local ferment = meta:get_int("ferment")
	if ferment == 0 then
		ferment = random(exile_alchemy.FERMENT_MIN, exile_alchemy.FERMENT_MAX)
	end
	return ferment
end

function exile_alchemy.new_ferment_budget()
	return random(exile_alchemy.FERMENT_MIN, exile_alchemy.FERMENT_MAX)
end

function exile_alchemy.ferment_tick(pos)
	local meta = minetest.get_meta(pos)
	local ferment = meta:get_int("ferment")
	if ferment < 1 then
		return true
	end
	local temp = climate.get_point_temp(pos)
	if temp > exile_alchemy.FERMENT_TEMP_MIN and temp < exile_alchemy.FERMENT_TEMP_MAX then
		meta:set_int("ferment", ferment - 1)
	end
	return true
end

function exile_alchemy.on_dig_preserve_ferment(pos, digger, nodename)
	if minetest.is_protected(pos, digger:get_player_name()) then
		return false
	end

	local meta = minetest.get_meta(pos)
	local ferment = exile_alchemy.get_or_create_ferment(meta)

	local new_stack = ItemStack(nodename)
	new_stack:get_meta():set_int("ferment", ferment)

	minetest.remove_node(pos)
	local player_inv = digger:get_inventory()
	if player_inv:room_for_item("main", new_stack) then
		player_inv:add_item("main", new_stack)
	else
		minetest.add_item(pos, new_stack)
	end
end

function exile_alchemy.after_place_restore_ferment(pos, itemstack)
	local stack_meta = itemstack:get_meta()
	local ferment = stack_meta:get_int("ferment")
	if ferment > 0 then
		minetest.get_meta(pos):set_int("ferment", ferment)
	end
end

function exile_alchemy.preserve_metadata_ferment(pos, oldnode, oldmeta, transferred_stack)
	transferred_stack:get_meta():set_int(
		"ferment",
		exile_alchemy.get_or_create_ferment(oldmeta)
	)
end

function exile_alchemy.on_construct_ferment(pos)
	local meta = minetest.get_meta(pos)
	meta:set_int("ferment", exile_alchemy.new_ferment_budget())
	minetest.get_node_timer(pos):start(exile_alchemy.FERMENT_INTERVAL)
end

function exile_alchemy.start_ferment_at(pos, ferment)
	local meta = minetest.get_meta(pos)
	meta:set_int("ferment", ferment or exile_alchemy.new_ferment_budget())
	minetest.get_node_timer(pos):start(exile_alchemy.FERMENT_INTERVAL)
end

function exile_alchemy.register_ferment_overrides(nodename, opts)
	opts = opts or {}

	minetest.override_item(nodename, {
		on_dig = function(pos, node, digger)
			exile_alchemy.on_dig_preserve_ferment(pos, digger, nodename)
		end,

		on_construct = function(pos)
			exile_alchemy.on_construct_ferment(pos)
		end,

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			exile_alchemy.after_place_restore_ferment(pos, itemstack)
		end,

		on_timer = function(pos, elapsed)
			local meta = minetest.get_meta(pos)
			local ferment = meta:get_int("ferment")
			if ferment < 1 then
				if opts.on_complete then
					opts.on_complete(pos)
				end
				return false
			end
			exile_alchemy.ferment_tick(pos)
			return true
		end,

		_preserve_metadata = function(pos, oldnode, oldmeta, transferred_stack)
			exile_alchemy.preserve_metadata_ferment(pos, oldnode, oldmeta, transferred_stack)
		end,
	})
end
