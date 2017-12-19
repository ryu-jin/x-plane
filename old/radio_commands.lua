radio_commands_active = true

local var_com1 = 502
local var_com2 = 503
local active_com = 0
local var_nav_switch = 493
local var_nav_active = 1
local var_com_switch = 160
local var_com_active = 1
local var_stby = "stby_"
if PLANE_ICAO == "B733" then
	var_stby = "actv_"
else
	var_stby = "stby_"
end

--dataref("SimAvionics", "simcoders/rep/cockpit2/switches/avionics_power_on", "writable")
--dataref("Avionics", "simcoders/rep/cockpit2/switches/avionics_power_on", "writable")

function exec_silent(command)
    local p = assert(io.popen(command))
    local result = p:read("*all")
    p:close()
    return result
end

function exec_bg(command)
    os.execute(command)
end
--simcoders/rep/cockpit2/switches/avionics_power_on
--sim/cockpit2/switches/avionics_power_on
function radio_commands_event_handler()
	--if SimAvionics ~= Avionics then
	--	SimAvionics = Avionics
	--end
	if radio_commands_active then
		if not last_button(var_com1) and button(var_com1) then
			set_button_assignment( (4*40) + 1, "sim/radios/com1_standy_flip" )
			set_button_assignment( (4*40) + 2, "sim/radios/stby_com1_coarse_up" )
			set_button_assignment( (4*40) + 3, "sim/radios/stby_com1_coarse_down" )
			set_button_assignment( (4*40) + 4, "sim/radios/stby_com1_fine_up_833" )
			set_button_assignment( (4*40) + 5, "sim/radios/stby_com1_fine_down_833" )
			if active_com ~= var_com1 then
				exec_bg("START /B C:\\TRCOM1.vbs")
			end
			active_com = var_com1
			var_com_active = 1
		end
		if (button(var_com2)) then
			set_button_assignment( (4*40) + 1, "sim/radios/com2_standy_flip" )
			set_button_assignment( (4*40) + 2, "sim/radios/stby_com2_coarse_up" )
			set_button_assignment( (4*40) + 3, "sim/radios/stby_com2_coarse_down" )
			set_button_assignment( (4*40) + 4, "sim/radios/stby_com2_fine_up_833" )
			set_button_assignment( (4*40) + 5, "sim/radios/stby_com2_fine_down_833" )
			if active_com ~= var_com2 then
				exec_bg("START /B C:\\TRCOM2.vbs")
			end
			active_com = var_com2
			var_com_active = 2
		end
		if not last_button(var_nav_switch) and button(var_nav_switch) then
			if var_nav_active==2 then 
				set_button_assignment( (12*40) + 14, "sim/radios/nav1_standy_flip" )
				set_button_assignment( (12*40) + 15, "sim/radios/" .. var_stby .. "nav1_coarse_up" )
				set_button_assignment( (12*40) + 16, "sim/radios/" .. var_stby .. "nav1_coarse_down" )
				set_button_assignment( (12*40) + 17, "sim/radios/" .. var_stby .. "nav1_fine_up" )
				set_button_assignment( (12*40) + 18, "sim/radios/" .. var_stby .. "nav1_fine_down" )
				var_nav_active = 1
				exec_bg("START /B C:\\NAV1.vbs")
			elseif var_nav_active==1 then  
				set_button_assignment( (12*40) + 14, "sim/radios/nav2_standy_flip" )
				set_button_assignment( (12*40) + 15, "sim/radios/" .. var_stby .. "nav2_coarse_up" )
				set_button_assignment( (12*40) + 16, "sim/radios/" .. var_stby .. "nav2_coarse_down" )
				set_button_assignment( (12*40) + 17, "sim/radios/" .. var_stby .. "nav2_fine_up" )
				set_button_assignment( (12*40) + 18, "sim/radios/" .. var_stby .. "nav2_fine_down" )
				var_nav_active = 2
				exec_bg("START /B C:\\NAV2.vbs")
			end
		end
		if not last_button(var_com_switch) and button(var_com_switch) then
			if var_com_active==2 then 
				set_button_assignment( (4*40) + 1, "sim/radios/com1_standy_flip" )
				set_button_assignment( (4*40) + 2, "sim/radios/stby_com1_coarse_up" )
				set_button_assignment( (4*40) + 3, "sim/radios/stby_com1_coarse_down" )
				set_button_assignment( (4*40) + 4, "sim/radios/stby_com1_fine_up_833" )
				set_button_assignment( (4*40) + 5, "sim/radios/stby_com1_fine_down_833" )
				var_com_active = 1
				exec_bg("START /B C:\\RCOM1.vbs")
			elseif var_com_active==1 then  
				set_button_assignment( (4*40) + 1, "sim/radios/com2_standy_flip" )
				set_button_assignment( (4*40) + 2, "sim/radios/stby_com2_coarse_up" )
				set_button_assignment( (4*40) + 3, "sim/radios/stby_com2_coarse_down" )
				set_button_assignment( (4*40) + 4, "sim/radios/stby_com2_fine_up_833" )
				set_button_assignment( (4*40) + 5, "sim/radios/stby_com2_fine_down_833" )
				var_com_active = 2
				exec_bg("START /B C:\\RCOM2.vbs")
			end
		end
	end
end

do_every_frame("radio_commands_event_handler()")
add_macro("radio_commands", "radio_commands_active = true", "radio_commands_active = false", "activate")