-- FIX FOR PRIVATE DATAREF --
local ffi = require("ffi")
local XPLM = nil
local XPLMlib = "XPLM"
if SYSTEM_ARCHITECTURE == 64 then
	if SYSTEM == "IBM" then
		XPLMlib = "XPLM_64"
	elseif SYSTEM == "LIN" then
		XPLMlib = "Resources/plugins/XPLM_64.so"
	else
		XPLMlib = "Resources/plugins/XPLM.framework/XPLM"
	end
else
	if SYSTEM == "IBM" then
		XPLMlib = "XPLM"
	elseif SYSTEM == "LIN" then
		XPLMlib = "Resources/plugins/XPLM.so"
	else
		XPLMlib = "Resources/plugins/XPLM.framework/XPLM"
	end
end
XPLM = ffi.load(XPLMlib)
ffi.cdef("typedef void * XPLMDataRef;")
ffi.cdef("XPLMDataRef XPLMFindDataRef(const char * inDataRefName);")
ffi.cdef("int XPLMGetDatai(XPLMDataRef inDataRef);")
ffi.cdef("void XPLMSetDatai(XPLMDataRef inDataRef, int inValue);")
ffi.cdef("float XPLMGetDataf(XPLMDataRef inDataRef);")
ffi.cdef("void XPLMSetDataf(XPLMDataRef inDataRef, float inValue);")
ffi.cdef("double XPLMGetDatad(XPLMDataRef inDataRef);")
ffi.cdef("void XPLMSetDatad(XPLMDataRef inDataRef, double inValue);")

function findDataref(drName)
    return XPLM.XPLMFindDataRef(drName)
end
function setDatai(handle, value)
    XPLM.XPLMSetDatai(handle, value)
end

function getDatai(handle)
    return XPLM.XPLMGetDatai(handle)
end

function setDataf(handle, value)
    XPLM.XPLMSetDataf(handle, value)
end

function getDataf(handle)
    return XPLM.XPLMGetDataf(handle)
end

function setDatad(handle, value)
    XPLM.XPLMSetDatad(handle, value)
end

function getDatad(handle)
    return XPLM.XPLMGetDatad(handle)
end

csm = findDataref("sim/private/controls/caps/use_csm")
setDataf(csm, 0.000000)
sp = findDataref("sim/private/controls/perf/disable_shadow_prep")
setDataf(sp, 0.000000)
LOD_bias_rat = findDataref("sim/private/controls/reno/LOD_bias_rat")
setDataf(LOD_bias_rat, 0.6)
fade_rat = findDataref("sim/private/controls/terrain/fade_start_rat")
setDataf(fade_rat, 1.0)
---

--- JOY SETTINGS ---

-- if PLANE_ICAO == "DC6" then

	-- clear_all_axis_assignments()
	-- set_axis_assignment( 25, "flaps", "normal" )
	-- set_axis_assignment( 50, "elev trim", "normal" )
	-- set_axis_assignment( 75, "pitch", "normal" )
	-- set_axis_assignment( 76, "roll", "normal" )
	-- set_axis_assignment( 78, "prop", "reverse" )
	-- set_axis_assignment( 79, "throttle", "normal" )
	-- set_axis_assignment( 100, "right toe brake", "normal" )
	-- set_axis_assignment( 101, "left toe brake", "normal" )
	-- set_axis_assignment( 102, "yaw", "normal" )
	-- set_axis_assignment( 126, "nosewheel tiller", "normal" )

	-- clear_all_button_assignments()
	-- set_button_assignment( (0*40) + 0, "sim/autopilot/servos_toggle" )
	-- set_button_assignment( (0*40) + 2, "sim/flight_controls/pitch_trim_down" )
	-- set_button_assignment( (0*40) + 4, "PMDG_DC6/autopilot/gyropilot_toggle" )
	-- set_button_assignment( (0*40) + 5, "PMDG_DC6/autopilot/mechanical_disconnect_toggle" )
	-- set_button_assignment( (0*40) + 6, "PMDG_DC6/autopilot/altitude_control_toggle" )
	-- set_button_assignment( (0*40) + 8, "PMDG_DC6/autopilot/pitch_wheel_back" )
	-- set_button_assignment( (0*40) + 9, "PMDG_DC6/autopilot/pitch_wheel_fwd" )
	-- set_button_assignment( (0*40) + 10, "PMDG_DC6/autopilot/mode_localizer" )
	-- set_button_assignment( (0*40) + 11, "PMDG_DC6/autopilot/mode_approach" )
	-- set_button_assignment( (4*40) + 1, "sim/radios/com1_standy_flip" )
	-- set_button_assignment( (4*40) + 2, "sim/radios/stby_com1_coarse_up" )
	-- set_button_assignment( (4*40) + 3, "sim/radios/stby_com1_coarse_down" )
	-- set_button_assignment( (4*40) + 4, "sim/radios/stby_com1_fine_up_833" )
	-- set_button_assignment( (4*40) + 5, "sim/radios/stby_com1_fine_down_833" )
	-- set_button_assignment( (12*40) + 0, "sim/operation/contact_atc" )
	-- set_button_assignment( (12*40) + 4, "PMDG_DC6/autopilot/turn_knob_center" )
	-- set_button_assignment( (12*40) + 5, "PMDG_DC6/autopilot/mode_gyropilot" )
	-- set_button_assignment( (12*40) + 6, "sim/radios/obs1_down" )
	-- set_button_assignment( (12*40) + 7, "sim/radios/obs1_up" )
	-- set_button_assignment( (12*40) + 11, "PMDG_DC6/autopilot/turn_knob_left" )
	-- set_button_assignment( (12*40) + 12, "PMDG_DC6/autopilot/turn_knob_right" )
	-- set_button_assignment( (12*40) + 14, "sim/radios/nav1_standy_flip" )
	-- set_button_assignment( (12*40) + 15, "sim/radios/stby_nav1_coarse_up" )
	-- set_button_assignment( (12*40) + 16, "sim/radios/stby_nav1_coarse_down" )
	-- set_button_assignment( (12*40) + 17, "sim/radios/stby_nav1_fine_up" )
	-- set_button_assignment( (12*40) + 18, "sim/radios/stby_nav1_fine_down" )
	-- set_button_assignment( (12*40) + 20, "sim/engines/thrust_reverse_hold" )
	-- set_button_assignment( (12*40) + 22, "sim/audio_panel/transmit_audio_com1" )
	-- set_button_assignment( (12*40) + 23, "sim/audio_panel/transmit_audio_com2" )
	-- set_button_assignment( (12*40) + 25, "sim/GPS/g430n1_chapter_up" )
	-- set_button_assignment( (12*40) + 27, "sim/GPS/g430n1_page_up" )
	-- set_button_assignment( (12*40) + 29, "sim/GPS/g430n1_chapter_dn" )
	-- set_button_assignment( (12*40) + 31, "sim/GPS/g430n1_page_dn" )
	-- set_button_assignment( (20*40) + 0, "sim/radios/stby_com2_coarse_down" )
	-- set_button_assignment( (20*40) + 1, "sim/radios/stby_com2_fine_up" )
	-- set_button_assignment( (20*40) + 2, "sim/radios/stby_com2_fine_down" )
	-- set_button_assignment( (20*40) + 3, "sim/radios/stby_com2_coarse_up" )
	-- set_button_assignment( (20*40) + 4, "sim/radios/nav2_standy_flip" )
	-- set_button_assignment( (20*40) + 5, "sim/radios/nav1_standy_flip" )
	-- set_button_assignment( (20*40) + 7, "sim/radios/com2_standy_flip" )
	-- set_button_assignment( (20*40) + 10, "sim/radios/stby_nav2_coarse_up" )
	-- set_button_assignment( (20*40) + 12, "sim/radios/stby_nav2_fine_up" )
	-- set_button_assignment( (20*40) + 14, "sim/radios/stby_nav2_coarse_down" )
	-- set_button_assignment( (20*40) + 16, "sim/radios/stby_nav2_fine_down" )

	-- -- setting nullzone, sensitivity and augment
	-- set( "sim/joystick/joystick_pitch_nullzone",      0.080 )
	-- set( "sim/joystick/joystick_roll_nullzone",       0.000 )
	-- set( "sim/joystick/joystick_heading_nullzone",    0.032 )
	-- set( "sim/joystick/joystick_pitch_sensitivity",   1.000 )
	-- set( "sim/joystick/joystick_roll_sensitivity",    0.000 )
	-- set( "sim/joystick/joystick_heading_sensitivity", 0.400 )
	-- set( "sim/joystick/joystick_pitch_augment",       0.000 )
	-- set( "sim/joystick/joystick_roll_augment",        0.000 )
	-- set( "sim/joystick/joystick_heading_augment",     0.000 )

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >8 -- --

	-- -- PLANE_ICAO == "DC6"
	-- -- PLANE_TAILNUMBER == "N6PM"
	-- -- AIRCRAFT_FILENAME == "DC-6A.acf"
-- end


if PLANE_ICAO == "T210" then

	clear_all_axis_assignments()
	set_axis_assignment( 25, "flaps", "normal" )
	set_axis_assignment( 50, "elev trim", "normal" )
	set_axis_assignment( 75, "pitch", "normal" )
	set_axis_assignment( 76, "roll", "normal" )
	set_axis_assignment( 77, "mixture", "reverse" )
	set_axis_assignment( 78, "prop", "reverse" )
	set_axis_assignment( 79, "throttle", "normal" )
	set_axis_assignment( 100, "right toe brake", "normal" )
	set_axis_assignment( 101, "left toe brake", "normal" )
	set_axis_assignment( 102, "yaw", "normal" )
	set_axis_assignment( 126, "nosewheel tiller", "normal" )

	clear_all_button_assignments()
	set_button_assignment( (0*40) + 0, "sim/autopilot/servos_toggle" )
	set_button_assignment( (0*40) + 2, "sim/flight_controls/pitch_trim_down" )
	set_button_assignment( (0*40) + 4, "sim/autopilot/altitude_up" )
	set_button_assignment( (0*40) + 5, "sim/autopilot/altitude_down" )
	set_button_assignment( (0*40) + 6, "sim/autopilot/altitude_arm" )
	set_button_assignment( (0*40) + 7, "sim/autopilot/vertical_speed_pre_sel" )
	set_button_assignment( (0*40) + 8, "sim/autopilot/vertical_speed_up" )
	set_button_assignment( (0*40) + 9, "sim/autopilot/vertical_speed_down" )
	set_button_assignment( (0*40) + 10, "sim/autopilot/NAV" )
	set_button_assignment( (0*40) + 11, "sim/autopilot/approach" )
	set_button_assignment( (4*40) + 1, "sim/radios/com1_standy_flip" )
	set_button_assignment( (4*40) + 2, "sim/radios/stby_com1_coarse_up" )
	set_button_assignment( (4*40) + 3, "sim/radios/stby_com1_coarse_down" )
	set_button_assignment( (4*40) + 4, "sim/radios/stby_com1_fine_up_833" )
	set_button_assignment( (4*40) + 5, "sim/radios/stby_com1_fine_down_833" )
	set_button_assignment( (12*40) + 0, "sim/operation/contact_atc" )
	set_button_assignment( (12*40) + 4, "sim/autopilot/altitude_hold" )
	set_button_assignment( (12*40) + 5, "sim/autopilot/heading" )
	set_button_assignment( (12*40) + 6, "sim/radios/obs1_down" )
	set_button_assignment( (12*40) + 7, "sim/radios/obs1_up" )
	set_button_assignment( (12*40) + 11, "sim/autopilot/heading_down" )
	set_button_assignment( (12*40) + 12, "sim/autopilot/heading_up" )
	set_button_assignment( (12*40) + 14, "sim/radios/nav1_standy_flip" )
	set_button_assignment( (12*40) + 15, "sim/radios/stby_nav1_coarse_up" )
	set_button_assignment( (12*40) + 16, "sim/radios/stby_nav1_coarse_down" )
	set_button_assignment( (12*40) + 17, "sim/radios/stby_nav1_fine_up" )
	set_button_assignment( (12*40) + 18, "sim/radios/stby_nav1_fine_down" )
	set_button_assignment( (12*40) + 20, "sim/engines/thrust_reverse_hold" )
	set_button_assignment( (12*40) + 22, "sim/audio_panel/transmit_audio_com1" )
	set_button_assignment( (12*40) + 23, "sim/audio_panel/transmit_audio_com2" )
	set_button_assignment( (12*40) + 25, "sim/GPS/g430n1_chapter_up" )
	set_button_assignment( (12*40) + 27, "sim/GPS/g430n1_page_up" )
	set_button_assignment( (12*40) + 29, "sim/GPS/g430n1_chapter_dn" )
	set_button_assignment( (12*40) + 31, "sim/GPS/g430n1_page_dn" )
	set_button_assignment( (20*40) + 0, "sim/radios/stby_com2_coarse_down" )
	set_button_assignment( (20*40) + 1, "sim/radios/stby_com2_fine_up" )
	set_button_assignment( (20*40) + 2, "sim/radios/stby_com2_fine_down" )
	set_button_assignment( (20*40) + 3, "sim/radios/stby_com2_coarse_up" )
	set_button_assignment( (20*40) + 4, "sim/radios/nav2_standy_flip" )
	set_button_assignment( (20*40) + 5, "sim/radios/nav1_standy_flip" )
	set_button_assignment( (20*40) + 7, "sim/radios/com2_standy_flip" )
	set_button_assignment( (20*40) + 10, "sim/radios/stby_nav2_coarse_up" )
	set_button_assignment( (20*40) + 12, "sim/radios/stby_nav2_fine_up" )
	set_button_assignment( (20*40) + 14, "sim/radios/stby_nav2_coarse_down" )
	set_button_assignment( (20*40) + 16, "sim/radios/stby_nav2_fine_down" )

	-- setting nullzone, sensitivity and augment
	set( "sim/joystick/joystick_pitch_nullzone",      0.080 )
	set( "sim/joystick/joystick_roll_nullzone",       0.000 )
	set( "sim/joystick/joystick_heading_nullzone",    0.032 )
	set( "sim/joystick/joystick_pitch_sensitivity",   1.000 )
	set( "sim/joystick/joystick_roll_sensitivity",    0.000 )
	set( "sim/joystick/joystick_heading_sensitivity", 0.400 )
	set( "sim/joystick/joystick_pitch_augment",       0.000 )
	set( "sim/joystick/joystick_roll_augment",        0.000 )
	set( "sim/joystick/joystick_heading_augment",     0.000 )

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >8 -- --

	-- PLANE_ICAO == "T210"
	-- PLANE_TAILNUMBER == "N3888Y"
	-- AIRCRAFT_FILENAME == "Car_Centurion.acf"

end

if PLANE_ICAO == "B733" then
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- --     FlyWithLua: The initial assignments are stored in this file.     -- --
	-- -- 8< -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- --     FlyWithLua: The initial assignments are stored in this file.     -- --
	-- -- 8< -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	clear_all_axis_assignments()
	set_axis_assignment( 25, "flaps", "normal" )
	--set_axis_assignment( 50, "elev trim", "normal" )
	set_axis_assignment( 75, "pitch", "normal" )
	set_axis_assignment( 76, "roll", "normal" )
	set_axis_assignment( 78, "throttle", "normal" )
	set_axis_assignment( 79, "speedbrakes", "normal" )
	set_axis_assignment( 100, "right toe brake", "normal" )
	set_axis_assignment( 101, "left toe brake", "normal" )
	set_axis_assignment( 102, "yaw", "normal" )
	set_axis_assignment( 126, "nosewheel tiller", "normal" )

	clear_all_button_assignments()
	set_button_assignment( (0*40) + 0, "sim/autopilot/servos_toggle" )
	set_button_assignment( (0*40) + 2, "sim/flight_controls/pitch_trim_down" )
	set_button_assignment( (0*40) + 8, "sim/flight_controls/flaps_up" )
	set_button_assignment( (0*40) + 9, "sim/flight_controls/flaps_down" )
	set_button_assignment( (0*40) + 12, "sim/general/up" )
	set_button_assignment( (0*40) + 16, "sim/general/down" )
	set_button_assignment( (4*40) + 1, "sim/radios/com1_standy_flip" )
	set_button_assignment( (4*40) + 2, "sim/radios/stby_com1_coarse_up" )
	set_button_assignment( (4*40) + 3, "sim/radios/stby_com1_coarse_down" )
	set_button_assignment( (4*40) + 4, "sim/radios/stby_com1_fine_up_833" )
	set_button_assignment( (4*40) + 5, "sim/radios/stby_com1_fine_down_833" )
	set_button_assignment( (12*40) + 0, "sim/operation/contact_atc" )
	set_button_assignment( (12*40) + 4, "ixeg/733/autopilot/ALT_decrease" )
	set_button_assignment( (12*40) + 5, "ixeg/733/autopilot/ALT_increase" )
	set_button_assignment( (12*40) + 6, "sim/autopilot/heading_down" )
	set_button_assignment( (12*40) + 7, "sim/autopilot/heading_up" )
	set_button_assignment( (12*40) + 11, "ixeg/733/ehsi/map_mode_dec_pilot" )
	set_button_assignment( (12*40) + 12, "ixeg/733/ehsi/map_mode_inc_pilot" )
	set_button_assignment( (12*40) + 14, "sim/radios/nav1_standy_flip" )
	set_button_assignment( (12*40) + 15, "sim/radios/actv_nav1_coarse_up" )
	set_button_assignment( (12*40) + 16, "sim/radios/actv_nav1_coarse_down" )
	set_button_assignment( (12*40) + 17, "sim/radios/actv_nav1_fine_up" )
	set_button_assignment( (12*40) + 18, "sim/radios/actv_nav1_fine_down" )
	set_button_assignment( (12*40) + 22, "sim/audio_panel/transmit_audio_com1" )
	set_button_assignment( (12*40) + 23, "sim/audio_panel/transmit_audio_com2" )
	set_button_assignment( (12*40) + 25, "sim/general/forward" )
	set_button_assignment( (12*40) + 27, "sim/general/right" )
	set_button_assignment( (12*40) + 29, "sim/general/backward" )
	set_button_assignment( (12*40) + 31, "sim/general/left" )
	set_button_assignment( (20*40) + 0, "sim/radios/stby_com2_coarse_down" )
	set_button_assignment( (20*40) + 1, "sim/radios/stby_com2_fine_up" )
	set_button_assignment( (20*40) + 2, "sim/radios/stby_com2_fine_down" )
	set_button_assignment( (20*40) + 3, "sim/radios/stby_com2_coarse_up" )
	set_button_assignment( (20*40) + 4, "sim/radios/nav2_standy_flip" )
	set_button_assignment( (20*40) + 5, "sim/radios/nav1_standy_flip" )
	set_button_assignment( (20*40) + 7, "sim/radios/com2_standy_flip" )
	set_button_assignment( (20*40) + 10, "sim/radios/stby_nav2_coarse_up" )
	set_button_assignment( (20*40) + 12, "sim/radios/stby_nav2_fine_up" )
	set_button_assignment( (20*40) + 14, "sim/radios/stby_nav2_coarse_down" )
	set_button_assignment( (20*40) + 16, "sim/radios/stby_nav2_fine_down" )

	-- setting nullzone, sensitivity and augment
	set( "sim/joystick/joystick_pitch_nullzone",      0.000 )
	set( "sim/joystick/joystick_roll_nullzone",       0.000 )
	set( "sim/joystick/joystick_heading_nullzone",    0.032 )
	set( "sim/joystick/joystick_pitch_sensitivity",   0.550 )
	set( "sim/joystick/joystick_roll_sensitivity",    0.550 )
	set( "sim/joystick/joystick_heading_sensitivity", 0.550 )
	set( "sim/joystick/joystick_pitch_augment",       0.000 )
	set( "sim/joystick/joystick_roll_augment",        0.000 )
	set( "sim/joystick/joystick_heading_augment",     0.000 )

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >8 -- --

	-- PLANE_ICAO == "B733"
	-- PLANE_TAILNUMBER == "D-IXEG"
	-- AIRCRAFT_FILENAME == "B733.acf"


end

