gas_condenser_recipes ={}

register_gas_condenser_recipe = function(src, dst)
				   gas_condenser_recipes[src] = dst
				end

-- Receive an ItemStack of result by an ItemStack input
get_gas_condenser_recipe = function(itemstack)
				local src_item  = itemstack:to_table()
				if src_item == nil then
				   return nil
				end
				local item_name = src_item["name"]
				if gas_condenser_recipes[item_name] then
				   return ItemStack(gas_condenser_recipes[item_name])
				else
				   return nil
				end
			     end

minetest.register_alias("gas condenser", "chemistry:gas_condenser")
minetest.register_craft({
			   output = 'chemistry:gas_condenser',
			   recipe = {
			      {'default:stone', 'default:glass', 'default:stone'},
			      {'technic:dewar_vessel', 'technic:motor', 'technic:dewar_vessel'},
			      {'default:stone', 'technic:mv_cable', 'default:stone'},
			   }
			})

minetest.register_craftitem("chemistry:gas_condenser", {
			       description = "Gas Condenser",
			       stack_max = 99,
			    })

local gas_condenser_formspec =
   "invsize[8,9;]"..
   "list[current_name;src;3,1;1,1;]"..
   "list[current_name;dst;3,3;1,1;]"..
   "list[current_player;main;0,5;8,4;]"..
   "label[0,0;Gas Condenser]"

register_gas_condenser_recipe ("chemistry:nitrogen","chemistry:nitrogen_dewar_vessel")

minetest.register_node(
   "chemistry:gas_condenser",
   {
      description = "Gas Condenser",
      tiles = {"chemistry_distiller_top.png", "chemistry_distiller_bottom.png", "chemistry_gas_condenser.png",
	       "chemistry_gas_condenser.png", "chemistry_gas_condenser.png", "chemistry_gas_condenser.png"},
      paramtype2 = "facedir",
      groups = {cracky=2},
      legacy_facedir_simple = true,
      sounds = default.node_sound_wood_defaults(),
      on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("infotext", "Gas Condenser")
			meta:set_float("technic_power_machine", 1)
			meta:set_string("formspec", gas_condenser_formspec)
			local inv = meta:get_inventory()
			inv:set_size("src", 1)
			inv:set_size("dst", 1)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
   })

minetest.register_node(
   "chemistry:gas_condenser_active",
   {
      description = "Gas Condenser",
      tiles = {"chemistry_distiller_top.png", "chemistry_distiller_bottom.png", "chemistry_gas_condenser.png",
	       "chemistry_gas_condenser.png", "chemistry_gas_condenser.png", "chemistry_gas_condenser.png"},
      paramtype2 = "facedir",
      groups = {cracky=2,not_in_creative_inventory=1},
      legacy_facedir_simple = true,
      sounds = default.node_sound_wood_defaults(),
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
   })

minetest.register_abm(
   { nodenames = {"chemistry:gas_condenser","chemistry:gas_condenser_active"},
     interval = 1,
     chance   = 1,
     action = function(pos, node, active_object_count, active_object_count_wider)
		 -- Run a machine through its states. Takes the same arguments as the ABM action
		 -- and adds the machine's states and any extra data which is needed by the machine.
		 -- A machine is characterized by running through a set number of states (usually 2:
		 -- Idle and active) in some order. A state decides when to move to the next one
		 -- and the machine only changes state if it is powered correctly.
		 -- The machine will automatically shut down if disconnected from power in some fashion.
		 local meta         = minetest.env:get_meta(pos)
		 local eu_input     = meta:get_int("MV_EU_input")
		 local state        = meta:get_int("state")
		 local next_state   = state

		 -- Machine information
		 local machine_name         = "Gas Condenser"
		 local machine_node         = "chemistry:gas_condenser"
		 local machine_state_demand = { 100, 500 }
			 
		 -- Setup meta data if it does not exist. state is used as an indicator of this
		 if state == 0 then
		    meta:set_int("state", 1)
		    meta:set_int("MV_EU_demand", machine_state_demand[1])
		    meta:set_int("MV_EU_input", 0)
		    return
		 end
			 
		 -- Power off automatically if no longer connected to a switching station
		 technic.switching_station_timeout_count(pos, "MV")
			 
		 -- State machine
		 if eu_input == 0 then
		    -- unpowered - go idle
		    hacky_swap_node(pos, machine_node)
		    meta:set_string("infotext", machine_name.." Unpowered")
		    next_state = 1
		 elseif eu_input == machine_state_demand[state] then
		    -- Powered - do the state specific actions
			    
		    local inv    = meta:get_inventory()
		    local empty  = inv:is_empty("src")

		    if state == 1 then
		       hacky_swap_node(pos, machine_node)
		       meta:set_string("infotext", machine_name.." Idle")

		       local result = get_gas_condenser_recipe(inv:get_stack("src",1))
		       if not empty and result then
			  meta:set_int("src_time", 0)
			  next_state = 2
		       end

		    elseif state == 2 then
		       hacky_swap_node(pos, machine_node.."_active")
		       meta:set_string("infotext", machine_name.." Active")

		       if empty then
			  next_state = 1
		       else
			  meta:set_int("src_time", meta:get_int("src_time") + 1)
			  if meta:get_int("src_time") == 2 then -- 2 ticks per output
			     -- check if there's room for output in "dst" list
			     local result = get_gas_condenser_recipe(inv:get_stack("src",1))
			     meta:set_int("src_time", 0)
			local dststack = inv:get_stack("dst", 1)
			dst_item=dststack:to_table()
			if dst_item["name"] == "chemistry:nitrogen_dewar_vessel" then
minetest.debug("dewar fill")
				if dststack:get_wear()-(65355/100) > 0 then
				minetest.debug("dewar fill2")
				srcstack = inv:get_stack("src", 1)
				srcstack:take_item()
				inv:set_stack("src", 1, srcstack)
				dst_item["wear"]=tostring(math.floor(dststack:get_wear()-(65355/100)))
			  inv:set_stack("dst", 1, dst_item)

					else
					next_state = 1
			dst_item["wear"]=tostring(0)
			  inv:set_stack("dst", 1, dst_item)
				end 
			   elseif dst_item["name"] == "chemistry:dewar_vessel" then
				minetest.debug("dewar empty")
				-- take stuff from "src" list
				srcstack = inv:get_stack("src", 1)
				srcstack:take_item()
				inv:set_stack("src", 1, srcstack)
				dststack = inv:get_stack("dst", 1)
				dststack:clear()
				inv:set_stack("dst", 1, dststack)
				-- Put result in "dst" list
				inv:add_item("dst", result)
				local dststack = inv:get_stack("dst", 1)
				dst_item=dststack:to_table()
				dst_item["wear"]=tostring(math.floor(65355-(65355/100)))
				inv:set_stack("dst", 1, dst_item)
			     else 
				-- all full: go idle
				next_state = 1
			     end
			  end
		       end
		    end
		 end
		 -- Change state?
		 if next_state ~= state then
		    meta:set_int("MV_EU_demand", machine_state_demand[next_state])
		    meta:set_int("state", next_state)
		 end
	      end
  })

technic.register_MV_machine ("chemistry:gas_condenser","RE")
technic.register_MV_machine ("chemistry:gas_condenser_active","RE")