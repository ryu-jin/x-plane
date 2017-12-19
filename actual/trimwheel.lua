------------------------------------------------------
-- Sync Saitek Trim Wheel Whe AP is engaged in IXEG 737
------------------------------------------------------
-- Specify your Saitek Wheel ID here
-----------------------------------
local trim_wheel_id  = 50
------------------------
DataRef("xp_elv_trim", "sim/flightmodel/controls/elv_trim", "writable")
DataRef("trim_wheel", "sim/joystick/joystick_axis_values", "readonly", trim_wheel_id)
if PLANE_ICAO == "B733" then
	DataRef("autopilot_A", "ixeg/733/MCP/mcp_a_comm_ann", "readonly")
	DataRef("autopilot_B", "ixeg/733/MCP/mcp_b_comm_ann", "readonly")
	local autopilot_C = 0
elseif PLANE_ICAO == "PA28" then
	DataRef("autopilot_C", "sim/cockpit2/annunciators/autopilot", "readonly")
	DataRef("autopilot_altm", "sim/cockpit2/autopilot/altitude_hold_status", "readonly")
	local autopilot_B = 0
end

local not_synced = 0
local ap_engaged = 0
local sound_time = 0
local last_wheel_pos = trim_wheel

function disable_trim_wheel()
	set_axis_assignment( trim_wheel_id, "none", "normal" )
end

function calcTrim()
	res = -1 + (trim_wheel*2)
	return res
end

function sync_trim()
	s_trim_wheel = string.format("%.5f", trim_wheel)
	--if (autopilot_A == 1 or autopilot_B == 1 or (autopilot_altm == 6 and autopilot_C == 1)) then
	if (autopilot_A == 1 or autopilot_B == 1 or  autopilot_C == 1) then
	--if (autopilot_A == 1 or autopilot_B == 1 or  autopilot_altm > 0) then
		ap_engaged = 1
		not_synced = 1
	--elseif (autopilot_altm == 6 and autopilot_C == 0) then
	--	ap_engaged = 0
	else
		ap_engaged = 0
	end

	if (not_synced == 0 and ap_engaged == 0) then
		if math.abs(trim_wheel - last_wheel_pos) > 0.00001 then
			xp_elv_trim = calcTrim()
			last_wheel_pos = trim_wheel
		end
	elseif (not_synced == 1 and ap_engaged == 0) then
				if math.abs(calcTrim()) - math.abs(xp_elv_trim) < 0.00001 then
					trim_sound = load_WAV_file("Resources/plugins/FlyWithLua/sounds/synchronized.wav")
					play_sound(trim_sound)
					not_synced = 0
				else
					if xp_elv_trim > calcTrim() then
						if os.clock() > sound_time then
							trim_sound = load_WAV_file("Resources/plugins/FlyWithLua/sounds/trimup.wav")
							play_sound(trim_sound)
							play_trim_up = 0
							sound_time = os.clock() + 5
						end
					else
						if os.clock() > sound_time then
							trim_sound = load_WAV_file("Resources/plugins/FlyWithLua/sounds/trimdown.wav")
						  	play_sound(trim_sound)
							play_trim_down = 0
							sound_time = os.clock() + 5
						end
					end
				end
	end
end
if (PLANE_ICAO == "B733" or  PLANE_ICAO == "PA28" or  PLANE_ICAO == "PA18") then
	disable_trim_wheel()
	do_every_frame("sync_trim()")
end
	