-- Script by Parshukov Nikolay
-- Thanks for developers of the RTH script, looked at their script and made this one.
-------command_once("sim/operation/reload_scenery")

local start_time = os.clock()
local do_once = false
local on_start_sim=true
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
ffi.cdef( "typedef void * XPLMDataRef;")
ffi.cdef( "XPLMDataRef XPLMFindDataRef(const char *inDataRefName);" )
ffi.cdef( "int XPLMGetDatai(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDatai(XPLMDataRef inDataRef, int inValue);" )
ffi.cdef( "float XPLMGetDataf(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDataf(XPLMDataRef inDataRef, float inValue);" )
ffi.cdef( "double XPLMGetDatad(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDatad(XPLMDataRef inDataRef, double inValue);" )
ffi.cdef( "void XPLMReloadScenery(void)" )
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

require"graphics"
require"RENDEROPTIONS"
version="1.0"
ofs=0
ofy=0
print_debug = 0
ofyy1=0

debug_log = false
local need_reload = false
local need_save = false
local default_sett_misc = true		
local default_sett_water = true		
local default_sett_shadow = true		
local default_sett_num_obj = true		
local default_sett_texture = true		
local default_sett_clouds = true		
local default_sett_visibility = true		
local d_tab = true
local menu_items = false  
local tab_misc = false    
local tab_reflection_detail_item = false    
local tab_shadows_on_scenery_item = false    
local tab_num_of_world_obj_item = false    
local tab_texture_quality_item = false   
local tab_clouds_and_sky_item = false
local tab_visibility_item = false
local tab_plugin_settins_item = false 
local RWY_FOLLOW_TEXT="RWY follow terrain contours"
local start_time = os.clock() 
local title_switch = true
local title_alpha = 0.5
local but_color11={0.12,0.45,0.75,1}
local but_default_color11={0.12,0.45,0.75,1}
local but_save_color11={0.38, 0.38, 0.38, 1}
local maintabcolor={0.15, 0.20, 0.25, 0.8}
local maintabbuttonscolor={0.15, 0.20, 0.25, 0.95}
local x_sliders={10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10}
local default_sett_misc_values={1,1,0,1,0,1,1,1,9260,3,1,1,0,0,1.0,1.0,1.0,1.0,1.0,8.0,64,256,9.810,2,1,1,3,2048,1024,2,2,500,0,0,4,1,3,3,0.25,0.5,1,2,1,1,1,1,1,0,0,5,0.75,1,0.75,1.1,1.1,3.2,13,2,5,15,100000,0.75,1,-100,-100,0,0,0,0,0,0,0,9000,1.5,20000,0.83,0.6,0.83,1,0.4,0.6,200,4000,0.38,0.42,100,2500}
local but_color1=but_color11
local but_load_at_start1_color={0.38, 0.38, 0.38, 1}
local but_load_at_start2_color={0.38, 0.38, 0.38, 1}
local but_load_at_start3_color={0.38, 0.38, 0.38, 1}
local but_load_at_start4_color={0.38, 0.38, 0.38, 1}
local but_save_tab_color1={0.38, 0.38, 0.38, 1}
local but_save_tab_color2={0.38, 0.38, 0.38, 1}
local but_save_tab_color3={0.38, 0.38, 0.38, 1}
local but_save_tab_color4={0.38, 0.38, 0.38, 1}
local but_load_tab_color1={0.38, 0.38, 0.38, 1}
local but_load_tab_color2={0.38, 0.38, 0.38, 1}
local but_load_tab_color3={0.38, 0.38, 0.38, 1}
local but_load_tab_color4={0.38, 0.38, 0.38, 1}
local but_default_color1=but_default_color11
local but_save_color1=but_save_color11
local but_color2={1,1,1,1}
local but_default_color2={1,1,1,1}
local but_save_color2={1,1,1,1}
local rwy_color={1,0,0,1}
local birds_color={1,0,0,1}
local fires_color={1,0,0,1}
local carriers_color={1,0,0,1}
local aurora_color={1,0,0,1}
local atmo_color={1,0,0,1}
local fog_color={1,0,0,1}
local p_pix_color={1,0,0,1}
local use_reflective_water_box_color={1,0,0,1}
local draw_fft_water_box_color={1,0,0,1}
local use_3dwater_box_color={1,0,0,1}
local shadow_on_scenery_show_box_color={1,0,0,1}
local disable_shadow_prep_box_color={1,0,0,1}
local draw_HDR_box_color={1,0,0,1}
local comp_texes_box_color={1,0,0,1}
local use_bump_maps_box_color={1,0,0,1}
local use_detail_textures_box_color={1,0,0,1}
local ssao_enable_box_color={1,0,0,1}
local extended_dsfs_box_color={1,0,0,1}
local xenviro_enabled_box_color={1,0,0,1} 
local show_help_bubble_box_color={1,0,0,1}

local xEnviro = 0
local show_help_bubble = 0
local start_preset = 1
local settings_file
local prefs_file
local preset_loaded = 0
local preset_saved = 0
local preset_on_start_loaded = false
aaa ={}
bbb={}
values_var = {}
val_sett = {}
val_to_save = {}
val_to_load = {}
local rwy_follow_terrain
local draw_deer_birds
local draw_fire_ball
local draw_boats
local draw_aurora
local draw_scattering
local draw_volume_fog01
local draw_per_pix_liting
dataref("run_time", "sim/time/total_running_time_sec", "readonly")
local time_to_save_color=0

function load_settings()
	if SYSTEM=="IBM" then
		settings_file = io.open(SCRIPT_DIRECTORY.."rendering_options_settings.txt", "r")
	elseif SYSTEM =="APL" or SYSTEM == "LIN" then
		settings_file = io.open("rendering_options_settings.txt", "r")
	end
	if settings_file == nil then 
	return end
	
	for _=1,5,1 do
		line=settings_file:read()
		if line == nil then break end
		
		val_sett[_] = line
	end
	settings_file:close()
	xEnviro=				tonumber(val_sett[1])
	if xEnviro==nil then xEnviro=0 end
	show_help_bubble=		tonumber(val_sett[2])
	if show_help_bubble==nil then show_help_bubble=0 end
	start_preset=  			tonumber(val_sett[3])
	if start_preset==nil then start_preset=1 end
	ofy=					tonumber(val_sett[4])
	if ofy==nil then ofy=0 end
	ofyy1=					tonumber(val_sett[5])
	if ofyy1==nil then ofyy1=0 end
end
function save_settings()
	val_sett[1]=xEnviro
	val_sett[2]=show_help_bubble
	val_sett[3]=start_preset
	val_sett[4]=ofy
	val_sett[5]=ofyy1
	if SYSTEM=="IBM" then
		settings_file = io.open(SCRIPT_DIRECTORY.."rendering_options_settings.txt", "w")
	elseif SYSTEM =="APL" or SYSTEM == "LIN" then
		settings_file = io.open("rendering_options_settings.txt", "w")
	end
	for ind=1,5,1 do
		if val_sett[ind]==nil then break end
		settings_file:write(val_sett[ind], "\n")
	end
	settings_file:close()

end
function save_set(num_set)
	val_to_save[1]=99
	val_to_save[2]=draw_deer_birds_ref
	val_to_save[3]=draw_fire_ball_ref
	val_to_save[4]=draw_boats_ref
	val_to_save[5]=draw_aurora_ref
	val_to_save[6]=draw_scattering_ref
	val_to_save[7]=draw_volume_fog01_ref
	val_to_save[8]=draw_per_pix_liting_ref
	val_to_save[9]=static_plane_build_vis
	val_to_save[10]=static_plane_density
	val_to_save[11]=use_reflective_water
	val_to_save[12]=draw_fft_water
	val_to_save[13]=use_3dwater_ref
	val_to_save[14]=draw_reflect_water05
	val_to_save[15]=fft_amp1_ref
	val_to_save[16]=fft_amp2_ref
	val_to_save[17]=fft_amp3_ref
	val_to_save[18]=fft_amp4_ref
	val_to_save[19]=fft_scale1_ref
	val_to_save[20]=fft_scale2_ref
	val_to_save[21]=fft_scale3_ref
	val_to_save[22]=fft_scale4_ref
	val_to_save[23]=round(noise_speed_ref,2)
	val_to_save[24]=round(noise_bias_gen_x_ref,2)
	val_to_save[25]=round(noise_bias_gen_y_ref,2)
	val_to_save[26]=csm_split_exterior
	val_to_save[27]=csm_split_interior
	val_to_save[28]=shadow_cam_size
	val_to_save[29]=shadow_size
	val_to_save[30]=cockpit_near_adjust
	val_to_save[31]=cockpit_near_proxy
	val_to_save[32]=far_limit
	val_to_save[33]=scenery_shadows
	val_to_save[34]=disable_shadow_prep
	val_to_save[35]=draw_objs_06_ref
	val_to_save[36]=draw_cars_05_ref
	val_to_save[37]=draw_vecs_03_ref
	val_to_save[38]=draw_for_05_ref
	val_to_save[39]=round(inn_ring_density_ref,2)
	val_to_save[40]=round(mid_ring_density_ref,2)
	val_to_save[41]=round(out_ring_density_ref,2)
	val_to_save[42]=draw_detail_apt_03_ref
	val_to_save[43]=extended_dsfs_ref
	val_to_save[44]=draw_HDR_ref
	val_to_save[45]=comp_texes_ref
	val_to_save[46]=use_bump_maps_ref
	val_to_save[47]=use_detail_textures_ref
	val_to_save[48]=ssao_enable_ref
	val_to_save[49]=first_res_3d_ref
	val_to_save[50]=last_res_3d_ref
	val_to_save[51]=round(cloud_shadow_lighten_ratio_ref,2)
	val_to_save[52]=round(plot_radius_ref,2)
	val_to_save[53]=round(overdraw_control_ref,2)
	val_to_save[54]=round(ambient_gain_ref,2)
	val_to_save[55]=round(diffuse_gain_ref,2)
	val_to_save[56]=round(white_point_ref,2)
	val_to_save[57]=round(atmo_scale_raleigh_ref,2)
	val_to_save[58]=inscatter_gain_raleigh_ref
	val_to_save[59]=min_shadow_angle_ref
	val_to_save[60]=max_shadow_angle_ref
	val_to_save[61]=max_dsf_vis_ever_ref
	val_to_save[62]=round(dsf_fade_ratio_ref,2)
	val_to_save[63]=round(dsf_cutover_scale_ref,2)
	val_to_save[64]=min_tone_angle_ref
	val_to_save[65]=max_tone_angle_ref
	val_to_save[66]=round(tone_ratio_clean_ref,1)
	val_to_save[67]=round(tone_ratio_foggy_ref,1)
	val_to_save[68]=round(tone_ratio_hazy_ref,1)
	val_to_save[69]=round(tone_ratio_snowy_ref,1)
	val_to_save[70]=round(tone_ratio_ocast_ref,1)
	val_to_save[71]=round(tone_ratio_strat_ref,1)
	val_to_save[72]=round(tone_ratio_hialt_ref,1)
	val_to_save[73]=visibility_reported_m_ref
	val_to_save[74]=LOD_bias_rat_ref
	val_to_save[75]=cars_lod_min_ref
	val_to_save[76]=round(tile_lod_bias_ref,2)
	val_to_save[77]=round(fade_start_rat_ref,2)
	val_to_save[78]=round(composite_far_dist_bias_ref,2)
	val_to_save[79]=round(fog_be_gone_ref,2)
	val_to_save[80]=round(scale_near_ref,2)
	val_to_save[81]=round(scale_far_ref,2)
	val_to_save[82]=dist_near_ref
	val_to_save[83]=dist_far_ref
	val_to_save[84]=round(exponent_near_ref,2)
	val_to_save[85]=round(exponent_far_ref,2)
	val_to_save[86]=bloom_near_ref
	val_to_save[87]=bloom_far_ref
	if SYSTEM=="IBM" then
		prefs_file = io.open(SCRIPT_DIRECTORY.."rendering_options_preset_" .. num_set ..".txt", "w")
	elseif SYSTEM =="APL" or SYSTEM == "LIN" then
		prefs_file = io.open("rendering_options_preset_" .. num_set ..".txt", "w")
	end
	for ind=1,87,1 do
		if val_to_save[ind]==nil then break end
		prefs_file:write(val_to_save[ind], "\n")
	end
	prefs_file:close()
end
function load_set(num_set)
	if SYSTEM=="IBM" then
		prefs_file = io.open(SCRIPT_DIRECTORY.."rendering_options_preset_" .. num_set ..".txt", "r")
	elseif SYSTEM =="APL" or SYSTEM == "LIN" then
		prefs_file = io.open("rendering_options_preset_" .. num_set ..".txt", "r")
	end
	if prefs_file == nil then 
		return end		
	for _=1,87,1 do
		line=prefs_file:read()
		if line == nil then break end
		val_to_load[_] = line
	end
	prefs_file:close()
	
	--setDatai(findDataref("sim/private/controls/reno/sloped_runways"),tonumber(val_to_load[1]))
	setDatai(findDataref("sim/private/controls/reno/draw_deer_birds"),tonumber(val_to_load[2]))
	setDatai(findDataref("sim/private/controls/reno/draw_fire_ball"),tonumber(val_to_load[3]))
	setDatai(findDataref("sim/private/controls/reno/draw_boats"),tonumber(val_to_load[4]))
	setDatai(findDataref("sim/private/controls/reno/draw_aurora"),tonumber(val_to_load[5]))
	setDatai(findDataref("sim/private/controls/reno/draw_scattering"),tonumber(val_to_load[6]))
	setDatai(findDataref("sim/private/controls/reno/draw_volume_fog01"),tonumber(val_to_load[7]))
	setDatai(findDataref("sim/private/controls/reno/draw_per_pix_liting"),tonumber(val_to_load[8]))
	setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),tonumber(val_to_load[9]))
	setDataf(findDataref("sim/private/controls/park/static_plane_density"),tonumber(val_to_load[10]))
	setDataf(findDataref("sim/private/controls/caps/use_reflective_water"),tonumber(val_to_load[11]))
	setDatai(findDataref("sim/private/controls/reno/draw_fft_water"),tonumber(val_to_load[12]))
	setDataf(findDataref("sim/private/controls/caps/use_3dwater"),tonumber(val_to_load[13]))
	setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),tonumber(val_to_load[14]))
	setDataf(findDataref("sim/private/controls/water/fft_amp1"),tonumber(val_to_load[15]))
	setDataf(findDataref("sim/private/controls/water/fft_amp2"),tonumber(val_to_load[16]))
	setDataf(findDataref("sim/private/controls/water/fft_amp3"),tonumber(val_to_load[17]))
	setDataf(findDataref("sim/private/controls/water/fft_amp4"),tonumber(val_to_load[18]))
	setDataf(findDataref("sim/private/controls/water/fft_scale1"),tonumber(val_to_load[19]))
	setDataf(findDataref("sim/private/controls/water/fft_scale2"),tonumber(val_to_load[20]))
	setDataf(findDataref("sim/private/controls/water/fft_scale3"),tonumber(val_to_load[21]))
	setDataf(findDataref("sim/private/controls/water/fft_scale4"),tonumber(val_to_load[22]))
	setDataf(findDataref("sim/private/controls/water/noise_speed"),tonumber(val_to_load[23]))
	setDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"),tonumber(val_to_load[24]))
	setDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"),tonumber(val_to_load[25]))
	setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),tonumber(val_to_load[26]))
	setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),tonumber(val_to_load[27]))
	setDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"),tonumber(val_to_load[28]))
	setDataf(findDataref("sim/private/controls/clouds/shadow_size"),tonumber(val_to_load[29]))
	setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),tonumber(val_to_load[30]))
	setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),tonumber(val_to_load[31]))
	setDataf(findDataref("sim/private/controls/shadow/csm/far_limit"),tonumber(val_to_load[32]))
	setDataf(findDataref("sim/private/controls/shadow/scenery_shadows"),tonumber(val_to_load[33]))
	setDataf(findDataref("sim/private/controls/perf/disable_shadow_prep"),tonumber(val_to_load[34]))
	setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),tonumber(val_to_load[35]))--
	setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),tonumber(val_to_load[36]))--
	setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),tonumber(val_to_load[37]))--
	setDatai(findDataref("sim/private/controls/reno/draw_for_05"),tonumber(val_to_load[38]))--
	setDataf(findDataref("sim/private/controls/forest/inn_ring_density"),tonumber(val_to_load[39]))--
	setDataf(findDataref("sim/private/controls/forest/mid_ring_density"),tonumber(val_to_load[40]))--
	setDataf(findDataref("sim/private/controls/forest/out_ring_density"),tonumber(val_to_load[41]))--
	setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),tonumber(val_to_load[42]))
	setDataf(findDataref("sim/private/controls/geoid/extended_dsfs"),tonumber(val_to_load[43]))
	setDatai(findDataref("sim/private/controls/reno/draw_HDR"),tonumber(val_to_load[44]))
	setDatai(findDataref("sim/private/controls/reno/comp_texes"),tonumber(val_to_load[45]))
	setDatai(findDataref("sim/private/controls/reno/use_bump_maps"),tonumber(val_to_load[46]))
	setDatai(findDataref("sim/private/controls/reno/use_detail_textures"),tonumber(val_to_load[47]))
	setDataf(findDataref("sim/private/controls/ssao/enable"),tonumber(val_to_load[48])) 
	setDataf(findDataref("sim/private/controls/clouds/first_res_3d"),tonumber(val_to_load[49]))
	setDataf(findDataref("sim/private/controls/clouds/last_res_3d"),tonumber(val_to_load[50]))
	setDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"),tonumber(val_to_load[51]))
	setDataf(findDataref("sim/private/controls/clouds/plot_radius"),tonumber(val_to_load[52]))
	setDataf(findDataref("sim/private/controls/clouds/overdraw_control"),tonumber(val_to_load[53]))
	setDataf(findDataref("sim/private/controls/clouds/ambient_gain"),tonumber(val_to_load[54]))
	setDataf(findDataref("sim/private/controls/clouds/diffuse_gain"),tonumber(val_to_load[55]))
	setDataf(findDataref("sim/private/controls/hdr/white_point"),tonumber(val_to_load[56]))
	setDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"),tonumber(val_to_load[57]))
	setDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"),tonumber(val_to_load[58]))
	setDataf(findDataref("sim/private/controls/skyc/min_shadow_angle"),tonumber(val_to_load[59]))
	setDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"),tonumber(val_to_load[60]))
	setDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"),tonumber(val_to_load[61]))
	setDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"),tonumber(val_to_load[62]))
	setDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale"),tonumber(val_to_load[63]))
	setDataf(findDataref("sim/private/controls/skyc/min_tone_angle"),tonumber(val_to_load[64]))
	setDataf(findDataref("sim/private/controls/skyc/max_tone_angle"),tonumber(val_to_load[65]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"),tonumber(val_to_load[66]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"),tonumber(val_to_load[67]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"),tonumber(val_to_load[68]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"),tonumber(val_to_load[69]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"),tonumber(val_to_load[70]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"),tonumber(val_to_load[71]))
	setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"),tonumber(val_to_load[72]))
	setDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"),tonumber(val_to_load[74]))
	setDataf(findDataref("sim/private/controls/cars/lod_min"),tonumber(val_to_load[75]))
	setDataf(findDataref("sim/private/controls/ag/tile_lod_bias"),tonumber(val_to_load[76]))
	setDataf(findDataref("sim/private/controls/terrain/fade_start_rat"),tonumber(val_to_load[77]))
	setDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"),tonumber(val_to_load[78]))
	setDataf(findDataref("sim/private/controls/fog/fog_be_gone"),tonumber(val_to_load[79]))
	setDataf(findDataref("sim/private/controls/lights/scale_near"),tonumber(val_to_load[80]))
	setDataf(findDataref("sim/private/controls/lights/scale_far"),tonumber(val_to_load[81]))
	setDataf(findDataref("sim/private/controls/lights/dist_near"),tonumber(val_to_load[82]))
	setDataf(findDataref("sim/private/controls/lights/dist_far"),tonumber(val_to_load[83]))
	setDataf(findDataref("sim/private/controls/lights/exponent_near"),tonumber(val_to_load[84]))
	setDataf(findDataref("sim/private/controls/lights/exponent_far"),tonumber(val_to_load[85]))
	setDataf(findDataref("sim/private/controls/lights/bloom_near"),tonumber(val_to_load[86]))
	setDataf(findDataref("sim/private/controls/lights/bloom_far"),tonumber(val_to_load[87]))
end
function first_reload()
	if preset_on_start_loaded==false then
		--if run_time>2 and run_time<10 then
			load_set(start_preset)
			preset_loaded=start_preset
			preset_on_start_loaded=true
		--end
	end
	if run_time<100 then
		if on_start_sim == true then
			
			if need_reload == true then
				XPLMSetGraphicsState(0,0,0,1,1,0,0)
				graphics.set_color(0.12,0.45,0.75,0.75)
				RENDEROPTIONS.draw_filled_button(start_up_on_load_sim_box[2], start_up_on_load_sim_box[3], start_up_on_load_sim_box[4], start_up_on_load_sim_box[5], 10, 1)
				graphics.set_color(1, 1, 1, 1)
				RENDEROPTIONS.draw_button(start_up_on_load_sim_box[2], start_up_on_load_sim_box[3], start_up_on_load_sim_box[4], start_up_on_load_sim_box[5], 10, 1)
				draw_string_Helvetica_18(start_up_on_load_sim_box[2]+5, start_up_on_load_sim_box[3]-35, "You need to click 'Apply' to finish loading your profile")
				draw_string_Helvetica_18(start_up_on_load_sim_box[2]+100, start_up_on_load_sim_box[3]-55, "in the rendering options plugin")
				draw_string_Helvetica_18(start_up_on_load_sim_box[2]+95, start_up_on_load_sim_box[3]-75, "after first boot of your simulator")
				draw_button(unpack(start_up_on_load_sim_apply_box))
				draw_string_Helvetica_18(start_up_on_load_sim_apply_box[2]+25, start_up_on_load_sim_apply_box[3]-22, "Apply")
				draw_button(unpack(start_up_on_load_sim_cancel_box))
				draw_string_Helvetica_18(start_up_on_load_sim_cancel_box[2]+21, start_up_on_load_sim_cancel_box[3]-22, "Cancel")
			end
			
		end
	end
end
------reading dataref
function read_dref()
	---MISC/RANDOM
	rwy_follow_terrain_ref=getDatai(findDataref("sim/private/controls/reno/sloped_runways"))
	draw_deer_birds_ref=getDatai(findDataref("sim/private/controls/reno/draw_deer_birds"))
	draw_fire_ball_ref=getDatai(findDataref("sim/private/controls/reno/draw_fire_ball"))
	draw_boats_ref=getDatai(findDataref("sim/private/controls/reno/draw_boats"))
	draw_aurora_ref=getDatai(findDataref("sim/private/controls/reno/draw_aurora")) ---------ENVIRO
	draw_scattering_ref=getDatai(findDataref("sim/private/controls/reno/draw_scattering"))
	draw_volume_fog01_ref=getDatai(findDataref("sim/private/controls/reno/draw_volume_fog01"))
	draw_per_pix_liting_ref=getDatai(findDataref("sim/private/controls/reno/draw_per_pix_liting"))
	static_plane_build_vis=getDataf(findDataref("sim/private/controls/park/static_plane_build_dis"))
	static_plane_density=getDataf(findDataref("sim/private/controls/park/static_plane_density"))
	---water and reflection
	use_reflective_water=getDataf(findDataref("sim/private/controls/caps/use_reflective_water"))
	draw_fft_water=getDatai(findDataref("sim/private/controls/reno/draw_fft_water"))
	draw_reflect_water05=getDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"))
	use_3dwater_ref=getDataf(findDataref("sim/private/controls/caps/use_3dwater"))
	fft_amp1_ref=getDataf(findDataref("sim/private/controls/water/fft_amp1"))
	fft_amp2_ref=getDataf(findDataref("sim/private/controls/water/fft_amp2"))
	fft_amp3_ref=getDataf(findDataref("sim/private/controls/water/fft_amp3"))
	fft_amp4_ref=getDataf(findDataref("sim/private/controls/water/fft_amp4"))
	fft_scale1_ref=getDataf(findDataref("sim/private/controls/water/fft_scale1"))
	fft_scale2_ref=getDataf(findDataref("sim/private/controls/water/fft_scale2"))
	fft_scale3_ref=getDataf(findDataref("sim/private/controls/water/fft_scale3"))
	fft_scale4_ref=getDataf(findDataref("sim/private/controls/water/fft_scale4"))
	noise_speed_ref=getDataf(findDataref("sim/private/controls/water/noise_speed"))
	noise_bias_gen_x_ref=getDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"))
	noise_bias_gen_y_ref=getDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"))
	---SHADOWS
	csm_split_exterior=getDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"))
	csm_split_interior=getDataf(findDataref("sim/private/controls/shadow/csm_split_interior"))
	far_limit=getDataf(findDataref("sim/private/controls/shadow/csm/far_limit"))
	scenery_shadows=getDataf(findDataref("sim/private/controls/shadow/scenery_shadows"))
	shadow_cam_size=getDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"))
	shadow_size=getDataf(findDataref("sim/private/controls/clouds/shadow_size"))
	cockpit_near_adjust=getDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"))
	cockpit_near_proxy=getDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"))
	disable_shadow_prep=getDataf(findDataref("sim/private/controls/perf/disable_shadow_prep"))
	----NUMBER OF OBJECTS
	draw_objs_06_ref=getDatai(findDataref("sim/private/controls/reno/draw_objs_06"))--
	draw_cars_05_ref=getDatai(findDataref("sim/private/controls/reno/draw_cars_05"))--
	draw_vecs_03_ref=getDatai(findDataref("sim/private/controls/reno/draw_vecs_03"))--
	draw_for_05_ref=getDatai(findDataref("sim/private/controls/reno/draw_for_05"))--
	inn_ring_density_ref=getDataf(findDataref("sim/private/controls/forest/inn_ring_density"))--
	mid_ring_density_ref=getDataf(findDataref("sim/private/controls/forest/mid_ring_density"))--
	out_ring_density_ref=getDataf(findDataref("sim/private/controls/forest/out_ring_density"))--
	draw_detail_apt_03_ref=getDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"))
	extended_dsfs_ref=getDataf(findDataref("sim/private/controls/geoid/extended_dsfs"))
	---TEXTURE QUALITY
	draw_HDR_ref=getDatai(findDataref("sim/private/controls/reno/draw_HDR"))
	comp_texes_ref=getDatai(findDataref("sim/private/controls/reno/comp_texes"))				--to apply
	use_bump_maps_ref=getDatai(findDataref("sim/private/controls/reno/use_bump_maps"))				--0/1
	use_detail_textures_ref=getDatai(findDataref("sim/private/controls/reno/use_detail_textures"))		
	ssao_enable_ref=getDataf(findDataref("sim/private/controls/ssao/enable"))  
	---CLOUDS AND Atmo
	first_res_3d_ref=getDataf(findDataref("sim/private/controls/clouds/first_res_3d")) --1
	last_res_3d_ref=getDataf(findDataref("sim/private/controls/clouds/last_res_3d")) --1
	cloud_shadow_lighten_ratio_ref=getDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"))  --0.1
	plot_radius_ref=getDataf(findDataref("sim/private/controls/clouds/plot_radius")) --0.1
	overdraw_control_ref=getDataf(findDataref("sim/private/controls/clouds/overdraw_control"))  --0.01
	ambient_gain_ref=getDataf(findDataref("sim/private/controls/clouds/ambient_gain"))  --0.01
	diffuse_gain_ref=getDataf(findDataref("sim/private/controls/clouds/diffuse_gain"))--0.01
	white_point_ref=getDataf(findDataref("sim/private/controls/hdr/white_point")) 	--0.1
	atmo_scale_raleigh_ref=getDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"))---------ENVIRO --0.1
	inscatter_gain_raleigh_ref=getDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"))---------ENVIRO --0.1
	max_shadow_angle_ref=getDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"))  --1     -180+180
	min_shadow_angle_ref=getDataf(findDataref("sim/private/controls/skyc/min_shadow_angle")) --1      -180+180
	max_dsf_vis_ever_ref=getDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever")) --100
	dsf_fade_ratio_ref=getDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio")) --0.01   0 - 1
	dsf_cutover_scale_ref=getDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale")) --0.1   0 - 2
	min_tone_angle_ref=getDataf(findDataref("sim/private/controls/skyc/min_tone_angle"))---------ENVIRO --1      -100+100
	max_tone_angle_ref=getDataf(findDataref("sim/private/controls/skyc/max_tone_angle"))---------ENVIRO --1      -100+100
	tone_ratio_clean_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"))---------ENVIRO --0.1      -50+50
	tone_ratio_foggy_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"))---------ENVIRO --0.1      -50+50
	tone_ratio_hazy_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"))---------ENVIRO --0.1      -50+50
	tone_ratio_snowy_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"))---------ENVIRO --0.1      -50+50
	tone_ratio_ocast_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"))---------ENVIRO --0.1      -50+50
	tone_ratio_strat_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"))---------ENVIRO --0.1      -50+50
	tone_ratio_hialt_ref=getDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"))---------ENVIRO --0.1      -50+50


	---Visibility and Lights
	visibility_reported_m_ref=getDataf(findDataref("sim/weather/visibility_reported_m"))
	LOD_bias_rat_ref=getDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"))
	tile_lod_bias_ref=getDataf(findDataref("sim/private/controls/ag/tile_lod_bias"))   ----0.1-1  obj vis reload needed
	fade_start_rat_ref=getDataf(findDataref("sim/private/controls/terrain/fade_start_rat"))----0-1  0.1 terrain objects (trees) visibl 
	composite_far_dist_bias_ref=getDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"))  -- 0-1 0.1 terrain details visibility reload needed
	cars_lod_min_ref=getDataf(findDataref("sim/private/controls/cars/lod_min"))  -- 100 0-100000 cars visibility
	fog_be_gone_ref=getDataf(findDataref("sim/private/controls/fog/fog_be_gone"))  -- 0-5 0.01
	--car_lod_boost_ref=getDataf(findDataref("sim/private/controls/terrain/car_lod_boost"))
	--lights
	exponent_far_ref=getDataf(findDataref("sim/private/controls/lights/exponent_far"))
	exponent_near_ref=getDataf(findDataref("sim/private/controls/lights/exponent_near"))
	bloom_far_ref=getDataf(findDataref("sim/private/controls/lights/bloom_far"))
	bloom_near_ref=getDataf(findDataref("sim/private/controls/lights/bloom_near"))
	dist_far_ref=getDataf(findDataref("sim/private/controls/lights/dist_far"))
	dist_near_ref=getDataf(findDataref("sim/private/controls/lights/dist_near"))
	scale_far_ref=getDataf(findDataref("sim/private/controls/lights/scale_far")) ---------ENVIRO
	scale_near_ref=getDataf(findDataref("sim/private/controls/lights/scale_near")) ---------ENVIRO

	if static_plane_density==0 then
	static_plane_build_vis=0
	end
	

end
function check_values_change()


--values_var[1]=rwy_follow_terrain_ref
values_var[2]=draw_deer_birds_ref
values_var[3]=draw_fire_ball_ref
values_var[4]=draw_boats_ref
values_var[5]=draw_aurora_ref
values_var[6]=draw_scattering_ref
values_var[7]=draw_volume_fog01_ref
values_var[8]=draw_per_pix_liting_ref
values_var[9]=draw_objs_06_ref
values_var[10]=draw_vecs_03_ref
values_var[11]=draw_for_05_ref
values_var[12]=inn_ring_density_ref
values_var[13]=mid_ring_density_ref
values_var[14]=out_ring_density_ref
values_var[15]=draw_detail_apt_03_ref
values_var[16]=comp_texes_ref
values_var[17]=extended_dsfs_ref
values_var[18]=tile_lod_bias_ref
values_var[19]=composite_far_dist_bias_ref
end
function m_inbox(ctrl, box)
	if ctrl == true and MOUSE_X > box[1] and MOUSE_X < box[2] and MOUSE_Y > box[3] and MOUSE_Y < box[4] then return true
	else return false
	end
end
function m_inbox_inn(ctrl, box)
	if ctrl == true and MOUSE_X > box[2] and MOUSE_X < box[3] and MOUSE_Y < box[4] and MOUSE_Y > box[5] then return true
	else return false
	end
end
function m_inbox_inn_but(ctrl, box)
	if ctrl == true and MOUSE_X > box[2] and MOUSE_X < (box[2]+box[4]) and MOUSE_Y < box[3] and MOUSE_Y > (box[3]-box[5]) then return true
	else return false
	end
end
function m_inbox_inn_tabs(ctrl, tab_sel, box)
	if ctrl == true and tab_sel == true and MOUSE_X > box[2] and MOUSE_X < box[3] and MOUSE_Y < box[4] and MOUSE_Y > box[5] then return true
	else return false
	end
end
function draw_box(width_loc,box_x1,box_x2,box_y1,box_y2, boxname, bble_x, bble_Y, bble_line1, bble_line2, bble_line3)

		graphics.set_width(width_loc)
		graphics.draw_line(box_x1,box_y1,box_x1,box_y2)
		graphics.draw_line(box_x1,box_y2,box_x2,box_y2)
		graphics.draw_line(box_x2,box_y2,box_x2,box_y1)
		graphics.draw_line(box_x2,box_y1,box_x1,box_y1)
		--popup_helper(boxname, bble_line1, bble_line2, bble_line3, "normal")
end
function draw_button(width_loc,but_x,but_y, but_length, but_height, color1, color2, radius)
		graphics.set_color(unpack(color1))
		RENDEROPTIONS.draw_filled_button(but_x, but_y, but_length, but_height, radius, width_loc)
		graphics.set_color(unpack(color2))
		RENDEROPTIONS.draw_button(but_x, but_y, but_length, but_height, radius, width_loc)
		graphics.set_color(1,1,1,1)
		
		
		--popup_helper(boxname, bble_line1, bble_line2, bble_line3, "normal")
end
function draw_version_title(duration, fade_time, fade_switch, x_off, y_off, l_width, l_hight, line) --this might go in HELPERS
	
	--checks if we want the fade to happen
	if fade_switch == true then
	
		-- plus the set duration -- THIS NEEDS start_time set before the call. 
		for display = 0, 1, duration do
			if os.clock() < (start_time + duration + fade_time) then
				
				--fade_co_raw is defined as a difference between the end time (start_time+duration) - current time
				--the closer to end_time the smaller it becomes
				
				fade_co_raw = (start_time + duration + fade_time)-os.clock()
				if fade_co_raw > fade_time then 
				--print(string.format("FADE RAW %2.2f", fade_co_raw))
				--keeps the fade_coefficient to 1 (full opacity) until the _raw is bigger than the fade_time 
				--(passed with the function call)
				
					fade_co = 1
				--starts calculating fade_co (title transparency) based on fade_time
				elseif fade_co_raw <= fade_time then 
					fade_co = fade_co_raw/fade_time
				--print (string.format("FADE CO %2.2f", fade_co))
				end
				
				title_x1 = (SCREEN_WIDTH/2)-(l_width/2)+x_off
				title_x2 = (SCREEN_WIDTH/2)+(l_width/2)+x_off
				title_y1 = (SCREEN_HIGHT/1.3)-(l_hight/2)+y_off
				title_y2 = (SCREEN_HIGHT/1.3)+(l_hight/2)+y_off
				
				graphics.set_color(43/255, 191/255, 240/255, title_alpha*fade_co)
				graphics.draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)
				graphics.set_color(0, 0, 0, (title_alpha*fade_co*2))
				draw_string_Times_Roman_24(title_x1, title_y1, "Rendering options by Parshukov Nick")	
				draw_string_Times_Roman_24(title_x1+((title_x2-title_x1)/2)-30, title_y1-50, "v." .. version)
				
				graphics.set_color(1, 1, 1, (title_alpha*fade_co*2))			
				draw_string_Times_Roman_24(title_x1+1, title_y1+1, "Rendering options by Parshukov Nick")
				draw_string_Times_Roman_24(title_x1+((title_x2-title_x1)/2)-29, title_y1-49, "v." .. version)
				
				graphics.set_color(173/255, 191/255, 240/255, 0.8*title_alpha*fade_co*2)
				
				
			end
		end
	end
	
end
function set_interface_pos()
---first load of the sim
start_up_on_load_sim_box ={1,SCREEN_WIDTH/2-225,SCREEN_HIGHT/2+50,450,100}
start_up_on_load_sim_apply_box ={1,start_up_on_load_sim_box[2]+120,start_up_on_load_sim_box[3]-120,100,30,but_color1,but_color2,8}
start_up_on_load_sim_cancel_box ={1,start_up_on_load_sim_box[2]+230,start_up_on_load_sim_box[3]-120,100,30,but_color1,but_color2,8}
---main script
main_box=	{SCREEN_WIDTH-182,SCREEN_WIDTH,451+ofy,501+ofy} -- main box
slider_box= {29*SCREEN_WIDTH/30,SCREEN_WIDTH,0,SCREEN_HIGHT}
--menu items
menu_items_box= {0, main_box[1], main_box[1]+182, 165+ofy, 446+ofy}
misc_random_item={0, menu_items_box[2], menu_items_box[3], menu_items_box[5], menu_items_box[5]-30}
reflection_detail_item={0, menu_items_box[2], menu_items_box[3], menu_items_box[5]-30, menu_items_box[5]-60}
shadows_on_scenery_item={0, menu_items_box[2], menu_items_box[3], menu_items_box[5]-60, menu_items_box[5]-90}
num_of_world_obj_item={1, menu_items_box[2], menu_items_box[3], menu_items_box[5]-90, menu_items_box[5]-120}
texture_quality_item={1, menu_items_box[2], menu_items_box[3], menu_items_box[5]-120, menu_items_box[5]-150}
clouds_and_sky_item={1, menu_items_box[2], menu_items_box[3], menu_items_box[5]-150, menu_items_box[5]-180}
visibility_item={1, menu_items_box[2], menu_items_box[3], menu_items_box[5]-180, menu_items_box[5]-210}
plugin_settins_item={1, menu_items_box[2], menu_items_box[3], menu_items_box[5]-210, menu_items_box[5]-240}
buttontest={1,menu_items_box[2]+5,menu_items_box[5]-245,80,30,but_color1,but_color2,5}
set_to_default_item={1, menu_items_box[2]+96, menu_items_box[5]-245, 80,30,but_default_color1,but_default_color2,5}
---load save items
menu_load_tab={1, menu_items_box[2],menu_items_box[3],menu_items_box[4]-85,menu_items_box[4]-5}
save_tab_1={1, menu_load_tab[2]+60,menu_load_tab[5]-5,27, 27, but_save_tab_color1,but_save_color2,9}
save_tab_2={1, menu_load_tab[2]+90,menu_load_tab[5]-5,27, 27, but_save_tab_color2,but_save_color2,9}
save_tab_3={1, menu_load_tab[2]+120,menu_load_tab[5]-5,27, 27, but_save_tab_color3,but_save_color2,9}
save_tab_4={1, menu_load_tab[2]+150,menu_load_tab[5]-5,27, 27, but_save_tab_color4,but_save_color2,9}
load_tab_1={1, menu_load_tab[2]+60,menu_load_tab[5]-45,27, 27, but_load_tab_color1,but_save_color2,9}
load_tab_2={1, menu_load_tab[2]+90,menu_load_tab[5]-45,27, 27, but_load_tab_color2,but_save_color2,9}
load_tab_3={1, menu_load_tab[2]+120,menu_load_tab[5]-45,27, 27, but_load_tab_color3,but_save_color2,9}
load_tab_4={1, menu_load_tab[2]+150,menu_load_tab[5]-45,27, 27, but_load_tab_color4,but_save_color2,9}
--MISC/RANDOM
settings_box= {2, main_box[1]-330, main_box[1]-5, 296+ofyy1, 501+ofyy1}
--rwy_follow= {1, settings_box[2],settings_box[2]+325, settings_box[5]-20, settings_box[5]-40}
birds_deer= {1, settings_box[2],settings_box[2]+325, settings_box[5]-20, settings_box[5]-40}
fires_baloons= {1, settings_box[2],settings_box[2]+325, settings_box[5]-40, settings_box[5]-60}
carriers_frigates= {1, settings_box[2],settings_box[2]+325, settings_box[5]-60, settings_box[5]-80}
aurora_Boreals= {1, settings_box[2],settings_box[2]+325, settings_box[5]-80, settings_box[5]-100}
atmo_scatter= {1, settings_box[2],settings_box[2]+325, settings_box[5]-100, settings_box[5]-120}
vol_fog= {1, settings_box[2],settings_box[2]+325, settings_box[5]-120, settings_box[5]-140}
draw_p_pix_light= {1, settings_box[2],settings_box[2]+325, settings_box[5]-140, settings_box[5]-160}
distance_static_planes_traffic= {1, settings_box[2],settings_box[2]+325, settings_box[5]-160, settings_box[5]-180}
static_plane_density_tab= {1, settings_box[2],settings_box[2]+325, settings_box[5]-180, settings_box[5]-200}
static_plane_density0_tab= {1, settings_box[2]+126,settings_box[2]+149, settings_box[5]-180, settings_box[5]-200}
static_plane_density1_tab= {1, settings_box[2]+149,settings_box[2]+172, settings_box[5]-180, settings_box[5]-200}
static_plane_density2_tab= {1, settings_box[2]+172,settings_box[2]+195, settings_box[5]-180, settings_box[5]-200}
static_plane_density3_tab= {1, settings_box[2]+195,settings_box[2]+218, settings_box[5]-180, settings_box[5]-200}
static_plane_density4_tab= {1, settings_box[2]+218,settings_box[2]+241, settings_box[5]-180, settings_box[5]-200}
static_plane_density5_tab= {1, settings_box[2]+241,settings_box[2]+264, settings_box[5]-180, settings_box[5]-200}
static_plane_density6_tab= {1, settings_box[2]+264,settings_box[2]+287, settings_box[5]-180, settings_box[5]-200}
----Reflection detail
reflection_settings_box= {2, main_box[1]-340, main_box[1]-5, 292+ofyy1, 501+ofyy1}
use_reflective_water_box= {1, reflection_settings_box[2],reflection_settings_box[2]+335, reflection_settings_box[5]-20, reflection_settings_box[5]-40}
draw_fft_water_box= {1, reflection_settings_box[2],reflection_settings_box[2]+335, reflection_settings_box[5]-40, reflection_settings_box[5]-60}
use_3dwater_box= {1, reflection_settings_box[2],reflection_settings_box[2]+335, reflection_settings_box[5]-60, reflection_settings_box[5]-80}
draw_reflect_water05_box= {1, reflection_settings_box[2],reflection_settings_box[2]+335, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water050_box= {1, reflection_settings_box[2]+137,reflection_settings_box[2]+160, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water051_box= {1, reflection_settings_box[2]+160,reflection_settings_box[2]+183, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water052_box= {1, reflection_settings_box[2]+183,reflection_settings_box[2]+206, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water053_box= {1, reflection_settings_box[2]+206,reflection_settings_box[2]+229, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water054_box= {1, reflection_settings_box[2]+229,reflection_settings_box[2]+252, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
draw_reflect_water055_box= {1, reflection_settings_box[2]+252,reflection_settings_box[2]+275, reflection_settings_box[5]-80, reflection_settings_box[5]-100}
amp1_box= {1, reflection_settings_box[2],reflection_settings_box[2]+112, reflection_settings_box[5]-126, reflection_settings_box[5]-146}
amp2_box= {1, reflection_settings_box[2],reflection_settings_box[2]+112, reflection_settings_box[5]-146, reflection_settings_box[5]-166}
amp3_box= {1, reflection_settings_box[2],reflection_settings_box[2]+112, reflection_settings_box[5]-166, reflection_settings_box[5]-186}
amp4_box= {1, reflection_settings_box[2],reflection_settings_box[2]+112, reflection_settings_box[5]-186, reflection_settings_box[5]-209}
water_scale1_box= {1, reflection_settings_box[2]+113,reflection_settings_box[2]+224, reflection_settings_box[5]-126, reflection_settings_box[5]-146}
water_scale2_box= {1, reflection_settings_box[2]+113,reflection_settings_box[2]+224, reflection_settings_box[5]-146, reflection_settings_box[5]-166}
water_scale3_box= {1, reflection_settings_box[2]+113,reflection_settings_box[2]+224, reflection_settings_box[5]-166, reflection_settings_box[5]-186}
water_scale4_box= {1, reflection_settings_box[2]+113,reflection_settings_box[2]+224, reflection_settings_box[5]-186, reflection_settings_box[5]-209}
water_noise_speed_box= {1, reflection_settings_box[2]+225,reflection_settings_box[2]+335, reflection_settings_box[5]-126, reflection_settings_box[5]-146}
water_noise_bias_x_box= {1, reflection_settings_box[2]+225,reflection_settings_box[2]+335, reflection_settings_box[5]-146, reflection_settings_box[5]-166}
water_noise_bias_y_box= {1, reflection_settings_box[2]+225,reflection_settings_box[2]+335, reflection_settings_box[5]-166, reflection_settings_box[5]-186}
---SHADOW ON SCENERY
shadow_on_scenery_box= {2, main_box[1]-430, main_box[1]-5, 300+ofyy1, 501+ofyy1}
cascading_shadow_maps_exterior_box={1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior0_box={1, shadow_on_scenery_box[2]+237,shadow_on_scenery_box[2]+260, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior1_box={1, shadow_on_scenery_box[2]+260,shadow_on_scenery_box[2]+283, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior2_box={1, shadow_on_scenery_box[2]+283,shadow_on_scenery_box[2]+306, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior3_box={1, shadow_on_scenery_box[2]+306,shadow_on_scenery_box[2]+329, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior4_box={1, shadow_on_scenery_box[2]+329,shadow_on_scenery_box[2]+352, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_exterior5_box={1, shadow_on_scenery_box[2]+352,shadow_on_scenery_box[2]+375, shadow_on_scenery_box[5]-20, shadow_on_scenery_box[5]-40}
cascading_shadow_maps_interior_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior0_box= {1, shadow_on_scenery_box[2]+237,shadow_on_scenery_box[2]+260, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior1_box= {1, shadow_on_scenery_box[2]+260,shadow_on_scenery_box[2]+283, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior2_box= {1, shadow_on_scenery_box[2]+283,shadow_on_scenery_box[2]+306, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior3_box= {1, shadow_on_scenery_box[2]+306,shadow_on_scenery_box[2]+329, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior4_box= {1, shadow_on_scenery_box[2]+329,shadow_on_scenery_box[2]+352, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
cascading_shadow_maps_interior5_box= {1, shadow_on_scenery_box[2]+352,shadow_on_scenery_box[2]+375, shadow_on_scenery_box[5]-40, shadow_on_scenery_box[5]-60}
shadow_texture_size_cockpit_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-60, shadow_on_scenery_box[5]-80}
shadow_texture_size_clouds_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-80, shadow_on_scenery_box[5]-100}
cockpit_near_adjust_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust0_box= {1, shadow_on_scenery_box[2]+237,shadow_on_scenery_box[2]+260, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust1_box= {1, shadow_on_scenery_box[2]+260,shadow_on_scenery_box[2]+283, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust2_box= {1, shadow_on_scenery_box[2]+283,shadow_on_scenery_box[2]+306, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust3_box= {1, shadow_on_scenery_box[2]+306,shadow_on_scenery_box[2]+329, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust4_box= {1, shadow_on_scenery_box[2]+329,shadow_on_scenery_box[2]+352, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_adjust5_box= {1, shadow_on_scenery_box[2]+352,shadow_on_scenery_box[2]+375, shadow_on_scenery_box[5]-100, shadow_on_scenery_box[5]-120}
cockpit_near_proxy_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy0_box= {1, shadow_on_scenery_box[2]+237,shadow_on_scenery_box[2]+260, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy1_box= {1, shadow_on_scenery_box[2]+260,shadow_on_scenery_box[2]+283, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy2_box= {1, shadow_on_scenery_box[2]+283,shadow_on_scenery_box[2]+306, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy3_box= {1, shadow_on_scenery_box[2]+306,shadow_on_scenery_box[2]+329, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy4_box= {1, shadow_on_scenery_box[2]+329,shadow_on_scenery_box[2]+352, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
cockpit_near_proxy5_box= {1, shadow_on_scenery_box[2]+352,shadow_on_scenery_box[2]+375, shadow_on_scenery_box[5]-120, shadow_on_scenery_box[5]-140}
shadow_fade_distance_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-140, shadow_on_scenery_box[5]-160}
shadow_on_scenery_show_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-160, shadow_on_scenery_box[5]-180}
disable_shadow_prep_box= {1, shadow_on_scenery_box[2],shadow_on_scenery_box[2]+425, shadow_on_scenery_box[5]-180, shadow_on_scenery_box[5]-200}
-----Number of objects  
number_of_objects_box = {2,main_box[1]-300, main_box[1]-5, 290+ofyy1, 501+ofyy1}
triD_object_dens_box = {1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens0_box = {1,number_of_objects_box[2]+127, number_of_objects_box[2]+150, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens1_box = {1,number_of_objects_box[2]+150, number_of_objects_box[2]+173, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens2_box = {1,number_of_objects_box[2]+173, number_of_objects_box[2]+196, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens3_box = {1,number_of_objects_box[2]+196, number_of_objects_box[2]+219, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens4_box = {1,number_of_objects_box[2]+219, number_of_objects_box[2]+242, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens5_box = {1,number_of_objects_box[2]+242, number_of_objects_box[2]+265, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
triD_object_dens6_box = {1,number_of_objects_box[2]+265, number_of_objects_box[2]+288, number_of_objects_box[5]-20, number_of_objects_box[5]-40}
draw_cars_05_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_050_box={1,number_of_objects_box[2]+127, number_of_objects_box[2]+150, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_051_box={1,number_of_objects_box[2]+150, number_of_objects_box[2]+173, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_052_box={1,number_of_objects_box[2]+173, number_of_objects_box[2]+196, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_053_box={1,number_of_objects_box[2]+196, number_of_objects_box[2]+219, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_054_box={1,number_of_objects_box[2]+219, number_of_objects_box[2]+242, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_cars_055_box={1,number_of_objects_box[2]+242, number_of_objects_box[2]+265, number_of_objects_box[5]-40, number_of_objects_box[5]-60}
draw_vecs_03_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-60, number_of_objects_box[5]-80}
draw_vecs_030_box={1,number_of_objects_box[2]+127, number_of_objects_box[2]+150, number_of_objects_box[5]-60, number_of_objects_box[5]-80}
draw_vecs_031_box={1,number_of_objects_box[2]+150, number_of_objects_box[2]+173, number_of_objects_box[5]-60, number_of_objects_box[5]-80}
draw_vecs_032_box={1,number_of_objects_box[2]+173, number_of_objects_box[2]+196, number_of_objects_box[5]-60, number_of_objects_box[5]-80}
draw_vecs_033_box={1,number_of_objects_box[2]+196, number_of_objects_box[2]+219, number_of_objects_box[5]-60, number_of_objects_box[5]-80}
draw_for_05_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_050_box={1,number_of_objects_box[2]+127, number_of_objects_box[2]+150, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_051_box={1,number_of_objects_box[2]+150, number_of_objects_box[2]+173, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_052_box={1,number_of_objects_box[2]+173, number_of_objects_box[2]+196, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_053_box={1,number_of_objects_box[2]+196, number_of_objects_box[2]+219, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_054_box={1,number_of_objects_box[2]+219, number_of_objects_box[2]+242, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
draw_for_055_box={1,number_of_objects_box[2]+242, number_of_objects_box[2]+265, number_of_objects_box[5]-80, number_of_objects_box[5]-100}
inn_ring_density_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-100, number_of_objects_box[5]-120}
mid_ring_density_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-120, number_of_objects_box[5]-140}
out_ring_density_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-140, number_of_objects_box[5]-160}
draw_detail_apt_03_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-160, number_of_objects_box[5]-180}
draw_detail_apt_030_box={1,number_of_objects_box[2]+127, number_of_objects_box[2]+150, number_of_objects_box[5]-160, number_of_objects_box[5]-180}
draw_detail_apt_031_box={1,number_of_objects_box[2]+150, number_of_objects_box[2]+173, number_of_objects_box[5]-160, number_of_objects_box[5]-180}
draw_detail_apt_032_box={1,number_of_objects_box[2]+173, number_of_objects_box[2]+196, number_of_objects_box[5]-160, number_of_objects_box[5]-180}
draw_detail_apt_033_box={1,number_of_objects_box[2]+196, number_of_objects_box[2]+219, number_of_objects_box[5]-160, number_of_objects_box[5]-180}
extended_dsfs_box={1,number_of_objects_box[2], number_of_objects_box[2]+295, number_of_objects_box[5]-187, number_of_objects_box[5]-207}
---Texture quality  
texture_quality_box = {2,main_box[1]-270, main_box[1]-5, 380+ofyy1, 501+ofyy1}
draw_HDR_box={1,texture_quality_box[2], texture_quality_box[2]+265, texture_quality_box[5]-20, texture_quality_box[5]-40}
comp_texes_box={1,texture_quality_box[2], texture_quality_box[2]+265, texture_quality_box[5]-40, texture_quality_box[5]-60}
use_bump_maps_box={1,texture_quality_box[2], texture_quality_box[2]+265, texture_quality_box[5]-60, texture_quality_box[5]-80}
use_detail_textures_box={1,texture_quality_box[2], texture_quality_box[2]+265, texture_quality_box[5]-80, texture_quality_box[5]-100}
ssao_enable_box={1,texture_quality_box[2], texture_quality_box[2]+265, texture_quality_box[5]-100, texture_quality_box[5]-120}
----CLOUDS AND ATMO
cloud_and_atmo_box={2,main_box[1]-420, main_box[1]-5, 140+ofyy1, 501+ofyy1}
first_res_3d_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-20, cloud_and_atmo_box[5]-40}
last_res_3d_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-40, cloud_and_atmo_box[5]-60}
cloud_shadow_lighten_ratio_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2, cloud_and_atmo_box[5]-60, cloud_and_atmo_box[5]-80}
plot_radius_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-80, cloud_and_atmo_box[5]-100}
overdraw_control_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-100, cloud_and_atmo_box[5]-120}
ambient_gain_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-120, cloud_and_atmo_box[5]-140}
diffuse_gain_box={1,cloud_and_atmo_box[2], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-140, cloud_and_atmo_box[5]-160}
white_point_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-20, cloud_and_atmo_box[5]-40}
atmo_scale_raleigh_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-40, cloud_and_atmo_box[5]-60}
inscatter_gain_raleigh_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-60, cloud_and_atmo_box[5]-80}
min_shadow_angle_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-80, cloud_and_atmo_box[5]-100}
max_shadow_angle_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-100, cloud_and_atmo_box[5]-120}
max_dsf_vis_ever_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-120, cloud_and_atmo_box[5]-140}
dsf_fade_ratio_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-140, cloud_and_atmo_box[5]-160}
dsf_cutover_scale_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-160, cloud_and_atmo_box[5]-180}
min_tone_angle_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-180, cloud_and_atmo_box[5]-200}
max_tone_angle_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-200, cloud_and_atmo_box[5]-220}
tone_ratio_clean_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-220, cloud_and_atmo_box[5]-240}
tone_ratio_foggy_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-240, cloud_and_atmo_box[5]-260}
tone_ratio_hazy_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-260, cloud_and_atmo_box[5]-280}
tone_ratio_snowy_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-280, cloud_and_atmo_box[5]-300}
tone_ratio_ocast_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-300, cloud_and_atmo_box[5]-320}
tone_ratio_strat_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-320, cloud_and_atmo_box[5]-340}
tone_ratio_hialt_box={1,(cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-340, cloud_and_atmo_box[5]-360}

----VISIBILITY AND LIGHTS
visibility_and_lights_box={2,main_box[1]-260, main_box[1]-5, 212+ofyy1, 501+ofyy1}
visibility_reported_m_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-20, visibility_and_lights_box[5]-40}
LOD_bias_rat_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-40, visibility_and_lights_box[5]-60}
cars_lod_min_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-60, visibility_and_lights_box[5]-80}
tile_lod_bias_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-80, visibility_and_lights_box[5]-100}
fade_start_rat_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-100, visibility_and_lights_box[5]-120}
composite_far_dist_bias_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-120, visibility_and_lights_box[5]-140}
fog_be_gone_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-140, visibility_and_lights_box[5]-160}
--lights  
scale_near_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+126, visibility_and_lights_box[5]-185, visibility_and_lights_box[5]-205}
scale_far_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+126, visibility_and_lights_box[5]-205, visibility_and_lights_box[5]-225}
dist_near_box={1,visibility_and_lights_box[2]+127, visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-185, visibility_and_lights_box[5]-205}
dist_far_box={1,visibility_and_lights_box[2]+127, visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-205, visibility_and_lights_box[5]-225}
exponent_near_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+126, visibility_and_lights_box[5]-245, visibility_and_lights_box[5]-265}
exponent_far_box={1,visibility_and_lights_box[2], visibility_and_lights_box[2]+126, visibility_and_lights_box[5]-265, visibility_and_lights_box[5]-285}
bloom_near_box={1,visibility_and_lights_box[2]+127, visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-245, visibility_and_lights_box[5]-265}
bloom_far_box={1,visibility_and_lights_box[2]+127, visibility_and_lights_box[2]+255, visibility_and_lights_box[5]-265, visibility_and_lights_box[5]-285}
---PLUGIN SETTINGS
plugin_settings_item_box={2,main_box[1]-180, main_box[1]-5, 382+ofyy1, 501+ofyy1}
xenviro_enabled_box={1,plugin_settings_item_box[2], plugin_settings_item_box[2]+175, plugin_settings_item_box[5]-20, plugin_settings_item_box[5]-40}
show_help_bubble_box={1,plugin_settings_item_box[2], plugin_settings_item_box[2]+175, plugin_settings_item_box[5]-40, plugin_settings_item_box[5]-60}
load_at_start1={1,plugin_settings_item_box[2]+22,plugin_settings_item_box[5]-85,27, 27,but_load_at_start1_color,but_save_color2,9}
load_at_start2={1,plugin_settings_item_box[2]+57,plugin_settings_item_box[5]-85,27, 27,but_load_at_start2_color,but_save_color2,9}
load_at_start3={1,plugin_settings_item_box[2]+92,plugin_settings_item_box[5]-85,27, 27,but_load_at_start3_color,but_save_color2,9}
load_at_start4={1,plugin_settings_item_box[2]+127,plugin_settings_item_box[5]-85,27, 27,but_load_at_start4_color,but_save_color2,9}



end
function light_up(x1,x2,y1,y2)
graphics.set_color(1,1,1,1) 
	if MOUSE_X > x1 and MOUSE_X < x2 and MOUSE_Y > y1 and MOUSE_Y < y2 then 
		maintabcolor={0.12,0.45,0.75,1}
	else
		maintabcolor={0.15, 0.20, 0.25, 0.95}
		
	end
end
function on_start_up()
	
	if preset_loaded==1 then
		but_load_tab_color1={0,1,0,0.7}
		but_load_tab_color2={0.38, 0.38, 0.38, 1}
		but_load_tab_color3={0.38, 0.38, 0.38, 1}
		but_load_tab_color4={0.38, 0.38, 0.38, 1}
	elseif preset_loaded==2 then
		but_load_tab_color1={0.38, 0.38, 0.38, 1}
		but_load_tab_color2={0,1,0,0.7}
		but_load_tab_color3={0.38, 0.38, 0.38, 1}
		but_load_tab_color4={0.38, 0.38, 0.38, 1}
	elseif preset_loaded==3 then
		but_load_tab_color1={0.38, 0.38, 0.38, 1}
		but_load_tab_color2={0.38, 0.38, 0.38, 1}
		but_load_tab_color3={0,1,0,0.7}
		but_load_tab_color4={0.38, 0.38, 0.38, 1}	
	elseif preset_loaded==4 then
		but_load_tab_color1={0.38, 0.38, 0.38, 1}
		but_load_tab_color2={0.38, 0.38, 0.38, 1}	
		but_load_tab_color3={0.38, 0.38, 0.38, 1}
		but_load_tab_color4={0,1,0,0.7}
	else
		but_load_tab_color1={0.38, 0.38, 0.38, 1}
		but_load_tab_color2={0.38, 0.38, 0.38, 1}
		but_load_tab_color3={0.38, 0.38, 0.38, 1}
		but_load_tab_color4={0.38, 0.38, 0.38, 1}	
	end
	if time_to_save_color>run_time then
		if preset_saved==1 then
			but_save_tab_color1={0,time_to_save_color+0.38-run_time,0,0.7}
			but_save_tab_color2={0.38, 0.38, 0.38, 1}
			but_save_tab_color3={0.38, 0.38, 0.38, 1}
			but_save_tab_color4={0.38, 0.38, 0.38, 1}
		elseif preset_saved==2 then
			but_save_tab_color1={0.38, 0.38, 0.38, 1}
			but_save_tab_color2={0,time_to_save_color+0.38-run_time,0,0.7}
			but_save_tab_color3={0.38, 0.38, 0.38, 1}
			but_save_tab_color4={0.38, 0.38, 0.38, 1}
		elseif preset_saved==3 then
			but_save_tab_color1={0.38, 0.38, 0.38, 1}
			but_save_tab_color2={0.38, 0.38, 0.38, 1}
			but_save_tab_color3={0,time_to_save_color+0.38-run_time,0,0.7}
			but_save_tab_color4={0.38, 0.38, 0.38, 1}	
		elseif preset_saved==4 then
			but_save_tab_color1={0.38, 0.38, 0.38, 1}
			but_save_tab_color2={0.38, 0.38, 0.38, 1}	
			but_save_tab_color3={0.38, 0.38, 0.38, 1}
			but_save_tab_color4={0,time_to_save_color+0.38-run_time,0,0.7}
		else
			but_save_tab_color1={0.38, 0.38, 0.38, 1}
			but_save_tab_color2={0.38, 0.38, 0.38, 1}
			but_save_tab_color3={0.38, 0.38, 0.38, 1}
			but_save_tab_color4={0.38, 0.38, 0.38, 1}
		end
	else
		but_save_tab_color1={0.38, 0.38, 0.38, 1}
		but_save_tab_color2={0.38, 0.38, 0.38, 1}
		but_save_tab_color3={0.38, 0.38, 0.38, 1}
		but_save_tab_color4={0.38, 0.38, 0.38, 1}
	end
	
	
	
	
	if start_preset==1 then
		but_load_at_start1_color={0,1,0,0.7}
		but_load_at_start2_color={0.38, 0.38, 0.38, 1}
		but_load_at_start3_color={0.38, 0.38, 0.38, 1}
		but_load_at_start4_color={0.38, 0.38, 0.38, 1}
	elseif start_preset==2 then
		but_load_at_start1_color={0.38, 0.38, 0.38, 1}
		but_load_at_start2_color={0,1,0,0.7}
		but_load_at_start3_color={0.38, 0.38, 0.38, 1}
		but_load_at_start4_color={0.38, 0.38, 0.38, 1}
	elseif start_preset==3 then
		but_load_at_start1_color={0.38, 0.38, 0.38, 1}
		but_load_at_start2_color={0.38, 0.38, 0.38, 1}
		but_load_at_start3_color={0,1,0,0.7}
		but_load_at_start4_color={0.38, 0.38, 0.38, 1}	
	elseif start_preset==4 then
		but_load_at_start1_color={0.38, 0.38, 0.38, 1}
		but_load_at_start2_color={0.38, 0.38, 0.38, 1}	
		but_load_at_start3_color={0.38, 0.38, 0.38, 1}
		but_load_at_start4_color={0,1,0,0.7}
	else
		but_load_at_start1_color={0.38, 0.38, 0.38, 1}
		but_load_at_start2_color={0.38, 0.38, 0.38, 1}
		but_load_at_start3_color={0.38, 0.38, 0.38, 1}
		but_load_at_start4_color={0.38, 0.38, 0.38, 1}	
	end
	
	
	
	if rwy_follow_terrain_ref==1 then
		rwy_color={0,1,0,0.7}
		x_sliders[1]=20
	else
		rwy_color={1,0,0,1}
		x_sliders[1]=10
	end
	if draw_deer_birds_ref==1 then
		birds_color={0,1,0,0.7}
		x_sliders[2]=20
	else
		birds_color={1,0,0,1}
		x_sliders[2]=10
	end
	
	if draw_fire_ball_ref==1 then
		fires_color={0,1,0,0.7}
		x_sliders[3]=20
	else
		fires_color={1,0,0,1}
		x_sliders[3]=10
	end
	if draw_boats_ref==1 then
		carriers_color={0,1,0,0.7}
		x_sliders[4]=20
	else
		carriers_color={1,0,0,1}
		x_sliders[4]=10
	end
	if xEnviro==0 then
		if draw_aurora_ref==1 then
			aurora_color={0,1,0,0.7}
			x_sliders[5]=20
		else
			aurora_color={1,0,0,1}
			x_sliders[5]=10
		end
	else
		aurora_color={0.5,0.5,0.5,1}
		x_sliders[5]=15
	end
	if draw_scattering_ref==1 then
		atmo_color={0,1,0,0.7}
		x_sliders[6]=20
	else
		atmo_color={1,0,0,1}
		x_sliders[6]=10
	end
	if draw_volume_fog01_ref==1 then
		fog_color={0,1,0,0.7}
		x_sliders[7]=20
	else
		fog_color={1,0,0,1}
		x_sliders[7]=10
	end
	if draw_per_pix_liting_ref==1 then
		p_pix_color={0,1,0,0.7}
		x_sliders[8]=20
	else
		p_pix_color={1,0,0,1}
		x_sliders[8]=10
	end
	if use_reflective_water==1 then
		use_reflective_water_box_color={0,1,0,0.7}
		x_sliders[9]=20
	else
		use_reflective_water_box_color={1,0,0,1}
		x_sliders[9]=10
	end
	if draw_fft_water==1 then
		draw_fft_water_box_color={0,1,0,0.7}
		x_sliders[10]=20
	else
		draw_fft_water_box_color={1,0,0,1}
		x_sliders[10]=10
	end
	if use_3dwater_ref==1 then
		use_3dwater_box_color={0,1,0,0.7}
		x_sliders[18]=20
	else
		use_3dwater_box_color={1,0,0,1}
		x_sliders[18]=10
	end
	if scenery_shadows==1 then
		shadow_on_scenery_show_box_color={0,1,0,0.7}
		x_sliders[11]=20
	else
		shadow_on_scenery_show_box_color={1,0,0,1}
		x_sliders[11]=10
	end
	if disable_shadow_prep==1 then
		disable_shadow_prep_box_color={0,1,0,0.7}
		x_sliders[12]=20
	else
		disable_shadow_prep_box_color={1,0,0,1}
		x_sliders[12]=10
	end
	if draw_HDR_ref==1 then
		draw_HDR_box_color={0,1,0,0.7}
		x_sliders[13]=20
	else
		draw_HDR_box_color={1,0,0,1}
		x_sliders[13]=10
	end
	if comp_texes_ref==1 then
		comp_texes_box_color={0,1,0,0.7}
		x_sliders[14]=20
	else
		comp_texes_box_color={1,0,0,1}
		x_sliders[14]=10
	end
	if use_bump_maps_ref==1 then
		use_bump_maps_box_color={0,1,0,0.7}
		x_sliders[15]=20
	else
		use_bump_maps_box_color={1,0,0,1}
		x_sliders[15]=10
	end
	if use_detail_textures_ref==1 then
		use_detail_textures_box_color={0,1,0,0.7}
		x_sliders[16]=20
	else
		use_detail_textures_box_color={1,0,0,1}
		x_sliders[16]=10
	end
	if ssao_enable_ref==1 then
		ssao_enable_box_color={0,1,0,0.7}
		x_sliders[17]=20
	else
		ssao_enable_box_color={1,0,0,1}
		x_sliders[17]=10
	end
	if extended_dsfs_ref==1 then
		extended_dsfs_box_color={0,1,0,0.7}
		x_sliders[19]=20
	else
		extended_dsfs_box_color={1,0,0,1}
		x_sliders[19]=10
	end
	if xEnviro==1 then
		xenviro_enabled_box_color={0,1,0,0.7}
		x_sliders[20]=20
	else
		xenviro_enabled_box_color={1,0,0,1}
		x_sliders[20]=10
	end
	--if show_help_bubble==1 then
	--	show_help_bubble_box_color={0,1,0,0.7}
	--	x_sliders[21]=20
	--else
	--	show_help_bubble_box_color={1,0,0,1}
		x_sliders[21]=15
		show_help_bubble_box_color={0.5,0.5,0.5,1}
	--end
end
function draw_tab()
set_interface_pos(0,0)
x1 = main_box[1] -- = 1	(x1)
x2 = main_box[2] -- = 54	(x2)
y1 = main_box[3] -- = 451	(y1)
y2 = main_box[4] -- = 501	(y2)

	if d_tab == false or (MOUSE_X < x1+160 or MOUSE_X > x2 or MOUSE_Y < y1 or MOUSE_Y > y2) and menu_items == false then
		if d_tab == true then
			graphics.set_color(0.15, 0.20, 0.25, 0.8)
			RENDEROPTIONS.draw_filled_tab(x2-15, y2, 15, y2-y1, 10, 1)
			graphics.set_color(1, 1, 1, 0.5)
			RENDEROPTIONS.draw_tab(x2-15, y2, 15, y2-y1, 10, 1)
					
		end
	return
	end
XPLMSetGraphicsState(0,0,0,1,1,0,0)
light_up(unpack(main_box))
graphics.set_color(unpack(maintabcolor))
RENDEROPTIONS.draw_filled_tab(x1, y2, x2-x1, y2-y1, 10, 1) --graphics.draw_rectangle(x1, y1, x2, y2)
graphics.set_color(1, 1, 1, 1)
--[[draw_string_Helvetica_12(200, 		230, 		tostring(settings_file))
draw_string_Helvetica_12(200, 		220, 		tostring(xEnviro))
draw_string_Helvetica_12(200, 		210, 		tostring(show_help_bubble))
draw_string_Helvetica_12(200, 		200, 		start_preset)
draw_string_Helvetica_12(200, 		180, 		ofy)
draw_string_Helvetica_12(200, 		160, 		ofyy1)
draw_string_Helvetica_12(200, 		140, 		tostring(on_start_sim))
draw_string_Helvetica_12(200, 		120, 		tostring(need_reload))]]--
draw_string_Times_Roman_24(main_box[1]+1, main_box[3]+25, "Rendering options")
draw_string(main_box[1]+90, main_box[3]+5, "v" .. version)
graphics.set_color(1, 1, 1, 0.5)
RENDEROPTIONS.draw_tab(x1, y2, x2-x1, y2-y1, 10, 1)

end
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
function draw_menu_items()
	if d_tab==false or menu_items==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_tab(menu_items_box[2], menu_items_box[5], menu_items_box[3]-menu_items_box[2], menu_items_box[5]-menu_items_box[4], 10, 1)
	RENDEROPTIONS.draw_filled_tab(menu_load_tab[2], menu_load_tab[5], menu_load_tab[3]-menu_load_tab[2], menu_load_tab[5]-menu_load_tab[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_tab(menu_items_box[2], menu_items_box[5], menu_items_box[3]-menu_items_box[2], menu_items_box[5]-menu_items_box[4], 10, 1)
	RENDEROPTIONS.draw_tab(menu_load_tab[2], menu_load_tab[5], menu_load_tab[3]-menu_load_tab[2], menu_load_tab[5]-menu_load_tab[4], 10, 1)
	graphics.set_color(0.15, 0.20, 0.25, 0.8)
	draw_button(unpack(buttontest))
	draw_button(unpack(set_to_default_item))
	draw_button(unpack(save_tab_1))
	draw_button(unpack(save_tab_2))
	draw_button(unpack(save_tab_3))
	draw_button(unpack(save_tab_4))
	draw_button(unpack(load_tab_1))
	draw_button(unpack(load_tab_2))
	draw_button(unpack(load_tab_3))
	draw_button(unpack(load_tab_4))
	if tab_misc==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(misc_random_item[2]+30, misc_random_item[4]-25, misc_random_item[3]-16, misc_random_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)	
	end
	draw_string_Helvetica_18(misc_random_item[2]+30, 		misc_random_item[4]-22, 		"MISC/RANDOM")
	
	if tab_reflection_detail_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(reflection_detail_item[2]+16, reflection_detail_item[4]-25, reflection_detail_item[3]-10, reflection_detail_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(reflection_detail_item[2]+16, 		reflection_detail_item[4]-22, 		"Water & Reflection")
	if tab_shadows_on_scenery_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(shadows_on_scenery_item[2]+5, shadows_on_scenery_item[4]-25, shadows_on_scenery_item[3]-5, shadows_on_scenery_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(shadows_on_scenery_item[2]+5, 		shadows_on_scenery_item[4]-22, 		"Shadows on scenery")
	if tab_num_of_world_obj_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(num_of_world_obj_item[2]+15, num_of_world_obj_item[4]-25, num_of_world_obj_item[3]-15, num_of_world_obj_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(num_of_world_obj_item[2]+15, 		num_of_world_obj_item[4]-22, 		"Number of objects")
	if tab_texture_quality_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(texture_quality_item[2]+30, texture_quality_item[4]-25, texture_quality_item[3]-30, texture_quality_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(texture_quality_item[2]+30, 		texture_quality_item[4]-22, 		"Texture quality")
	
	if tab_clouds_and_sky_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(clouds_and_sky_item[2]+22, clouds_and_sky_item[4]-25, clouds_and_sky_item[3]-22, clouds_and_sky_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(clouds_and_sky_item[2]+22, 		clouds_and_sky_item[4]-22, 		"Clouds and atmo")
	if tab_visibility_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(visibility_item[2]+11, visibility_item[4]-25, visibility_item[3]-11, visibility_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(visibility_item[2]+11, 		visibility_item[4]-22, 		"Visibility and Lights")
	if tab_plugin_settins_item==false then
		graphics.set_color(0.6, 0.6, 0.6, 1)
	else
		graphics.set_color(unpack(but_color11))
		graphics.draw_rectangle(plugin_settins_item[2]+30, plugin_settins_item[4]-25, plugin_settins_item[3]-30, plugin_settins_item[5])
		graphics.set_color(0.92, 0.93, 0.93, 1)
	end
	draw_string_Helvetica_18(plugin_settins_item[2]+30, 		plugin_settins_item[4]-22, 		"Plugin settings")
	
	if need_reload==false then
		but_color1={0.38, 0.38, 0.38, 1}
	else
		but_color1={0.12,0.45,0.75,1}
	end
	
	graphics.set_color(0.92, 0.93, 0.93, 1)
	draw_string_Helvetica_18(set_to_default_item[2]+7, 		set_to_default_item[3]-22, 		"Defaults")
	graphics.set_color(1, 1, 1, 1)
	draw_string_Helvetica_18(buttontest[2]+15, 		buttontest[3]-22, 		"Apply")
	draw_string_Helvetica_18(menu_load_tab[2]+5, 		menu_load_tab[5]-25, 		"SAVE")
	draw_string_Helvetica_18(menu_load_tab[2]+5, 		menu_load_tab[5]-65, 		"LOAD")
	draw_string_Helvetica_18(save_tab_1[2]+8, 		save_tab_1[3]-19, 		"1")
	draw_string_Helvetica_18(save_tab_2[2]+8, 		save_tab_2[3]-19, 		"2")
	draw_string_Helvetica_18(save_tab_3[2]+8, 		save_tab_3[3]-19, 		"3")
	draw_string_Helvetica_18(save_tab_4[2]+8, 		save_tab_4[3]-19, 		"4")
	draw_string_Helvetica_18(load_tab_1[2]+8, 		load_tab_1[3]-19, 		"1")
	draw_string_Helvetica_18(load_tab_2[2]+8, 		load_tab_2[3]-19, 		"2")
	draw_string_Helvetica_18(load_tab_3[2]+8, 		load_tab_3[3]-19, 		"3")
	draw_string_Helvetica_18(load_tab_4[2]+8, 		load_tab_4[3]-19, 		"4")
end
function draw_main_misc_settings()
	if d_tab==false or tab_misc==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(settings_box[2], settings_box[5], settings_box[3]-settings_box[2], settings_box[5]-settings_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(settings_box[2], settings_box[5], settings_box[3]-settings_box[2], settings_box[5]-settings_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	--graphics.set_color(unpack(rwy_color))
	--RENDEROPTIONS.draw_filled_button(rwy_follow[2]+4, rwy_follow[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(birds_color))
	RENDEROPTIONS.draw_filled_button(birds_deer[2]+4, birds_deer[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(fires_color))
	RENDEROPTIONS.draw_filled_button(fires_baloons[2]+4, fires_baloons[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(carriers_color))
	RENDEROPTIONS.draw_filled_button(carriers_frigates[2]+4, carriers_frigates[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(aurora_color))
	RENDEROPTIONS.draw_filled_button(aurora_Boreals[2]+4, aurora_Boreals[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(atmo_color))
	RENDEROPTIONS.draw_filled_button(atmo_scatter[2]+4, atmo_scatter[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(fog_color))
	RENDEROPTIONS.draw_filled_button(vol_fog[2]+4, vol_fog[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(p_pix_color))
	RENDEROPTIONS.draw_filled_button(draw_p_pix_light[2]+4, draw_p_pix_light[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	--graphics.draw_filled_circle(rwy_follow[2]+x_sliders[1],rwy_follow[4]-10, 5)
	graphics.draw_filled_circle(birds_deer[2]+x_sliders[2],birds_deer[4]-10, 5)
	graphics.draw_filled_circle(fires_baloons[2]+x_sliders[3],fires_baloons[4]-10, 5)
	graphics.draw_filled_circle(carriers_frigates[2]+x_sliders[4],carriers_frigates[4]-10, 5)
	graphics.draw_filled_circle(aurora_Boreals[2]+x_sliders[5],aurora_Boreals[4]-10, 5)
	graphics.draw_filled_circle(atmo_scatter[2]+x_sliders[6],atmo_scatter[4]-10, 5)
	graphics.draw_filled_circle(vol_fog[2]+x_sliders[7],vol_fog[4]-10, 5)
	graphics.draw_filled_circle(draw_p_pix_light[2]+x_sliders[8],draw_p_pix_light[4]-10, 5)
	graphics.draw_line(settings_box[2], settings_box[5]-20, settings_box[3], settings_box[5]-20)
	graphics.draw_line(draw_p_pix_light[2], draw_p_pix_light[5], draw_p_pix_light[3], draw_p_pix_light[5])
	draw_string_Helvetica_18(settings_box[2]+30, 		settings_box[5]-17, 		"MISC/RANDOM")
	--draw_string_Helvetica_12(rwy_follow[2]+30, 		rwy_follow[5]+5, 		RWY_FOLLOW_TEXT)
	draw_string_Helvetica_12(birds_deer[2]+30, 		birds_deer[5]+5, 		"Draw birds and deer in nice weather")
	draw_string_Helvetica_12(fires_baloons[2]+30, 		fires_baloons[5]+5, 		"Draw fires and baloons")
	draw_string_Helvetica_12(carriers_frigates[2]+30, 		carriers_frigates[5]+5, 		"Draw aircraft carriers and frigates")
	draw_string_Helvetica_12(aurora_Boreals[2]+30, 		aurora_Boreals[5]+5, 		"Draw aurora Borealis")
	draw_string_Helvetica_12(atmo_scatter[2]+30, 		atmo_scatter[5]+5, 		"Atmospheric scattering")
	draw_string_Helvetica_12(vol_fog[2]+30, 		vol_fog[5]+5, 		"Draw volumetric fog")
	draw_string_Helvetica_12(draw_p_pix_light[2]+30, 		draw_p_pix_light[5]+5, 		"Draw per pixel lightning")
	draw_string_Helvetica_12(distance_static_planes_traffic[2]+5, 		distance_static_planes_traffic[5]+5, 		"Distance at which static planes are visible:")
	draw_string_Helvetica_12(distance_static_planes_traffic[2]+265, 		distance_static_planes_traffic[5]+5, 		static_plane_build_vis)
	draw_string_Helvetica_12(static_plane_density_tab[2]+5, 		static_plane_density_tab[5]+5, 		"Static plane density:    0    1    2    3    4    5    6")
	graphics.set_color(0, 1, 0, 0.7)
	graphics.draw_rectangle(static_plane_density_tab[2]+126+23*static_plane_density, static_plane_density_tab[5]+2, static_plane_density_tab[2]+148+23*static_plane_density, static_plane_density_tab[5]-3)
end
function draw_reflection_detail()
	if d_tab==false or tab_reflection_detail_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(reflection_settings_box[2], reflection_settings_box[5], reflection_settings_box[3]-reflection_settings_box[2], reflection_settings_box[5]-reflection_settings_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(reflection_settings_box[2], reflection_settings_box[5], reflection_settings_box[3]-reflection_settings_box[2], reflection_settings_box[5]-reflection_settings_box[4], 10, 1)
	graphics.set_color(unpack(use_reflective_water_box_color))
	RENDEROPTIONS.draw_filled_button(use_reflective_water_box[2]+4, use_reflective_water_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(draw_fft_water_box_color))
	RENDEROPTIONS.draw_filled_button(draw_fft_water_box[2]+4, draw_fft_water_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(use_3dwater_box_color))
	RENDEROPTIONS.draw_filled_button(use_3dwater_box[2]+4, use_3dwater_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_filled_circle(use_reflective_water_box[2]+x_sliders[9],use_reflective_water_box[4]-10, 5)
	graphics.draw_filled_circle(draw_fft_water_box[2]+x_sliders[10],draw_fft_water_box[4]-10, 5)
	graphics.draw_filled_circle(use_3dwater_box[2]+x_sliders[18],use_3dwater_box[4]-10, 5)
	graphics.draw_line(reflection_settings_box[2], reflection_settings_box[5]-20, reflection_settings_box[3], reflection_settings_box[5]-20)
	graphics.draw_line(use_3dwater_box[2], use_3dwater_box[5], use_3dwater_box[3], use_3dwater_box[5])
	draw_string_Helvetica_18(reflection_settings_box[2]+30, 		reflection_settings_box[5]-17, 		"Water and reflection")
	draw_string_Helvetica_12(use_reflective_water_box[2]+30, 		use_reflective_water_box[5]+5, 		"Reflective water (main reflection)")
	draw_string_Helvetica_12(draw_fft_water_box[2]+30, 		draw_fft_water_box[5]+5, 		"Draw FFT water (waves)")
	draw_string_Helvetica_12(use_3dwater_box[2]+30, 		use_3dwater_box[5]+5, 		"Use 3D water")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+5, 		draw_reflect_water05_box[5]+5, 		"Water reflection detail:    0    1    2    3    4    5    ")
	graphics.set_color(0, 1, 0, 0.7)
	graphics.draw_rectangle(draw_reflect_water05_box[2]+137+23*draw_reflect_water05, draw_reflect_water05_box[5]+2, draw_reflect_water05_box[2]+159+23*draw_reflect_water05, draw_reflect_water05_box[5]-3)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_line(draw_reflect_water05_box[2], draw_reflect_water05_box[5]-5, draw_reflect_water05_box[3], draw_reflect_water05_box[5]-5)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+10, 		draw_reflect_water05_box[5]-19, 		"Waves amplitude")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+132, 		draw_reflect_water05_box[5]-19, 		"Waves scale")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+238, 		draw_reflect_water05_box[5]-19, 		"Water speed")
	graphics.draw_line(draw_reflect_water05_box[2]+112, draw_reflect_water05_box[5]-108, draw_reflect_water05_box[2]+112, draw_reflect_water05_box[5]-5)
	graphics.draw_line(draw_reflect_water05_box[2]+224, draw_reflect_water05_box[5]-108, draw_reflect_water05_box[2]+224, draw_reflect_water05_box[5]-5)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+15, 		draw_reflect_water05_box[5]-40, 		"Amp1:      " .. round(fft_amp1_ref,2))
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+15, 		draw_reflect_water05_box[5]-60, 		"Amp2:      " .. round(fft_amp2_ref,2))
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+15, 		draw_reflect_water05_box[5]-80, 		"Amp3:      " .. round(fft_amp3_ref,2))
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+15, 		draw_reflect_water05_box[5]-100, 		"Amp4:      " .. round(fft_amp4_ref,2))
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+133, 		draw_reflect_water05_box[5]-40, 		"Scale1:   " .. fft_scale1_ref)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+133, 		draw_reflect_water05_box[5]-60, 		"Scale2:   " .. fft_scale2_ref)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+133, 		draw_reflect_water05_box[5]-80, 		"Scale3:   " .. fft_scale3_ref)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+133, 		draw_reflect_water05_box[5]-100, 		"Scale4:   " .. fft_scale4_ref)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+228, 		draw_reflect_water05_box[5]-40, 		"Noise speed:")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+228, 		draw_reflect_water05_box[5]-60, 		"Noise bias X:")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+228, 		draw_reflect_water05_box[5]-80, 		"Noise bias Y:")
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+305, 		draw_reflect_water05_box[5]-40, 		round(noise_speed_ref,2))
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+305, 		draw_reflect_water05_box[5]-60, 		noise_bias_gen_x_ref)
	draw_string_Helvetica_12(draw_reflect_water05_box[2]+305, 		draw_reflect_water05_box[5]-80, 		noise_bias_gen_y_ref)	
end
function draw_shadow_on_scenery()
	if d_tab==false or tab_shadows_on_scenery_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(shadow_on_scenery_box[2], shadow_on_scenery_box[5], shadow_on_scenery_box[3]-shadow_on_scenery_box[2], shadow_on_scenery_box[5]-shadow_on_scenery_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(shadow_on_scenery_box[2], shadow_on_scenery_box[5], shadow_on_scenery_box[3]-shadow_on_scenery_box[2], shadow_on_scenery_box[5]-shadow_on_scenery_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 0)
	graphics.set_color(unpack(shadow_on_scenery_show_box_color))
	RENDEROPTIONS.draw_filled_button(shadow_on_scenery_show_box[2]+4, shadow_on_scenery_show_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(disable_shadow_prep_box_color))
	RENDEROPTIONS.draw_filled_button(disable_shadow_prep_box[2]+4, disable_shadow_prep_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_filled_circle(shadow_on_scenery_show_box[2]+x_sliders[11],shadow_on_scenery_show_box[4]-10, 5)
	graphics.draw_filled_circle(disable_shadow_prep_box[2]+x_sliders[12],disable_shadow_prep_box[4]-10, 5)
	graphics.draw_line(shadow_on_scenery_box[2], shadow_on_scenery_box[5]-20, shadow_on_scenery_box[3], shadow_on_scenery_box[5]-20)
	graphics.draw_line(cockpit_near_proxy_box[2], cockpit_near_proxy_box[5]-20, cockpit_near_proxy_box[3], cockpit_near_proxy_box[5]-20)
	draw_string_Helvetica_18(shadow_on_scenery_box[2]+30, 		shadow_on_scenery_box[5]-17, 		"Shadows on the scenery and cockpit")
	draw_string_Helvetica_12(cascading_shadow_maps_exterior_box[2]+5, 		cascading_shadow_maps_exterior_box[5]+5, 		"Cascading shadow maps exterior quality:")
	draw_string_Helvetica_12(cascading_shadow_maps_exterior_box[2]+245, 		cascading_shadow_maps_exterior_box[5]+5, 		"0    1    2    3    4    5")
	draw_string_Helvetica_12(cascading_shadow_maps_interior_box[2]+5, 		cascading_shadow_maps_interior_box[5]+5, 		"Cascading shadow maps interior quality:")
	draw_string_Helvetica_12(cascading_shadow_maps_interior_box[2]+245, 		cascading_shadow_maps_interior_box[5]+5, 		"0    1    2    3    4    5")
	draw_string_Helvetica_12(shadow_texture_size_cockpit_box[2]+5, 		shadow_texture_size_cockpit_box[5]+5, 		"Shadow texture size in the cockpit:")
	draw_string_Helvetica_12(shadow_texture_size_cockpit_box[2]+245, 		shadow_texture_size_cockpit_box[5]+5, 		shadow_cam_size)
	draw_string_Helvetica_12(shadow_texture_size_clouds_box[2]+5, 		shadow_texture_size_clouds_box[5]+5, 		"Clouds shadow texture size:")
	draw_string_Helvetica_12(shadow_texture_size_clouds_box[2]+245, 		shadow_texture_size_clouds_box[5]+5, 		shadow_size)
	draw_string_Helvetica_12(cockpit_near_adjust_box[2]+5, 		cockpit_near_adjust_box[5]+5, 		"Shadow cockpit near adjust:")
	draw_string_Helvetica_12(cockpit_near_adjust_box[2]+245, 		cockpit_near_adjust_box[5]+5, 		"0    1    2    3    4    5")
	draw_string_Helvetica_12(cockpit_near_proxy_box[2]+5, 		cockpit_near_proxy_box[5]+5, 		"Shadow cockpit near proxy:")
	draw_string_Helvetica_12(cockpit_near_proxy_box[2]+245, 		cockpit_near_proxy_box[5]+5, 		"0    1    2    3    4    5")
	draw_string_Helvetica_12(shadow_fade_distance_box[2]+5, 		shadow_fade_distance_box[5]+5, 		"Shadow fade distance:")
	draw_string_Helvetica_12(shadow_fade_distance_box[2]+245, 		shadow_fade_distance_box[5]+5, 		far_limit)
	draw_string_Helvetica_12(shadow_on_scenery_show_box[2]+30, 		shadow_on_scenery_show_box[5]+5, 		"Show scenery shadows (trees, buildings)")
	draw_string_Helvetica_12(disable_shadow_prep_box[2]+30, 		disable_shadow_prep_box[5]+5, 		"Disable any shadows in X-Plane")
	graphics.set_color(0, 1, 0, 0.7)
	graphics.draw_rectangle(cascading_shadow_maps_exterior_box[2]+237+23*csm_split_exterior, cascading_shadow_maps_exterior_box[5]+2, cascading_shadow_maps_exterior_box[2]+259+23*csm_split_exterior, cascading_shadow_maps_exterior_box[5]-3)
	graphics.draw_rectangle(cascading_shadow_maps_interior_box[2]+237+23*csm_split_interior, cascading_shadow_maps_interior_box[5]+2, cascading_shadow_maps_interior_box[2]+259+23*csm_split_interior, cascading_shadow_maps_interior_box[5]-3)
	graphics.draw_rectangle(cockpit_near_adjust_box[2]+237+23*cockpit_near_adjust, cockpit_near_adjust_box[5]+2, cockpit_near_adjust_box[2]+259+23*cockpit_near_adjust, cockpit_near_adjust_box[5]-3)
	graphics.draw_rectangle(cockpit_near_proxy_box[2]+237+23*cockpit_near_proxy, cockpit_near_proxy_box[5]+2, cockpit_near_proxy_box[2]+259+23*cockpit_near_proxy, cockpit_near_proxy_box[5]-3)
end
function draw_number_of_objects()
	if d_tab==false or tab_num_of_world_obj_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(number_of_objects_box[2], number_of_objects_box[5], number_of_objects_box[3]-number_of_objects_box[2], number_of_objects_box[5]-number_of_objects_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(number_of_objects_box[2], number_of_objects_box[5], number_of_objects_box[3]-number_of_objects_box[2], number_of_objects_box[5]-number_of_objects_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_line(number_of_objects_box[2], number_of_objects_box[5]-20, number_of_objects_box[3], number_of_objects_box[5]-20)
	draw_string_Helvetica_18(number_of_objects_box[2]+10, 		number_of_objects_box[5]-17, 		"Number of world objects")
	draw_string_Helvetica_12(triD_object_dens_box[2]+5, 		triD_object_dens_box[5]+5, 		"Object density:")
	draw_string_Helvetica_12(triD_object_dens_box[2]+135, 		triD_object_dens_box[5]+5, 		"0    1    2    3    4    5    6")
	draw_string_Helvetica_12(draw_cars_05_box[2]+5, 		draw_cars_05_box[5]+5, 		"Traffic density:")
	draw_string_Helvetica_12(draw_cars_05_box[2]+135, 		draw_cars_05_box[5]+5, 		"0    1    2    3    4    5 ")
	draw_string_Helvetica_12(draw_vecs_03_box[2]+5, 		draw_vecs_03_box[5]+5, 		"Road density:")
	draw_string_Helvetica_12(draw_vecs_03_box[2]+135, 		draw_vecs_03_box[5]+5, 		"0    1    2    3 ")
	draw_string_Helvetica_12(draw_for_05_box[2]+5, 		draw_for_05_box[5]+5, 		"Forest density:")
	draw_string_Helvetica_12(draw_for_05_box[2]+135, 		draw_for_05_box[5]+5, 		"0    1    2    3    4    5 ")
	draw_string_Helvetica_12(inn_ring_density_box[2]+5, 		inn_ring_density_box[5]+5, 		"Forest inner:")
	draw_string_Helvetica_12(inn_ring_density_box[2]+135, 		inn_ring_density_box[5]+5, 		round(inn_ring_density_ref,2))
	draw_string_Helvetica_12(mid_ring_density_box[2]+5, 		mid_ring_density_box[5]+5, 		"Forest middle:")
	draw_string_Helvetica_12(mid_ring_density_box[2]+135, 		mid_ring_density_box[5]+5, 		round(mid_ring_density_ref,2))
	draw_string_Helvetica_12(out_ring_density_box[2]+5, 		out_ring_density_box[5]+5, 		"Forest outer:")
	draw_string_Helvetica_12(out_ring_density_box[2]+135, 		out_ring_density_box[5]+5, 		round(out_ring_density_ref,2))
	draw_string_Helvetica_12(draw_detail_apt_03_box[2]+5, 		draw_detail_apt_03_box[5]+5, 		"Airport detail quality:")
	draw_string_Helvetica_12(draw_detail_apt_03_box[2]+135, 		draw_detail_apt_03_box[5]+5, 		"0    1    2    3 ")
	graphics.set_color(0, 1, 0, 0.7)
	graphics.draw_rectangle(triD_object_dens_box[2]+127+23*draw_objs_06_ref, triD_object_dens_box[5]+2, triD_object_dens_box[2]+149+23*draw_objs_06_ref, triD_object_dens_box[5]-3)
	graphics.draw_rectangle(draw_cars_05_box[2]+127+23*draw_cars_05_ref, draw_cars_05_box[5]+2, draw_cars_05_box[2]+149+23*draw_cars_05_ref, draw_cars_05_box[5]-3)
	graphics.draw_rectangle(draw_vecs_03_box[2]+127+23*draw_vecs_03_ref, draw_vecs_03_box[5]+2, draw_vecs_03_box[2]+149+23*draw_vecs_03_ref, draw_vecs_03_box[5]-3)
	graphics.draw_rectangle(draw_for_05_box[2]+127+23*draw_for_05_ref, draw_for_05_box[5]+2, draw_for_05_box[2]+149+23*draw_for_05_ref, draw_for_05_box[5]-3)
	graphics.draw_rectangle(draw_detail_apt_03_box[2]+127+23*draw_detail_apt_03_ref, draw_detail_apt_03_box[5]+2, draw_detail_apt_03_box[2]+149+23*draw_detail_apt_03_ref, draw_detail_apt_03_box[5]-3)
	graphics.set_color(unpack(extended_dsfs_box_color))
	RENDEROPTIONS.draw_filled_button(extended_dsfs_box[2]+4, extended_dsfs_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_filled_circle(extended_dsfs_box[2]+x_sliders[19],extended_dsfs_box[4]-10, 5)
	graphics.draw_line(draw_detail_apt_03_box[2], draw_detail_apt_03_box[5]-5, draw_detail_apt_03_box[3], draw_detail_apt_03_box[5]-5)
	draw_string_Helvetica_12(extended_dsfs_box[2]+30, 		extended_dsfs_box[5]+5, 		"Extended DSFS")
end
function texture_quality()
	if d_tab==false or tab_texture_quality_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(texture_quality_box[2], texture_quality_box[5], texture_quality_box[3]-texture_quality_box[2], texture_quality_box[5]-texture_quality_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(texture_quality_box[2], texture_quality_box[5], texture_quality_box[3]-texture_quality_box[2], texture_quality_box[5]-texture_quality_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_line(texture_quality_box[2], texture_quality_box[5]-20, texture_quality_box[3], texture_quality_box[5]-20)
	draw_string_Helvetica_18(texture_quality_box[2]+10, 		texture_quality_box[5]-17, 		"Texture quality")
	graphics.set_color(unpack(draw_HDR_box_color))
	RENDEROPTIONS.draw_filled_button(draw_HDR_box[2]+4, draw_HDR_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(comp_texes_box_color))
	RENDEROPTIONS.draw_filled_button(comp_texes_box[2]+4, comp_texes_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(use_bump_maps_box_color))
	RENDEROPTIONS.draw_filled_button(use_bump_maps_box[2]+4, use_bump_maps_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(use_detail_textures_box_color))
	RENDEROPTIONS.draw_filled_button(use_detail_textures_box[2]+4, use_detail_textures_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(ssao_enable_box_color))
	RENDEROPTIONS.draw_filled_button(ssao_enable_box[2]+4, ssao_enable_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_filled_circle(draw_HDR_box[2]+x_sliders[13],draw_HDR_box[4]-10, 5)
	graphics.draw_filled_circle(comp_texes_box[2]+x_sliders[14],comp_texes_box[4]-10, 5)
	graphics.draw_filled_circle(use_bump_maps_box[2]+x_sliders[15],use_bump_maps_box[4]-10, 5)
	graphics.draw_filled_circle(use_detail_textures_box[2]+x_sliders[16],use_detail_textures_box[4]-10, 5)
	graphics.draw_filled_circle(ssao_enable_box[2]+x_sliders[17],ssao_enable_box[4]-10, 5)
	draw_string_Helvetica_12(draw_HDR_box[2]+30, 		draw_HDR_box[5]+5, 		"Draw HDR")
	draw_string_Helvetica_12(comp_texes_box[2]+30, 		comp_texes_box[5]+5, 		"Compress textures to save VRAM")
	draw_string_Helvetica_12(use_bump_maps_box[2]+30, 		use_bump_maps_box[5]+5, 		"Use bump textures")
	draw_string_Helvetica_12(use_detail_textures_box[2]+30, 		use_detail_textures_box[5]+5, 		"Use detail (aka gritty) textures of decals")
	draw_string_Helvetica_12(ssao_enable_box[2]+30, 		ssao_enable_box[5]+5, 		"Ambient occlusion")
end
function draw_clouds_and_atmo()
	if d_tab==false or tab_clouds_and_sky_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(cloud_and_atmo_box[2], cloud_and_atmo_box[5], cloud_and_atmo_box[3]-cloud_and_atmo_box[2], cloud_and_atmo_box[5]-cloud_and_atmo_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(cloud_and_atmo_box[2], cloud_and_atmo_box[5], cloud_and_atmo_box[3]-cloud_and_atmo_box[2], cloud_and_atmo_box[5]-cloud_and_atmo_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_line(cloud_and_atmo_box[2], cloud_and_atmo_box[5]-20, cloud_and_atmo_box[3], cloud_and_atmo_box[5]-20)
	draw_string_Helvetica_18(cloud_and_atmo_box[2]+60, 		cloud_and_atmo_box[5]-17, 		"Clouds")
	draw_string_Helvetica_18((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2 +40, 		cloud_and_atmo_box[5]-17, 		"Atmosphere")
	graphics.draw_line((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[4], (cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-30, cloud_and_atmo_box[5]-20)
	draw_string_Helvetica_12(first_res_3d_box[2]+5, 		first_res_3d_box[5]+5, 		"First resolution 3D:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		first_res_3d_box[5]+5, 		first_res_3d_ref)
	draw_string_Helvetica_12(last_res_3d_box[2]+5, 		last_res_3d_box[5]+5, 		"Last resolution 3D:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60,	last_res_3d_box[5]+5, 		last_res_3d_ref)
	draw_string_Helvetica_12(cloud_shadow_lighten_ratio_box[2]+5, 		cloud_shadow_lighten_ratio_box[5]+5, 		"Shadow lighten ratio:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		cloud_shadow_lighten_ratio_box[5]+5, 		round(cloud_shadow_lighten_ratio_ref,2))
	draw_string_Helvetica_12(plot_radius_box[2]+5, 		plot_radius_box[5]+5, 		"Plot radius:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		plot_radius_box[5]+5, 		round(plot_radius_ref,2))
	draw_string_Helvetica_12(overdraw_control_box[2]+5, 		overdraw_control_box[5]+5, 		"Overdraw control:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		overdraw_control_box[5]+5, 		round(overdraw_control_ref,2))
	draw_string_Helvetica_12(ambient_gain_box[2]+5, 		ambient_gain_box[5]+5, 		"Ambient gain:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		ambient_gain_box[5]+5, 		round(ambient_gain_ref,1))
	draw_string_Helvetica_12(diffuse_gain_box[2]+5, 		diffuse_gain_box[5]+5, 		"Diffuse gain:")
	draw_string_Helvetica_12((cloud_and_atmo_box[2]+cloud_and_atmo_box[3])/2-60, 		diffuse_gain_box[5]+5, 		round(diffuse_gain_ref,1))
	draw_string_Helvetica_12(white_point_box[2]+5, 		white_point_box[5]+5, 		"White point:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		white_point_box[5]+5, 		round(white_point_ref,1))
	if xEnviro==0 then
		draw_string_Helvetica_12(atmo_scale_raleigh_box[2]+5, 		atmo_scale_raleigh_box[5]+5, 		"Atmo scale raleigh:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		atmo_scale_raleigh_box[5]+5, 		round(atmo_scale_raleigh_ref,1))
		draw_string_Helvetica_12(inscatter_gain_raleigh_box[2]+5, 		inscatter_gain_raleigh_box[5]+5, 		"Inscatter gane raleigh:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		inscatter_gain_raleigh_box[5]+5, 		round(inscatter_gain_raleigh_ref,1))
	else
		graphics.set_color(0.5, 0.5, 0.5, 1)
		draw_string_Helvetica_12(atmo_scale_raleigh_box[2]+5, 		atmo_scale_raleigh_box[5]+5, 		"Atmo scale raleigh:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		atmo_scale_raleigh_box[5]+5, 		round(atmo_scale_raleigh_ref,1))
		draw_string_Helvetica_12(inscatter_gain_raleigh_box[2]+5, 		inscatter_gain_raleigh_box[5]+5, 		"Inscatter gane raleigh:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		inscatter_gain_raleigh_box[5]+5, 		round(inscatter_gain_raleigh_ref,1))
		graphics.set_color(1, 1, 1, 1)
	end
	draw_string_Helvetica_12(min_shadow_angle_box[2]+5, 		min_shadow_angle_box[5]+5, 		"Min shadow angle:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		min_shadow_angle_box[5]+5, 		min_shadow_angle_ref)
	draw_string_Helvetica_12(max_shadow_angle_box[2]+5, 		max_shadow_angle_box[5]+5, 		"Max shadow angle:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		max_shadow_angle_box[5]+5, 		max_shadow_angle_ref)
	draw_string_Helvetica_12(max_dsf_vis_ever_box[2]+5, 		max_dsf_vis_ever_box[5]+5, 		"Max DSF visibility:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		max_dsf_vis_ever_box[5]+5, 		max_dsf_vis_ever_ref)
	draw_string_Helvetica_12(dsf_fade_ratio_box[2]+5, 		dsf_fade_ratio_box[5]+5, 		"DSF fade ratio:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		dsf_fade_ratio_box[5]+5, 		round(dsf_fade_ratio_ref,2))
	draw_string_Helvetica_12(dsf_cutover_scale_box[2]+5, 		dsf_cutover_scale_box[5]+5, 		"DSF cutover scale:")
	draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		dsf_cutover_scale_box[5]+5, 		round(dsf_cutover_scale_ref,2))
	if xEnviro==0 then
		draw_string_Helvetica_12(min_tone_angle_box[2]+5, 		min_tone_angle_box[5]+5, 		"Min tone angle:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		min_tone_angle_box[5]+5, 		min_tone_angle_ref)
		draw_string_Helvetica_12(max_tone_angle_box[2]+5, 		max_tone_angle_box[5]+5, 		"Max tone angle:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		max_tone_angle_box[5]+5, 		max_tone_angle_ref)
		draw_string_Helvetica_12(tone_ratio_clean_box[2]+5, 		tone_ratio_clean_box[5]+5, 		"Tone ratio in good weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_clean_box[5]+5, 		round(tone_ratio_clean_ref,1))
		draw_string_Helvetica_12(tone_ratio_foggy_box[2]+5, 		tone_ratio_foggy_box[5]+5, 		"Tone ratio in foggy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_foggy_box[5]+5, 		round(tone_ratio_foggy_ref,1))
		draw_string_Helvetica_12(tone_ratio_hazy_box[2]+5, 		tone_ratio_hazy_box[5]+5, 		"Tone ratio in hazy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_hazy_box[5]+5, 		round(tone_ratio_hazy_ref,1))
		draw_string_Helvetica_12(tone_ratio_snowy_box[2]+5, 		tone_ratio_snowy_box[5]+5, 		"Tone ratio in snowy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_snowy_box[5]+5, 		round(tone_ratio_snowy_ref,1))
		draw_string_Helvetica_12(tone_ratio_ocast_box[2]+5, 		tone_ratio_ocast_box[5]+5, 		"Tone ratio in overcast weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_ocast_box[5]+5, 		round(tone_ratio_ocast_ref,1))
		draw_string_Helvetica_12(tone_ratio_strat_box[2]+5, 		tone_ratio_strat_box[5]+5, 		"Tone ratio in low visibility:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_strat_box[5]+5, 		round(tone_ratio_strat_ref,1))
		draw_string_Helvetica_12(tone_ratio_hialt_box[2]+5, 		tone_ratio_hialt_box[5]+5, 		"Tone ratio at high altitude:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_hialt_box[5]+5, 		round(tone_ratio_hialt_ref,1))
	else
		graphics.set_color(0.5, 0.5, 0.5, 1)
		draw_string_Helvetica_12(min_tone_angle_box[2]+5, 		min_tone_angle_box[5]+5, 		"Min tone angle:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		min_tone_angle_box[5]+5, 		min_tone_angle_ref)
		draw_string_Helvetica_12(max_tone_angle_box[2]+5, 		max_tone_angle_box[5]+5, 		"Max tone angle:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		max_tone_angle_box[5]+5, 		max_tone_angle_ref)
		draw_string_Helvetica_12(tone_ratio_clean_box[2]+5, 		tone_ratio_clean_box[5]+5, 		"Tone ratio in good weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_clean_box[5]+5, 		round(tone_ratio_clean_ref,1))
		draw_string_Helvetica_12(tone_ratio_foggy_box[2]+5, 		tone_ratio_foggy_box[5]+5, 		"Tone ratio in foggy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_foggy_box[5]+5, 		round(tone_ratio_foggy_ref,1))
		draw_string_Helvetica_12(tone_ratio_hazy_box[2]+5, 		tone_ratio_hazy_box[5]+5, 		"Tone ratio in hazy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_hazy_box[5]+5, 		round(tone_ratio_hazy_ref,1))
		draw_string_Helvetica_12(tone_ratio_snowy_box[2]+5, 		tone_ratio_snowy_box[5]+5, 		"Tone ratio in snowy weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_snowy_box[5]+5, 		round(tone_ratio_snowy_ref,1))
		draw_string_Helvetica_12(tone_ratio_ocast_box[2]+5, 		tone_ratio_ocast_box[5]+5, 		"Tone ratio in overcast weather:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_ocast_box[5]+5, 		round(tone_ratio_ocast_ref,1))
		draw_string_Helvetica_12(tone_ratio_strat_box[2]+5, 		tone_ratio_strat_box[5]+5, 		"Tone ratio in low visibility:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_strat_box[5]+5, 		round(tone_ratio_strat_ref,1))
		draw_string_Helvetica_12(tone_ratio_hialt_box[2]+5, 		tone_ratio_hialt_box[5]+5, 		"Tone ratio at high altitude:")
		draw_string_Helvetica_12(cloud_and_atmo_box[3]-55, 		tone_ratio_hialt_box[5]+5, 		round(tone_ratio_hialt_ref,1))
		graphics.set_color(1, 1, 1, 1)
	end
	
end
function draw_visibility_and_lights()
	if d_tab==false or tab_visibility_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(visibility_and_lights_box[2], visibility_and_lights_box[5], visibility_and_lights_box[3]-visibility_and_lights_box[2], visibility_and_lights_box[5]-visibility_and_lights_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(visibility_and_lights_box[2], visibility_and_lights_box[5], visibility_and_lights_box[3]-visibility_and_lights_box[2], visibility_and_lights_box[5]-visibility_and_lights_box[4], 10, 1)
	graphics.draw_line(visibility_and_lights_box[2], visibility_and_lights_box[5]-20, visibility_and_lights_box[3], visibility_and_lights_box[5]-20)
	draw_string_Helvetica_18(visibility_and_lights_box[2]+30, 		visibility_and_lights_box[5]-17, 		"Visibility and lights")
	draw_string_Helvetica_12(visibility_reported_m_box[2]+5, 		visibility_reported_m_box[5]+5, 		"Overall visibility:")
	draw_string_Helvetica_12(visibility_reported_m_box[2]+190, 		visibility_reported_m_box[5]+5, 		round(visibility_reported_m_ref,0))
	draw_string_Helvetica_12(LOD_bias_rat_box[2]+5, 		LOD_bias_rat_box[5]+5, 		"LOD ratio:")
	draw_string_Helvetica_12(LOD_bias_rat_box[2]+190, 		LOD_bias_rat_box[5]+5, 		round(LOD_bias_rat_ref,2))
	draw_string_Helvetica_12(cars_lod_min_box[2]+5, 		cars_lod_min_box[5]+5, 		"Cars visibility:")
	draw_string_Helvetica_12(cars_lod_min_box[2]+190, 		cars_lod_min_box[5]+5, 		cars_lod_min_ref)
	draw_string_Helvetica_12(tile_lod_bias_box[2]+5, 		tile_lod_bias_box[5]+5, 		"Object visibility ratio:")
	draw_string_Helvetica_12(tile_lod_bias_box[2]+190, 		tile_lod_bias_box[5]+5, 		round(tile_lod_bias_ref,2))
	draw_string_Helvetica_12(fade_start_rat_box[2]+5, 		fade_start_rat_box[5]+5, 		"Terrain objects (trees) visibility:")
	draw_string_Helvetica_12(fade_start_rat_box[2]+190, 		fade_start_rat_box[5]+5, 		round(fade_start_rat_ref,2))
	draw_string_Helvetica_12(composite_far_dist_bias_box[2]+5, 		composite_far_dist_bias_box[5]+5, 		"Terrain details visibility:")
	draw_string_Helvetica_12(composite_far_dist_bias_box[2]+190, 		composite_far_dist_bias_box[5]+5, 		round(composite_far_dist_bias_ref,2))
	draw_string_Helvetica_12(fog_be_gone_box[2]+5, 		fog_be_gone_box[5]+5, 		"Fog visibility:")
	draw_string_Helvetica_12(fog_be_gone_box[2]+190, 		fog_be_gone_box[5]+5, 		round(fog_be_gone_ref,3))
	graphics.draw_line(fog_be_gone_box[2], fog_be_gone_box[5]-5, fog_be_gone_box[3], fog_be_gone_box[5]-5)
	graphics.draw_line(fog_be_gone_box[2]+126, fog_be_gone_box[5]-128, fog_be_gone_box[2]+126, fog_be_gone_box[5]-5)
	if xEnviro==0 then
		draw_string_Helvetica_12(fog_be_gone_box[2]+25, 		fog_be_gone_box[5]-19, 		"Lights scale")
		draw_string_Helvetica_12(scale_near_box[2]+5, 		scale_near_box[5]+5, 		"Scale near:")
		draw_string_Helvetica_12(scale_near_box[2]+80, 		scale_near_box[5]+5, 		round(scale_near_ref,2)*100 .. " %")
		draw_string_Helvetica_12(scale_far_box[2]+5, 		scale_far_box[5]+5, 		"Scale far:")
		draw_string_Helvetica_12(scale_far_box[2]+80, 		scale_far_box[5]+5, 		round(scale_far_ref,2)*100 .. " %")
	else
		graphics.set_color(0.5, 0.5, 0.5, 1)
		draw_string_Helvetica_12(fog_be_gone_box[2]+25, 		fog_be_gone_box[5]-19, 		"Lights scale")
		draw_string_Helvetica_12(scale_near_box[2]+5, 		scale_near_box[5]+5, 		"Scale near:")
		draw_string_Helvetica_12(scale_near_box[2]+80, 		scale_near_box[5]+5, 		round(scale_near_ref,2)*100 .. " %")
		draw_string_Helvetica_12(scale_far_box[2]+5, 		scale_far_box[5]+5, 		"Scale far:")
		draw_string_Helvetica_12(scale_far_box[2]+80, 		scale_far_box[5]+5, 		round(scale_far_ref,2)*100 .. " %")
		graphics.set_color(1, 1, 1, 1)
	end
	draw_string_Helvetica_12(fog_be_gone_box[2]+145, 		fog_be_gone_box[5]-19, 		"Lights distance")
	draw_string_Helvetica_12(dist_near_box[2]+5, 		dist_near_box[5]+5, 		"Distance near:")
	draw_string_Helvetica_12(dist_near_box[2]+90, 		dist_near_box[5]+5, 		round(dist_near_ref,0))
	draw_string_Helvetica_12(dist_far_box[2]+5, 		dist_far_box[5]+5, 		"Distance far:")
	draw_string_Helvetica_12(dist_far_box[2]+90, 		dist_far_box[5]+5, 		round(dist_far_ref,0))
	graphics.draw_line(fog_be_gone_box[2], fog_be_gone_box[5]-65, fog_be_gone_box[3], fog_be_gone_box[5]-65)
	draw_string_Helvetica_12(fog_be_gone_box[2]+15, 		fog_be_gone_box[5]-79, 		"Lights exponent")
	draw_string_Helvetica_12(fog_be_gone_box[2]+152, 		fog_be_gone_box[5]-79, 		"Lights bloom")
	draw_string_Helvetica_12(exponent_near_box[2]+5, 		exponent_near_box[5]+5, 		"Exponent near:")
	draw_string_Helvetica_12(exponent_near_box[2]+90, 		exponent_near_box[5]+5, 		round(exponent_near_ref,2))
	draw_string_Helvetica_12(exponent_far_box[2]+5, 		exponent_far_box[5]+5, 		"Exponent far:")
	draw_string_Helvetica_12(exponent_far_box[2]+90, 		exponent_far_box[5]+5, 		round(exponent_far_ref,2))
	draw_string_Helvetica_12(bloom_near_box[2]+5, 		bloom_near_box[5]+5, 		"Bloom near:")
	draw_string_Helvetica_12(bloom_near_box[2]+90, 		bloom_near_box[5]+5, 		round(bloom_near_ref,0))
	draw_string_Helvetica_12(bloom_far_box[2]+5, 		bloom_far_box[5]+5, 		"Bloom far:")
	draw_string_Helvetica_12(bloom_far_box[2]+90, 		bloom_far_box[5]+5, 		round(bloom_far_ref,0))
	
	
	
--
end
function draw_plugin_settings()
	if d_tab==false or tab_plugin_settins_item==false then
		return
	end
	XPLMSetGraphicsState(0,0,0,1,1,0,0)
	graphics.set_color(unpack(maintabbuttonscolor))
	RENDEROPTIONS.draw_filled_button(plugin_settings_item_box[2], plugin_settings_item_box[5], plugin_settings_item_box[3]-plugin_settings_item_box[2], plugin_settings_item_box[5]-plugin_settings_item_box[4], 10, 1)
	graphics.set_color(1, 1, 1, 1)
	RENDEROPTIONS.draw_button(plugin_settings_item_box[2], plugin_settings_item_box[5], plugin_settings_item_box[3]-plugin_settings_item_box[2], plugin_settings_item_box[5]-plugin_settings_item_box[4], 10, 1)
	graphics.draw_line(plugin_settings_item_box[2], plugin_settings_item_box[5]-20, plugin_settings_item_box[3], plugin_settings_item_box[5]-20)
	draw_string_Helvetica_18(plugin_settings_item_box[2]+10, 		plugin_settings_item_box[5]-17, 		"Plugin settings")
	graphics.set_color(unpack(xenviro_enabled_box_color))
	RENDEROPTIONS.draw_filled_button(xenviro_enabled_box[2]+4, xenviro_enabled_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(unpack(show_help_bubble_box_color))
	RENDEROPTIONS.draw_filled_button(show_help_bubble_box[2]+4, show_help_bubble_box[4]-4, 22, 12, 6, 1)
	graphics.set_color(1, 1, 1, 1)
	graphics.draw_filled_circle(xenviro_enabled_box[2]+x_sliders[20],xenviro_enabled_box[4]-10, 5)
	graphics.draw_filled_circle(show_help_bubble_box[2]+x_sliders[21],show_help_bubble_box[4]-10, 5)
	draw_string_Helvetica_12(xenviro_enabled_box[2]+30, 		xenviro_enabled_box[5]+5, 		"xEnviro enabled")
	draw_string_Helvetica_12(show_help_bubble_box[2]+30, 		show_help_bubble_box[5]+5, 		"Show helpers - WIP")
	draw_string_Helvetica_12(show_help_bubble_box[2]+5, 		show_help_bubble_box[5]-15, 		"Load saved preset at startup")
	draw_button(unpack(load_at_start1))
	draw_button(unpack(load_at_start2))
	draw_button(unpack(load_at_start3))
	draw_button(unpack(load_at_start4))
	draw_string_Helvetica_18(load_at_start1[2]+8, 		load_at_start1[3]-19, 		"1")
	draw_string_Helvetica_18(load_at_start2[2]+8, 		load_at_start2[3]-19, 		"2")
	draw_string_Helvetica_18(load_at_start3[2]+8, 		load_at_start3[3]-19, 		"3")
	draw_string_Helvetica_18(load_at_start4[2]+8, 		load_at_start4[3]-19, 		"4")
end
function check_for_default()   ----default settings logic
--	bbb[1]=rwy_follow_terrain_ref
	bbb[2]=draw_deer_birds_ref
	bbb[3]=draw_fire_ball_ref
	bbb[4]=draw_boats_ref
	bbb[5]=draw_aurora_ref
	bbb[6]=draw_scattering_ref
	bbb[7]=draw_volume_fog01_ref
	bbb[8]=draw_per_pix_liting_ref
	bbb[9]=static_plane_build_vis
	bbb[10]=static_plane_density
	bbb[11]=use_reflective_water
	bbb[12]=draw_fft_water
	bbb[13]=use_3dwater_ref
	bbb[14]=draw_reflect_water05
	bbb[15]=fft_amp1_ref
	bbb[16]=fft_amp2_ref
	bbb[17]=fft_amp3_ref
	bbb[18]=fft_amp4_ref
	bbb[19]=fft_scale1_ref
	bbb[20]=fft_scale2_ref
	bbb[21]=fft_scale3_ref
	bbb[22]=fft_scale4_ref
	bbb[23]=round(noise_speed_ref,2)
	bbb[24]=round(noise_bias_gen_x_ref,2)
	bbb[25]=round(noise_bias_gen_y_ref,2)
	bbb[26]=csm_split_exterior
	bbb[27]=csm_split_interior
	bbb[28]=shadow_cam_size
	bbb[29]=shadow_size
	bbb[30]=cockpit_near_adjust
	bbb[31]=cockpit_near_proxy
	bbb[32]=far_limit
	bbb[33]=scenery_shadows
	bbb[34]=disable_shadow_prep
	bbb[35]=draw_objs_06_ref
	bbb[36]=draw_cars_05_ref
	bbb[37]=draw_vecs_03_ref
	bbb[38]=draw_for_05_ref
	bbb[39]=round(inn_ring_density_ref,2)
	bbb[40]=round(mid_ring_density_ref,2)
	bbb[41]=round(out_ring_density_ref,2)
	bbb[42]=draw_detail_apt_03_ref
	bbb[43]=extended_dsfs_ref
	bbb[44]=draw_HDR_ref
	bbb[45]=comp_texes_ref
	bbb[46]=use_bump_maps_ref
	bbb[47]=use_detail_textures_ref
	bbb[48]=ssao_enable_ref
	bbb[49]=first_res_3d_ref
	bbb[50]=last_res_3d_ref
	bbb[51]=round(cloud_shadow_lighten_ratio_ref,2)
	bbb[52]=round(plot_radius_ref,2)
	bbb[53]=round(overdraw_control_ref,2)
	bbb[54]=round(ambient_gain_ref,2)
	bbb[55]=round(diffuse_gain_ref,2)
	bbb[56]=round(white_point_ref,2)
	bbb[57]=round(atmo_scale_raleigh_ref,2)
	bbb[58]=inscatter_gain_raleigh_ref
	bbb[59]=min_shadow_angle_ref
	bbb[60]=max_shadow_angle_ref
	bbb[61]=max_dsf_vis_ever_ref
	bbb[62]=round(dsf_fade_ratio_ref,2)
	bbb[63]=round(dsf_cutover_scale_ref,2)
	bbb[64]=min_tone_angle_ref
	bbb[65]=max_tone_angle_ref
	bbb[66]=round(tone_ratio_clean_ref,1)
	bbb[67]=round(tone_ratio_foggy_ref,1)
	bbb[68]=round(tone_ratio_hazy_ref,1)
	bbb[69]=round(tone_ratio_snowy_ref,1)
	bbb[70]=round(tone_ratio_ocast_ref,1)
	bbb[71]=round(tone_ratio_strat_ref,1)
	bbb[72]=round(tone_ratio_hialt_ref,1)
	bbb[73]=visibility_reported_m_ref
	bbb[74]=LOD_bias_rat_ref
	bbb[75]=cars_lod_min_ref
	bbb[76]=round(tile_lod_bias_ref,2)
	bbb[77]=round(fade_start_rat_ref,2)
	bbb[78]=round(composite_far_dist_bias_ref,2)
	bbb[79]=round(fog_be_gone_ref,2)
	bbb[80]=round(scale_near_ref,2)
	bbb[81]=round(scale_far_ref,2)
	bbb[82]=dist_near_ref
	bbb[83]=dist_far_ref
	bbb[84]=round(exponent_near_ref,2)
	bbb[85]=round(exponent_far_ref,2)
	bbb[86]=bloom_near_ref
	bbb[87]=bloom_far_ref
	if tab_misc == true then
		
		for iiii = 2, 10, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_misc=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_misc=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_reflection_detail_item == true then
		for iiii = 11, 25, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_water=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_water=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_shadows_on_scenery_item == true then		
		for iiii = 26, 34, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_shadow=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_shadow=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_num_of_world_obj_item == true then		
		for iiii = 35, 43, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_num_obj=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_num_obj=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_texture_quality_item == true then		
		for iiii = 44, 48, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_texture=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_texture=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_clouds_and_sky_item == true then		
		for iiii = 49, 72, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_clouds=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_clouds=false
				but_default_color1=but_default_color11
				break
			end
		end
	elseif tab_visibility_item == true then
		for iiii = 74, 87, 1 do
			if bbb[iiii]==default_sett_misc_values[iiii] then
				default_sett_visibility=true
				but_default_color1={0.38, 0.38, 0.38, 1}
				
			else
				default_sett_visibility=false
				but_default_color1=but_default_color11
				break
			end
		end
	else
		but_default_color1={0.38, 0.38, 0.38, 1}
	end	
end
function check_need_reload(locvar, drf)
if locvar==drf then return true
else return false
end
end
function need_reload_func()
	--aaa[1]=check_need_reload(values_var[1], rwy_follow_terrain_ref)
	aaa[2]=check_need_reload(values_var[2], draw_deer_birds_ref)
	aaa[3]=check_need_reload(values_var[3], draw_fire_ball_ref)
	aaa[4]=check_need_reload(values_var[4], draw_boats_ref)
	aaa[5]=check_need_reload(values_var[5], draw_aurora_ref)
	aaa[6]=check_need_reload(values_var[6], draw_scattering_ref)
	aaa[7]=check_need_reload(values_var[7], draw_volume_fog01_ref)
	aaa[8]=check_need_reload(values_var[8], draw_per_pix_liting_ref)
	aaa[9]=check_need_reload(values_var[9], draw_objs_06_ref)
	aaa[10]=check_need_reload(values_var[10], draw_vecs_03_ref)
	aaa[11]=check_need_reload(values_var[11], draw_for_05_ref)
	aaa[12]=check_need_reload(values_var[12], inn_ring_density_ref)
	aaa[13]=check_need_reload(values_var[13], mid_ring_density_ref)
	aaa[14]=check_need_reload(values_var[14], out_ring_density_ref)
	aaa[15]=check_need_reload(values_var[15], draw_detail_apt_03_ref)
	aaa[16]=check_need_reload(values_var[16], comp_texes_ref)
	aaa[17]=check_need_reload(values_var[17], extended_dsfs_ref)
	aaa[18]=check_need_reload(values_var[18], tile_lod_bias_ref)
	aaa[19]=check_need_reload(values_var[19], composite_far_dist_bias_ref)
	for iii = 2, 19, 1 do
		if aaa[iii]==false then
			need_reload = true
			break
		else
			need_reload = false
		end
	
	end
end
function reload_func()
	--values_var[1]=rwy_follow_terrain_ref
	values_var[2]=draw_deer_birds_ref
	values_var[3]=draw_fire_ball_ref
	values_var[4]=draw_boats_ref
	values_var[5]=draw_aurora_ref
	values_var[6]=draw_scattering_ref
	values_var[7]=draw_volume_fog01_ref
	values_var[8]=draw_per_pix_liting_ref
	values_var[9]=draw_objs_06_ref
	values_var[10]=draw_vecs_03_ref
	values_var[11]=draw_for_05_ref
	values_var[12]=inn_ring_density_ref
	values_var[13]=mid_ring_density_ref
	values_var[14]=out_ring_density_ref
	values_var[15]=draw_detail_apt_03_ref
	values_var[16]=comp_texes_ref
	values_var[17]=extended_dsfs_ref
	values_var[18]=tile_lod_bias_ref
	values_var[19]=composite_far_dist_bias_ref
	
	on_start_sim=false
    --XPLM.XPLMReloadScenery()
	command_once("sim/operation/reload_scenery")
end
function mouse_click_events()
	if MOUSE_STATUS ~= "down" then
		return
	end
	if m_inbox_inn_but(on_start_sim, start_up_on_load_sim_apply_box) == true and run_time<100 then
		if need_reload == false then
			
		else 
			reload_func()
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(on_start_sim, start_up_on_load_sim_cancel_box) == true and run_time<100 then
		on_start_sim = false
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox(d_tab, main_box) == true then
		if menu_items == false then
			on_start_sim = false
			menu_items = true
			if (ofy<-81) then
				ofy=-80
				ofyy1=ofy
			end
			
		else 
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
			menu_items = false
			tab_misc = false
			tab_reflection_detail_item = false
			tab_shadows_on_scenery_item = false
			tab_num_of_world_obj_item = false
			tab_texture_quality_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, misc_random_item) == true then
		if tab_misc == false then
			tab_misc = true
			tab_reflection_detail_item = false
			tab_shadows_on_scenery_item = false
			tab_num_of_world_obj_item = false
			tab_texture_quality_item = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_misc = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, reflection_detail_item) == true then
		if tab_reflection_detail_item == false then
			tab_reflection_detail_item = true
			tab_shadows_on_scenery_item = false
			tab_num_of_world_obj_item = false
			tab_texture_quality_item = false
			tab_misc = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_reflection_detail_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, shadows_on_scenery_item) == true then
		if tab_shadows_on_scenery_item == false then
			tab_shadows_on_scenery_item = true
			tab_reflection_detail_item = false
			tab_misc = false
			tab_num_of_world_obj_item = false
			tab_texture_quality_item = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_shadows_on_scenery_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, num_of_world_obj_item) == true then
		if tab_num_of_world_obj_item == false then
			tab_num_of_world_obj_item = true
			tab_shadows_on_scenery_item = false
			tab_reflection_detail_item = false
			tab_misc = false
			tab_texture_quality_item = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_num_of_world_obj_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, texture_quality_item) == true then
		if tab_texture_quality_item == false then
			tab_texture_quality_item = true
			tab_num_of_world_obj_item = false
			tab_shadows_on_scenery_item = false
			tab_reflection_detail_item = false
			tab_misc = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_texture_quality_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, clouds_and_sky_item) == true then
		if tab_clouds_and_sky_item == false then
			tab_texture_quality_item = false
			tab_num_of_world_obj_item = false
			tab_shadows_on_scenery_item = false
			tab_reflection_detail_item = false
			tab_misc = false
			tab_clouds_and_sky_item = true
			tab_plugin_settins_item = false
			tab_visibility_item = false
		else 
			tab_clouds_and_sky_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, plugin_settins_item) == true then
		if tab_plugin_settins_item == false then
			tab_texture_quality_item = false
			tab_num_of_world_obj_item = false
			tab_shadows_on_scenery_item = false
			tab_reflection_detail_item = false
			tab_misc = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = true
			tab_visibility_item = false
		else 
			tab_plugin_settins_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn(menu_items, visibility_item) == true then
		if tab_visibility_item == false then
			tab_texture_quality_item = false
			tab_num_of_world_obj_item = false
			tab_shadows_on_scenery_item = false
			tab_reflection_detail_item = false
			tab_misc = false
			tab_clouds_and_sky_item = false
			tab_plugin_settins_item = false
			tab_visibility_item = true
		else 
			tab_visibility_item = false
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, buttontest) == true then
		if need_reload == false then
			
		else 
			reload_func()
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, set_to_default_item) == true then
		if tab_misc == true then
			if default_sett_misc==false then
				--rwy_follow_terrain_ref=default_sett_misc_values[1]
				draw_deer_birds_ref=default_sett_misc_values[2]
				draw_fire_ball_ref=default_sett_misc_values[3]
				draw_boats_ref=default_sett_misc_values[4]
				draw_aurora_ref=default_sett_misc_values[5]
				draw_scattering_ref=default_sett_misc_values[6]
				draw_volume_fog01_ref=default_sett_misc_values[7]
				draw_per_pix_liting_ref=default_sett_misc_values[8]
				static_plane_build_vis=default_sett_misc_values[9]
				static_plane_density=default_sett_misc_values[10]
				--setDatai(findDataref("sim/private/controls/reno/sloped_runways"),rwy_follow_terrain_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_deer_birds"),draw_deer_birds_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_fire_ball"),draw_fire_ball_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_boats"),draw_boats_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_aurora"),draw_aurora_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_scattering"),draw_scattering_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_volume_fog01"),draw_volume_fog01_ref)
				setDatai(findDataref("sim/private/controls/reno/draw_per_pix_liting"),draw_per_pix_liting_ref)
				setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),static_plane_build_vis)
				setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			end
		elseif tab_reflection_detail_item == true then
			if default_sett_water==false then
				use_reflective_water=default_sett_misc_values[11]
				draw_fft_water=default_sett_misc_values[12]
				use_3dwater_ref=default_sett_misc_values[13]
				draw_reflect_water05=default_sett_misc_values[14]
				fft_amp1_ref=default_sett_misc_values[15]
				fft_amp2_ref=default_sett_misc_values[16]
				fft_amp3_ref=default_sett_misc_values[17]
				fft_amp4_ref=default_sett_misc_values[18]
				fft_scale1_ref=default_sett_misc_values[19]
				fft_scale2_ref=default_sett_misc_values[20]
				fft_scale3_ref=default_sett_misc_values[21]
				fft_scale4_ref=default_sett_misc_values[22]
				noise_speed_ref=default_sett_misc_values[23]
				noise_bias_gen_x_ref=default_sett_misc_values[24]
				noise_bias_gen_y_ref=default_sett_misc_values[25]
				setDataf(findDataref("sim/private/controls/caps/use_reflective_water"),use_reflective_water)
				setDatai(findDataref("sim/private/controls/reno/draw_fft_water"),draw_fft_water)
				setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
				setDataf(findDataref("sim/private/controls/caps/use_3dwater"),use_3dwater_ref)
				setDataf(findDataref("sim/private/controls/water/fft_amp1"),fft_amp1_ref)
				setDataf(findDataref("sim/private/controls/water/fft_amp2"),fft_amp2_ref)
				setDataf(findDataref("sim/private/controls/water/fft_amp3"),fft_amp3_ref)
				setDataf(findDataref("sim/private/controls/water/fft_amp4"),fft_amp4_ref)
				setDataf(findDataref("sim/private/controls/water/fft_scale1"),fft_scale1_ref)
				setDataf(findDataref("sim/private/controls/water/fft_scale2"),fft_scale2_ref)
				setDataf(findDataref("sim/private/controls/water/fft_scale3"),fft_scale3_ref)
				setDataf(findDataref("sim/private/controls/water/fft_scale4"),fft_scale4_ref)
				setDataf(findDataref("sim/private/controls/water/noise_speed"),noise_speed_ref)
				setDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"),noise_bias_gen_x_ref)
				setDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"),noise_bias_gen_y_ref)
			end
		elseif tab_shadows_on_scenery_item == true then		
			if default_sett_shadow==false then
				csm_split_exterior=default_sett_misc_values[26]
				csm_split_interior=default_sett_misc_values[27]
				shadow_cam_size=default_sett_misc_values[28]
				shadow_size=default_sett_misc_values[29]
				cockpit_near_adjust=default_sett_misc_values[30]
				cockpit_near_proxy=default_sett_misc_values[31]
				far_limit=default_sett_misc_values[32]
				scenery_shadows=default_sett_misc_values[33]
				disable_shadow_prep=default_sett_misc_values[34]
				setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
				setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
				setDataf(findDataref("sim/private/controls/shadow/csm/far_limit"),far_limit)
				setDataf(findDataref("sim/private/controls/shadow/scenery_shadows"),scenery_shadows)
				setDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"),shadow_cam_size)
				setDataf(findDataref("sim/private/controls/clouds/shadow_size"),shadow_size)
				setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
				setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
				setDataf(findDataref("sim/private/controls/perf/disable_shadow_prep"),disable_shadow_prep)
			end
		elseif tab_num_of_world_obj_item == true then		
			if default_sett_num_obj==false then
				draw_objs_06_ref=default_sett_misc_values[35]
				draw_cars_05_ref=default_sett_misc_values[36]
				draw_vecs_03_ref=default_sett_misc_values[37]
				draw_for_05_ref=default_sett_misc_values[38]
				inn_ring_density_ref=default_sett_misc_values[39]
				mid_ring_density_ref=default_sett_misc_values[40]
				out_ring_density_ref=default_sett_misc_values[41]
				draw_detail_apt_03_ref=default_sett_misc_values[42]
				extended_dsfs_ref=default_sett_misc_values[43]
				setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)--
				setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)--
				setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)--
				setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)--
				setDataf(findDataref("sim/private/controls/forest/inn_ring_density"),inn_ring_density_ref)--
				setDataf(findDataref("sim/private/controls/forest/mid_ring_density"),mid_ring_density_ref)--
				setDataf(findDataref("sim/private/controls/forest/out_ring_density"),out_ring_density_ref)--
				setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
				setDataf(findDataref("sim/private/controls/geoid/extended_dsfs"),extended_dsfs_ref)
			end
		elseif tab_texture_quality_item == true then		
			if default_sett_texture==false then
				draw_HDR_ref=default_sett_misc_values[44]
				comp_texes_ref=default_sett_misc_values[45]
				use_bump_maps_ref=default_sett_misc_values[46]
				use_detail_textures_ref=default_sett_misc_values[47]
				ssao_enable_ref=default_sett_misc_values[48]
				setDatai(findDataref("sim/private/controls/reno/draw_HDR"),draw_HDR_ref)
				setDatai(findDataref("sim/private/controls/reno/comp_texes"),comp_texes_ref)
				setDatai(findDataref("sim/private/controls/reno/use_bump_maps"),use_bump_maps_ref)
				setDatai(findDataref("sim/private/controls/reno/use_detail_textures"),use_detail_textures_ref)
				setDataf(findDataref("sim/private/controls/ssao/enable"),ssao_enable_ref) 
			end
		elseif tab_clouds_and_sky_item == true then		
			if default_sett_clouds==false then
				first_res_3d_ref=default_sett_misc_values[49]
				last_res_3d_ref=default_sett_misc_values[50]
				cloud_shadow_lighten_ratio_ref=default_sett_misc_values[51]
				plot_radius_ref=default_sett_misc_values[52]
				overdraw_control_ref=default_sett_misc_values[53]
				ambient_gain_ref=default_sett_misc_values[54]
				diffuse_gain_ref=default_sett_misc_values[55]
				white_point_ref=default_sett_misc_values[56]
				atmo_scale_raleigh_ref=default_sett_misc_values[57]
				inscatter_gain_raleigh_ref=default_sett_misc_values[58]
				min_shadow_angle_ref=default_sett_misc_values[59]
				max_shadow_angle_ref=default_sett_misc_values[60]
				max_dsf_vis_ever_ref=default_sett_misc_values[61]
				dsf_fade_ratio_ref=default_sett_misc_values[62]
				dsf_cutover_scale_ref=default_sett_misc_values[63]
				min_tone_angle_ref=default_sett_misc_values[64]
				max_tone_angle_ref=default_sett_misc_values[65]
				tone_ratio_clean_ref=default_sett_misc_values[66]
				tone_ratio_foggy_ref=default_sett_misc_values[67]
				tone_ratio_hazy_ref=default_sett_misc_values[68]
				tone_ratio_snowy_ref=default_sett_misc_values[69]
				tone_ratio_ocast_ref=default_sett_misc_values[70]
				tone_ratio_strat_ref=default_sett_misc_values[71]
				tone_ratio_hialt_ref=default_sett_misc_values[72]
				setDataf(findDataref("sim/private/controls/clouds/first_res_3d"),first_res_3d_ref)
				setDataf(findDataref("sim/private/controls/clouds/last_res_3d"),last_res_3d_ref)
				setDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"),cloud_shadow_lighten_ratio_ref)
				setDataf(findDataref("sim/private/controls/clouds/plot_radius"),plot_radius_ref)
				setDataf(findDataref("sim/private/controls/clouds/overdraw_control"),overdraw_control_ref)
				setDataf(findDataref("sim/private/controls/clouds/ambient_gain"),ambient_gain_ref)
				setDataf(findDataref("sim/private/controls/clouds/diffuse_gain"),diffuse_gain_ref)
				setDataf(findDataref("sim/private/controls/hdr/white_point"),white_point_ref)
				setDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"),atmo_scale_raleigh_ref)
				setDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"),inscatter_gain_raleigh_ref)
				setDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"),max_shadow_angle_ref)
				setDataf(findDataref("sim/private/controls/skyc/min_shadow_angle"),min_shadow_angle_ref)
				setDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"),max_dsf_vis_ever_ref)
				setDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"),dsf_fade_ratio_ref)
				setDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale"),dsf_cutover_scale_ref)
				setDataf(findDataref("sim/private/controls/skyc/min_tone_angle"),min_tone_angle_ref)
				setDataf(findDataref("sim/private/controls/skyc/max_tone_angle"),max_tone_angle_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"),tone_ratio_clean_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"),tone_ratio_foggy_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"),tone_ratio_hazy_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"),tone_ratio_snowy_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"),tone_ratio_ocast_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"),tone_ratio_strat_ref)
				setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"),tone_ratio_hialt_ref)
			end
		elseif tab_visibility_item == true then
			if default_sett_visibility==false then
				LOD_bias_rat_ref=default_sett_misc_values[74]
				cars_lod_min_ref=default_sett_misc_values[75]
				tile_lod_bias_ref=default_sett_misc_values[76]
				fade_start_rat_ref=default_sett_misc_values[77]
				composite_far_dist_bias_ref=default_sett_misc_values[78]
				fog_be_gone_ref=default_sett_misc_values[79]
				scale_near_ref=default_sett_misc_values[80]
				scale_far_ref=default_sett_misc_values[81]
				dist_near_ref=default_sett_misc_values[82]
				dist_far_ref=default_sett_misc_values[83]
				exponent_near_ref=default_sett_misc_values[84]
				exponent_far_ref=default_sett_misc_values[85]
				bloom_near_ref=default_sett_misc_values[86]
				bloom_far_ref=default_sett_misc_values[87]
				setDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"),LOD_bias_rat_ref)
				setDataf(findDataref("sim/private/controls/ag/tile_lod_bias"),tile_lod_bias_ref)
				setDataf(findDataref("sim/private/controls/terrain/fade_start_rat"),fade_start_rat_ref)
				setDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"),composite_far_dist_bias_ref)
				setDataf(findDataref("sim/private/controls/cars/lod_min"),cars_lod_min_ref)
				setDataf(findDataref("sim/private/controls/fog/fog_be_gone"),fog_be_gone_ref)
				setDataf(findDataref("sim/private/controls/lights/exponent_far"),exponent_far_ref)
				setDataf(findDataref("sim/private/controls/lights/exponent_near"),exponent_near_ref)
				setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
				setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
				setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
				setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
				setDataf(findDataref("sim/private/controls/lights/scale_far"),scale_far_ref)
				setDataf(findDataref("sim/private/controls/lights/scale_near"),scale_near_ref)

			end
		else
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, save_tab_1) == true then
		save_set(1)
		preset_saved=1
		time_to_save_color=run_time+1
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, save_tab_2) == true then
		save_set(2)
		preset_saved=2
		time_to_save_color=run_time+1
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, save_tab_3) == true then
		save_set(3)
		preset_saved=3
		time_to_save_color=run_time+1
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, save_tab_4) == true then
		save_set(4)
		preset_saved=4
		time_to_save_color=run_time+1
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, load_tab_1) == true then
		load_set(1)
		preset_loaded=1
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, load_tab_2) == true then
		load_set(2)
		preset_loaded=2
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, load_tab_3) == true then
		load_set(3)
		preset_loaded=3
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(menu_items, load_tab_4) == true then
		load_set(4)
		preset_loaded=4
		RESUME_MOUSE_CLICK = true
	end
	----MISC/RANDOM TAB
	
	if m_inbox_inn_tabs(d_tab, tab_misc, birds_deer) == true then
		if draw_deer_birds_ref == 0 then
			draw_deer_birds_ref = 1
			birds_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_deer_birds"),draw_deer_birds_ref)			
		else
			draw_deer_birds_ref = 0
			birds_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_deer_birds"),draw_deer_birds_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, fires_baloons) == true then
		if draw_fire_ball_ref == 0 then
			draw_fire_ball_ref = 1
			fires_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_fire_ball"),draw_fire_ball_ref)
		else
			draw_fire_ball_ref = 0
			fires_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_fire_ball"),draw_fire_ball_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, carriers_frigates) == true then
		if draw_boats_ref == 0 then
			draw_boats_ref = 1
			carriers_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_boats"),draw_boats_ref)
		else
			draw_boats_ref = 0
			carriers_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_boats"),draw_boats_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, aurora_Boreals) == true and xEnviro==0 then
		if draw_aurora_ref == 0 then
			draw_aurora_ref = 1
			aurora_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_aurora"),draw_aurora_ref)
		else
			draw_aurora_ref = 0
			aurora_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_aurora"),draw_aurora_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, atmo_scatter) == true then
		if draw_scattering_ref == 0 then
			draw_scattering_ref = 1
			atmo_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_scattering"),draw_scattering_ref)
		else
			draw_scattering_ref = 0
			atmo_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_scattering"),draw_scattering_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, vol_fog) == true then
		if draw_volume_fog01_ref == 0 then
			draw_volume_fog01_ref = 1
			fog_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_volume_fog01"),draw_volume_fog01_ref)
		else
			draw_volume_fog01_ref = 0
			fog_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_volume_fog01"),draw_volume_fog01_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, draw_p_pix_light) == true then
		if draw_per_pix_liting_ref == 0 then
			draw_per_pix_liting_ref = 1
			p_pix_color={0,1,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_per_pix_liting"),draw_per_pix_liting_ref)
		else
			draw_per_pix_liting_ref = 0
			p_pix_color={1,0,0,1}
			setDatai(findDataref("sim/private/controls/reno/draw_per_pix_liting"),draw_per_pix_liting_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density0_tab) == true then
		if static_plane_density~=0 then
			static_plane_density=0
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),0)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density1_tab) == true then
		if static_plane_density~=1 then
			static_plane_density=1
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density2_tab) == true then
		if static_plane_density~=2 then
			static_plane_density=2
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density3_tab) == true then
		if static_plane_density~=3 then
			static_plane_density=3
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density4_tab) == true then
		if static_plane_density~=4 then
			static_plane_density=4
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density5_tab) == true then
		if static_plane_density~=5 then
			static_plane_density=5
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density6_tab) == true then
		if static_plane_density~=6 then
			static_plane_density=6
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			preset_loaded=0
		end	
		RESUME_MOUSE_CLICK = true
	end
	----REFLECTION DETAIL TAB
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, use_reflective_water_box) == true then
		if use_reflective_water == 0 then
			use_reflective_water = 1
			setDataf(findDataref("sim/private/controls/caps/use_reflective_water"),use_reflective_water)
			--p_pix_color={0,1,0,1}
		else
			use_reflective_water = 0
			setDataf(findDataref("sim/private/controls/caps/use_reflective_water"),use_reflective_water)
			--p_pix_color={1,0,0,1}
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_fft_water_box) == true then
		if draw_fft_water == 0 then
			draw_fft_water = 1
			setDatai(findDataref("sim/private/controls/reno/draw_fft_water"),draw_fft_water)
			--p_pix_color={0,1,0,1}
		else
			draw_fft_water = 0
			setDatai(findDataref("sim/private/controls/reno/draw_fft_water"),draw_fft_water)
			--p_pix_color={1,0,0,1}
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, use_3dwater_box) == true then
		if use_3dwater_ref == 0 then
			use_3dwater_ref = 1
			setDataf(findDataref("sim/private/controls/caps/use_3dwater"),use_3dwater_ref)
			--p_pix_color={0,1,0,1}
		else
			use_3dwater_ref = 0
			setDataf(findDataref("sim/private/controls/caps/use_3dwater"),use_3dwater_ref)
			--p_pix_color={1,0,0,1}
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water050_box) == true then
		if draw_reflect_water05~=0 then
			draw_reflect_water05=0
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water051_box) == true then
		if draw_reflect_water05~=1 then
			draw_reflect_water05=1
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water052_box) == true then
		if draw_reflect_water05~=2 then
			draw_reflect_water05=2
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water053_box) == true then
		if draw_reflect_water05~=3 then
			draw_reflect_water05=3
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water054_box) == true then
		if draw_reflect_water05~=4 then
			draw_reflect_water05=4
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water055_box) == true then
		if draw_reflect_water05~=5 then
			draw_reflect_water05=5
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	---SHADOWS ON THE SCENERY
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior0_box) == true then
		if csm_split_exterior~=0 then
			csm_split_exterior=0
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior1_box) == true then
		if csm_split_exterior~=1 then
			csm_split_exterior=1
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior2_box) == true then
		if csm_split_exterior~=2 then
			csm_split_exterior=2
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior3_box) == true then
		if csm_split_exterior~=3 then
			csm_split_exterior=3
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior4_box) == true then
		if csm_split_exterior~=4 then
			csm_split_exterior=4
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior5_box) == true then
		if csm_split_exterior~=5 then
			csm_split_exterior=5
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior0_box) == true then
		if csm_split_interior~=0 then
			csm_split_interior=0
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior1_box) == true then
		if csm_split_interior~=1 then
			csm_split_interior=1
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior2_box) == true then
		if csm_split_interior~=2 then
			csm_split_interior=2
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior3_box) == true then
		if csm_split_interior~=3 then
			csm_split_interior=3
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior4_box) == true then
		if csm_split_interior~=4 then
			csm_split_interior=4
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior5_box) == true then
		if csm_split_interior~=5 then
			csm_split_interior=5
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust0_box) == true then
		if cockpit_near_adjust~=0 then
			cockpit_near_adjust=0
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust1_box) == true then
		if cockpit_near_adjust~=1 then
			cockpit_near_adjust=1
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust2_box) == true then
		if cockpit_near_adjust~=2 then
			cockpit_near_adjust=2
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust3_box) == true then
		if cockpit_near_adjust~=3 then
			cockpit_near_adjust=3
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust4_box) == true then
		if cockpit_near_adjust~=4 then
			cockpit_near_adjust=4
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust5_box) == true then
		if cockpit_near_adjust~=5 then
			cockpit_near_adjust=5
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy0_box) == true then
		if cockpit_near_proxy~=0 then
			cockpit_near_proxy=0
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0

		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy1_box) == true then
		if cockpit_near_proxy~=1 then
			cockpit_near_proxy=1
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy2_box) == true then
		if cockpit_near_proxy~=2 then
			cockpit_near_proxy=2
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy3_box) == true then
		if cockpit_near_proxy~=3 then
			cockpit_near_proxy=3
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy4_box) == true then
		if cockpit_near_proxy~=4 then
			cockpit_near_proxy=4
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy5_box) == true then
		if cockpit_near_proxy~=5 then
			cockpit_near_proxy=5
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, shadow_on_scenery_show_box) == true then
		if scenery_shadows == 0 then
			scenery_shadows = 1
			setDataf(findDataref("sim/private/controls/shadow/scenery_shadows"),scenery_shadows)
			--p_pix_color={0,1,0,1}
		else
			scenery_shadows = 0
			setDataf(findDataref("sim/private/controls/shadow/scenery_shadows"),scenery_shadows)
			--p_pix_color={1,0,0,1}
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, disable_shadow_prep_box) == true then
		if disable_shadow_prep == 0 then
			disable_shadow_prep = 1
			setDataf(findDataref("sim/private/controls/perf/disable_shadow_prep"),disable_shadow_prep)
			--p_pix_color={0,1,0,1}
		else
			disable_shadow_prep = 0
			setDataf(findDataref("sim/private/controls/perf/disable_shadow_prep"),disable_shadow_prep)
			--p_pix_color={1,0,0,1}
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end	
	---Number of objects
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens0_box) == true then
		if draw_objs_06_ref ~= 0 then
			draw_objs_06_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens1_box) == true then
		if draw_objs_06_ref ~= 1 then
			draw_objs_06_ref=1
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens2_box) == true then
		if draw_objs_06_ref ~= 2 then
			draw_objs_06_ref=2
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens3_box) == true then
		if draw_objs_06_ref ~= 3 then
			draw_objs_06_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens4_box) == true then
		if draw_objs_06_ref ~= 4 then
			draw_objs_06_ref=4
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens5_box) == true then
		if draw_objs_06_ref ~= 5 then
			draw_objs_06_ref=5
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens6_box) == true then
		if draw_objs_06_ref ~= 6 then
			draw_objs_06_ref=6
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_050_box) == true then
		if draw_objs_06_ref ~= 0 then
			draw_cars_05_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_051_box) == true then
		if draw_cars_05_ref ~= 1 then
			draw_cars_05_ref=1
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_052_box) == true then
		if draw_cars_05_ref ~= 2 then
			draw_cars_05_ref=2
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_053_box) == true then
		if draw_cars_05_ref ~= 3 then
			draw_cars_05_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_054_box) == true then
		if draw_cars_05_ref ~= 4 then
			draw_cars_05_ref=4
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_055_box) == true then
		if draw_cars_05_ref ~= 5 then
			draw_cars_05_ref=5
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_vecs_030_box) == true then
		if draw_vecs_03_ref ~= 0 then
			draw_vecs_03_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_vecs_031_box) == true then
		if draw_vecs_03_ref ~= 1 then
			draw_vecs_03_ref=1
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_vecs_032_box) == true then
		if draw_vecs_03_ref ~= 2 then
			draw_vecs_03_ref=2
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_vecs_033_box) == true then
		if draw_vecs_03_ref ~= 3 then
			draw_vecs_03_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_050_box) == true then
		if draw_for_05_ref ~= 0 then
			draw_for_05_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_051_box) == true then
		if draw_for_05_ref ~= 1 then
			draw_for_05_ref=1
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_052_box) == true then
		if draw_for_05_ref ~= 2 then
			draw_for_05_ref=2
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_053_box) == true then
		if draw_for_05_ref ~= 3 then
			draw_for_05_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_054_box) == true then
		if draw_for_05_ref ~= 4 then
			draw_for_05_ref=4
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_055_box) == true then
		if draw_for_05_ref ~= 5 then
			draw_for_05_ref=5
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_detail_apt_030_box) == true then
		if draw_detail_apt_03_ref ~= 0 then
			draw_detail_apt_03_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_detail_apt_031_box) == true then
		if draw_detail_apt_03_ref ~= 1 then
			draw_detail_apt_03_ref=1
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_detail_apt_032_box) == true then
		if draw_detail_apt_03_ref ~= 2 then
			draw_detail_apt_03_ref=2
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_detail_apt_033_box) == true then
		if draw_detail_apt_03_ref ~= 3 then
			draw_detail_apt_03_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
			preset_loaded=0
		end
		RESUME_MOUSE_CLICK = true
	end
	
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, extended_dsfs_box) == true then
		if extended_dsfs_ref == 0 then
			extended_dsfs_ref = 1
			setDataf(findDataref("sim/private/controls/geoid/extended_dsfs"),extended_dsfs_ref)
		else
			extended_dsfs_ref = 0
			setDataf(findDataref("sim/private/controls/geoid/extended_dsfs"),extended_dsfs_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	
	---TEXTURE QUALITY
	if m_inbox_inn_tabs(d_tab, tab_texture_quality_item, draw_HDR_box) == true then
		if draw_HDR_ref == 0 then
			draw_HDR_ref = 1
			setDatai(findDataref("sim/private/controls/reno/draw_HDR"),draw_HDR_ref)
		else
			draw_HDR_ref = 0
			setDatai(findDataref("sim/private/controls/reno/draw_HDR"),draw_HDR_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end	
	if m_inbox_inn_tabs(d_tab, tab_texture_quality_item, comp_texes_box) == true then
		if comp_texes_ref == 0 then
			comp_texes_ref = 1
			setDatai(findDataref("sim/private/controls/reno/comp_texes"),comp_texes_ref)
		else
			comp_texes_ref = 0
			setDatai(findDataref("sim/private/controls/reno/comp_texes"),comp_texes_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_texture_quality_item, use_bump_maps_box) == true then
		if use_bump_maps_ref == 0 then
			use_bump_maps_ref = 1
			setDatai(findDataref("sim/private/controls/reno/use_bump_maps"),use_bump_maps_ref)
		else
			use_bump_maps_ref = 0
			setDatai(findDataref("sim/private/controls/reno/use_bump_maps"),use_bump_maps_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_texture_quality_item, use_detail_textures_box) == true then
		if use_detail_textures_ref == 0 then
			use_detail_textures_ref = 1
			setDatai(findDataref("sim/private/controls/reno/use_detail_textures"),use_detail_textures_ref)
		else
			use_detail_textures_ref = 0
			setDatai(findDataref("sim/private/controls/reno/use_detail_textures"),use_detail_textures_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_tabs(d_tab, tab_texture_quality_item, ssao_enable_box) == true then
		if ssao_enable_ref == 0 then
			ssao_enable_ref = 1
			setDataf(findDataref("sim/private/controls/ssao/enable"),ssao_enable_ref)
		else
			ssao_enable_ref = 0
			setDataf(findDataref("sim/private/controls/ssao/enable"),ssao_enable_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_CLICK = true
	end
	---PLUGIN SETTINGS
	if m_inbox_inn_tabs(d_tab, tab_plugin_settins_item, xenviro_enabled_box) == true then
		if xEnviro == 0 then
			xEnviro = 1
		else
			xEnviro = 0
		end
		save_settings()
		RESUME_MOUSE_CLICK = true
	end
	--if m_inbox_inn_tabs(d_tab, tab_plugin_settins_item, show_help_bubble_box) == true then
	--	if show_help_bubble == 0 then
	--		show_help_bubble = 1
	--	else
	--		show_help_bubble = 0
	--	end
	--	save_settings()
	--	RESUME_MOUSE_CLICK = true
	--end
	if m_inbox_inn_but(tab_plugin_settins_item, load_at_start1) == true then
		start_preset = 1
		save_settings()
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(tab_plugin_settins_item, load_at_start2) == true then
		start_preset = 2
		save_settings()
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(tab_plugin_settins_item, load_at_start3) == true then
		start_preset = 3
		save_settings()
		RESUME_MOUSE_CLICK = true
	end
	if m_inbox_inn_but(tab_plugin_settins_item, load_at_start4) == true then
		start_preset = 4
		save_settings()
		RESUME_MOUSE_CLICK = true
	end

end
function wheel_mouse_events()
	if m_inbox(true, slider_box) == true then	
		ofy = ofy + MOUSE_WHEEL_CLICKS*5
		ofyy1 = ofyy1 + MOUSE_WHEEL_CLICKS*5
		
		
		if ((SCREEN_HIGHT-501)<ofy)then
			ofy=SCREEN_HIGHT-502
		end
		if menu_items == false then
			if (ofy<-451) then
				ofy=-450
			end
		else
			if (ofy<-81) then
				ofy=-80
			end
		end
		
		if ((SCREEN_HIGHT-602)<ofy) then
		    ofyy1=SCREEN_HIGHT-602
		elseif (ofy<-350) then
			ofyy1=-350
		else
		ofyy1=ofy
		end
		--set_interface_pos()
		RESUME_MOUSE_WHEEL = true
		return ofy
	end
	---MISC/RANDOM TAB
	
	if m_inbox_inn_tabs(d_tab, tab_misc, distance_static_planes_traffic) == true then
		
		static_plane_build_vis=static_plane_build_vis +	MOUSE_WHEEL_CLICKS*100
		setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),static_plane_build_vis)
		if static_plane_build_vis<=0 then
			static_plane_build_vis=0
			static_plane_density=0
			setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),static_plane_build_vis)
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
		elseif static_plane_build_vis>100000 then
			static_plane_build_vis=100000
			setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),static_plane_build_vis)
		end
		if static_plane_density==0 then
			static_plane_build_vis=0
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
		
	end
	if m_inbox_inn_tabs(d_tab, tab_misc, static_plane_density_tab) == true then
		
		static_plane_density=static_plane_density +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
		if static_plane_density<=0 then
			static_plane_density=0
			static_plane_build_vis=0
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
			setDataf(findDataref("sim/private/controls/park/static_plane_build_dis"),static_plane_build_vis)
		elseif static_plane_density>6 then
			static_plane_density=6
			setDataf(findDataref("sim/private/controls/park/static_plane_density"),static_plane_density)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
		
	end
	---WATER AND REFLECTION DETAIL TAB
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, amp1_box) == true then
		
		fft_amp1_ref=fft_amp1_ref +	0.1*MOUSE_WHEEL_CLICKS
		fft_amp1_ref=math.ceil(fft_amp1_ref*10)*0.1
		setDataf(findDataref("sim/private/controls/water/fft_amp1"),fft_amp1_ref)
		if fft_amp1_ref<=0 then
			fft_amp1_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_amp1"),fft_amp1_ref)
		elseif fft_amp1_ref>20 then
			fft_amp1_ref=20
			setDataf(findDataref("sim/private/controls/water/fft_amp1"),fft_amp1_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, amp2_box) == true then
		
		fft_amp2_ref=fft_amp2_ref +	0.1*MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_amp2"),fft_amp2_ref)
		if fft_amp2_ref<=0 then
			fft_amp2_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_amp2"),fft_amp2_ref)
		elseif fft_amp2_ref>20 then
			fft_amp2_ref=20
			setDataf(findDataref("sim/private/controls/water/fft_amp2"),fft_amp2_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, amp3_box) == true then
		
		fft_amp3_ref=fft_amp3_ref +	0.1*MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_amp3"),fft_amp3_ref)
		if fft_amp3_ref<=0 then
			fft_amp3_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_amp3"),fft_amp3_ref)
		elseif fft_amp3_ref>20 then
			fft_amp3_ref=20
			setDataf(findDataref("sim/private/controls/water/fft_amp3"),fft_amp3_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, amp4_box) == true then
		
		fft_amp4_ref=fft_amp4_ref +	0.1*MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_amp4"),fft_amp4_ref)
		if fft_amp4_ref<=0 then
			fft_amp4_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_amp4"),fft_amp4_ref)
		elseif fft_amp4_ref>20 then
			fft_amp4_ref=20
			setDataf(findDataref("sim/private/controls/water/fft_amp4"),fft_amp4_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_scale1_box) == true then
		
		fft_scale1_ref=fft_scale1_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_scale1"),fft_scale1_ref)
		if fft_scale1_ref<=0 then
			fft_scale1_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_scale1"),fft_scale1_ref)
		elseif fft_scale1_ref>100 then
			fft_scale1_ref=100
			setDataf(findDataref("sim/private/controls/water/fft_scale1"),fft_scale1_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_scale2_box) == true then
		
		fft_scale2_ref=fft_scale2_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_scale2"),fft_scale2_ref)
		if fft_scale2_ref<=0 then
			fft_scale2_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_scale2"),fft_scale2_ref)
		elseif fft_scale2_ref>100 then
			fft_scale2_ref=100
			setDataf(findDataref("sim/private/controls/water/fft_scale2"),fft_scale2_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_scale3_box) == true then
		
		fft_scale3_ref=fft_scale3_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_scale3"),fft_scale3_ref)
		if fft_scale3_ref<=0 then
			fft_scale3_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_scale3"),fft_scale3_ref)
		elseif fft_scale3_ref>1000 then
			fft_scale3_ref=1000
			setDataf(findDataref("sim/private/controls/water/fft_scale3"),fft_scale3_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_scale4_box) == true then
		
		fft_scale4_ref=fft_scale4_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/fft_scale4"),fft_scale4_ref)
		if fft_scale4_ref<=0 then
			fft_scale4_ref=0
			setDataf(findDataref("sim/private/controls/water/fft_scale4"),fft_scale4_ref)
		elseif fft_scale4_ref>1000 then
			fft_scale4_ref=1000
			setDataf(findDataref("sim/private/controls/water/fft_scale4"),fft_scale4_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_noise_speed_box) == true then
		
		noise_speed_ref=noise_speed_ref + 0.1*MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/noise_speed"),noise_speed_ref)
		if noise_speed_ref<=0 then
			noise_speed_ref=0
			setDataf(findDataref("sim/private/controls/water/noise_speed"),noise_speed_ref)
		elseif noise_speed_ref>100 then
			noise_speed_ref=100
			setDataf(findDataref("sim/private/controls/water/noise_speed"),noise_speed_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_noise_bias_x_box) == true then
		
		noise_bias_gen_x_ref=noise_bias_gen_x_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"),noise_bias_gen_x_ref)
		if noise_bias_gen_x_ref<=0 then
			noise_bias_gen_x_ref=0
			setDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"),noise_bias_gen_x_ref)
		elseif noise_bias_gen_x_ref>1000 then
			noise_bias_gen_x_ref=1000
			setDataf(findDataref("sim/private/controls/water/noise_bias_gen_x"),noise_bias_gen_x_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, water_noise_bias_y_box) == true then
		
		noise_bias_gen_y_ref=noise_bias_gen_y_ref +	MOUSE_WHEEL_CLICKS
		
		setDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"),noise_bias_gen_y_ref)
		if noise_bias_gen_y_ref<=0 then
			noise_bias_gen_y_ref=0
			setDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"),noise_bias_gen_y_ref)
		elseif noise_bias_gen_y_ref>1000 then
			noise_bias_gen_y_ref=1000
			setDataf(findDataref("sim/private/controls/water/noise_bias_gen_y"),noise_bias_gen_y_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_reflection_detail_item, draw_reflect_water05_box) == true then
		
		draw_reflect_water05=draw_reflect_water05 +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
		if draw_reflect_water05<=0 then
			draw_reflect_water05=0
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
		elseif draw_reflect_water05>5 then
			draw_reflect_water05=5
			setDatai(findDataref("sim/private/controls/reno/draw_reflect_water05"),draw_reflect_water05)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	---SHADOWS ON THE SCENERY
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_exterior_box) == true then
		
		csm_split_exterior=csm_split_exterior +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),csm_split_exterior)
		if csm_split_exterior<=0 then
			csm_split_exterior=0
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),0)
		elseif csm_split_exterior>5 then
			csm_split_exterior=5
			setDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"),5)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cascading_shadow_maps_interior_box) == true then
		
		csm_split_interior=csm_split_interior +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),csm_split_interior)
		if csm_split_interior<=0 then
			csm_split_interior=0
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),0)
		elseif csm_split_interior>5 then
			csm_split_interior=5
			setDataf(findDataref("sim/private/controls/shadow/csm_split_interior"),5)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, shadow_texture_size_cockpit_box) == true then
		
		shadow_cam_size=shadow_cam_size +	MOUSE_WHEEL_CLICKS*512
		setDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"),shadow_cam_size)
		if shadow_cam_size<=512 then
			shadow_cam_size=512
			setDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"),shadow_cam_size)
		elseif shadow_cam_size>8192 then
			shadow_cam_size=8192
			setDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"),shadow_cam_size)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, shadow_texture_size_clouds_box) == true then
		
		shadow_size=shadow_size +	MOUSE_WHEEL_CLICKS*512
		setDataf(findDataref("sim/private/controls/clouds/shadow_size"),shadow_size)
		if shadow_size<=512 then
			shadow_size=512
			setDataf(findDataref("sim/private/controls/clouds/shadow_size"),shadow_size)
		elseif shadow_size>8192 then
			shadow_size=8192
			setDataf(findDataref("sim/private/controls/clouds/shadow_size"),shadow_size)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_adjust_box) == true then
		
		cockpit_near_adjust=cockpit_near_adjust +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
		if cockpit_near_adjust<=0 then
			cockpit_near_adjust=0
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
		elseif cockpit_near_adjust>5 then
			cockpit_near_adjust=5
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"),cockpit_near_adjust)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, cockpit_near_proxy_box) == true then
		
		cockpit_near_proxy=cockpit_near_proxy +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
		if cockpit_near_proxy<=0 then
			cockpit_near_proxy=0
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
		elseif cockpit_near_proxy>5 then
			cockpit_near_proxy=5
			setDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"),cockpit_near_proxy)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_shadows_on_scenery_item, shadow_fade_distance_box) == true then
		
		far_limit=far_limit +	MOUSE_WHEEL_CLICKS*50
		setDataf(findDataref("sim/private/controls/shadow/csm/far_limit"),far_limit)
		if far_limit<=0 then
			far_limit=0
			setDataf(findDataref("sim/private/controls/shadow/csm/far_limit"),far_limit)
		elseif far_limit>100000 then
			far_limit=100000
			setDataf(findDataref("sim/private/controls/shadow/csm/far_limit"),far_limit)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	
	--NUMBER OF OBJECTS
	
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, triD_object_dens_box) == true then
		
		draw_objs_06_ref=draw_objs_06_ref +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
		if draw_objs_06_ref<=0 then
			draw_objs_06_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
		elseif draw_objs_06_ref>6 then
			draw_objs_06_ref=6
			setDatai(findDataref("sim/private/controls/reno/draw_objs_06"),draw_objs_06_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_cars_05_box) == true then
		
		draw_cars_05_ref=draw_cars_05_ref +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
		if draw_cars_05_ref<=0 then
			draw_cars_05_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
		elseif draw_cars_05_ref>5 then
			draw_cars_05_ref=5
			setDatai(findDataref("sim/private/controls/reno/draw_cars_05"),draw_cars_05_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_vecs_03_box) == true then
		
		draw_vecs_03_ref=draw_vecs_03_ref +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
		if draw_vecs_03_ref<=0 then
			draw_vecs_03_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
		elseif draw_vecs_03_ref>3 then
			draw_vecs_03_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_vecs_03"),draw_vecs_03_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_for_05_box) == true then
		
		draw_for_05_ref=draw_for_05_ref +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
		if draw_for_05_ref<=0 then
			draw_for_05_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
		elseif draw_for_05_ref>5 then
			draw_for_05_ref=5
			setDatai(findDataref("sim/private/controls/reno/draw_for_05"),draw_for_05_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, inn_ring_density_box) == true then
		
		inn_ring_density_ref=inn_ring_density_ref +	0.05*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/forest/inn_ring_density"),inn_ring_density_ref)
		if inn_ring_density_ref<=0 then
			inn_ring_density_ref=0
			setDataf(findDataref("sim/private/controls/forest/inn_ring_density"),inn_ring_density_ref)
		elseif inn_ring_density_ref>2 then
			inn_ring_density_ref=2
			setDataf(findDataref("sim/private/controls/forest/inn_ring_density"),inn_ring_density_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, mid_ring_density_box) == true then
		
		mid_ring_density_ref=mid_ring_density_ref +	0.05*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/forest/mid_ring_density"),mid_ring_density_ref)
		if mid_ring_density_ref<=0 then
			mid_ring_density_ref=0
			setDataf(findDataref("sim/private/controls/forest/mid_ring_density"),mid_ring_density_ref)
		elseif mid_ring_density_ref>2 then
			mid_ring_density_ref=2
			setDataf(findDataref("sim/private/controls/forest/mid_ring_density"),mid_ring_density_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, out_ring_density_box) == true then
		
		out_ring_density_ref=out_ring_density_ref +	0.05*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/forest/out_ring_density"),out_ring_density_ref)
		if out_ring_density_ref<=0 then
			out_ring_density_ref=0
			setDataf(findDataref("sim/private/controls/forest/out_ring_density"),out_ring_density_ref)
		elseif out_ring_density_ref>2 then
			out_ring_density_ref=2
			setDataf(findDataref("sim/private/controls/forest/out_ring_density"),out_ring_density_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_num_of_world_obj_item, draw_detail_apt_03_box) == true then
		
		draw_detail_apt_03_ref=draw_detail_apt_03_ref +	MOUSE_WHEEL_CLICKS
		setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
		if draw_detail_apt_03_ref<=0 then
			draw_detail_apt_03_ref=0
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
		elseif draw_detail_apt_03_ref>3 then
			draw_detail_apt_03_ref=3
			setDatai(findDataref("sim/private/controls/reno/draw_detail_apt_03"),draw_detail_apt_03_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	
	----CLOUDS AND ATMO
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, first_res_3d_box) == true then
		
		first_res_3d_ref=first_res_3d_ref +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/first_res_3d"),first_res_3d_ref)
		if first_res_3d_ref<=0 then
			first_res_3d_ref=0
			setDataf(findDataref("sim/private/controls/clouds/first_res_3d"),first_res_3d_ref)
		elseif first_res_3d_ref>30 then
			first_res_3d_ref=30
			setDataf(findDataref("sim/private/controls/clouds/first_res_3d"),first_res_3d_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, last_res_3d_box) == true then
		
		last_res_3d_ref=last_res_3d_ref +	MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/last_res_3d"),last_res_3d_ref)
		if last_res_3d_ref<=0 then
			last_res_3d_ref=0
			setDataf(findDataref("sim/private/controls/clouds/last_res_3d"),last_res_3d_ref)
		elseif last_res_3d_ref>30 then
			last_res_3d_ref=30
			setDataf(findDataref("sim/private/controls/clouds/last_res_3d"),last_res_3d_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, cloud_shadow_lighten_ratio_box) == true then
		
		cloud_shadow_lighten_ratio_ref=cloud_shadow_lighten_ratio_ref +	0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"),cloud_shadow_lighten_ratio_ref)
		if cloud_shadow_lighten_ratio_ref<=0 then
			cloud_shadow_lighten_ratio_ref=0
			setDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"),cloud_shadow_lighten_ratio_ref)
		elseif cloud_shadow_lighten_ratio_ref>1.99 then
			cloud_shadow_lighten_ratio_ref=1.99
			setDataf(findDataref("sim/private/controls/clouds/cloud_shadow_lighten_ratio"),cloud_shadow_lighten_ratio_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, plot_radius_box) == true then
		
		plot_radius_ref=plot_radius_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/plot_radius"),plot_radius_ref)
		if plot_radius_ref<=0 then
			plot_radius_ref=0
			setDataf(findDataref("sim/private/controls/clouds/plot_radius"),plot_radius_ref)
		elseif plot_radius_ref>5 then
			plot_radius_ref=5
			setDataf(findDataref("sim/private/controls/clouds/plot_radius"),plot_radius_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, overdraw_control_box) == true then
		
		overdraw_control_ref=overdraw_control_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/overdraw_control"),overdraw_control_ref)
		if overdraw_control_ref<=0 then
			overdraw_control_ref=0
			setDataf(findDataref("sim/private/controls/clouds/overdraw_control"),overdraw_control_ref)
		elseif overdraw_control_ref>5 then
			overdraw_control_ref=5
			setDataf(findDataref("sim/private/controls/clouds/overdraw_control"),overdraw_control_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, ambient_gain_box) == true then
		
		ambient_gain_ref=ambient_gain_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/ambient_gain"),ambient_gain_ref)
		if ambient_gain_ref<=-10 then
			ambient_gain_ref=-10
			setDataf(findDataref("sim/private/controls/clouds/ambient_gain"),ambient_gain_ref)
		elseif ambient_gain_ref>10 then
			ambient_gain_ref=10
			setDataf(findDataref("sim/private/controls/clouds/ambient_gain"),ambient_gain_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, diffuse_gain_box) == true then
		
		diffuse_gain_ref=diffuse_gain_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/clouds/diffuse_gain"),diffuse_gain_ref)
		if diffuse_gain_ref<=-10 then
			diffuse_gain_ref=-10
			setDataf(findDataref("sim/private/controls/clouds/diffuse_gain"),diffuse_gain_ref)
		elseif diffuse_gain_ref>10 then
			diffuse_gain_ref=10
			setDataf(findDataref("sim/private/controls/clouds/diffuse_gain"),diffuse_gain_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, white_point_box) == true then
		
		white_point_ref=white_point_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/hdr/white_point"),white_point_ref)
		if white_point_ref<=0 then
			white_point_ref=0
			setDataf(findDataref("sim/private/controls/hdr/white_point"),white_point_ref)
		elseif white_point_ref>50 then
			white_point_ref=50
			setDataf(findDataref("sim/private/controls/hdr/white_point"),white_point_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, atmo_scale_raleigh_box) == true  and xEnviro==0 then
		
		atmo_scale_raleigh_ref=atmo_scale_raleigh_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"),atmo_scale_raleigh_ref)
		if atmo_scale_raleigh_ref<=0 then
			atmo_scale_raleigh_ref=0
			setDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"),atmo_scale_raleigh_ref)
		elseif atmo_scale_raleigh_ref>50 then
			atmo_scale_raleigh_ref=50
			setDataf(findDataref("sim/private/controls/atmo/atmo_scale_raleigh"),atmo_scale_raleigh_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, inscatter_gain_raleigh_box) == true  and xEnviro==0 then
		
		inscatter_gain_raleigh_ref=inscatter_gain_raleigh_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"),inscatter_gain_raleigh_ref)
		if inscatter_gain_raleigh_ref<=0 then
			inscatter_gain_raleigh_ref=0
			setDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"),inscatter_gain_raleigh_ref)
		elseif inscatter_gain_raleigh_ref>50 then
			inscatter_gain_raleigh_ref=50
			setDataf(findDataref("sim/private/controls/atmo/inscatter_gain_raleigh"),inscatter_gain_raleigh_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, max_shadow_angle_box) == true then
		
		max_shadow_angle_ref=max_shadow_angle_ref + MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"),max_shadow_angle_ref)
		if max_shadow_angle_ref<=-180 then
			max_shadow_angle_ref=-180
			setDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"),max_shadow_angle_ref)
		elseif max_shadow_angle_ref>180 then
			max_shadow_angle_ref=180
			setDataf(findDataref("sim/private/controls/skyc/max_shadow_angle"),max_shadow_angle_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, min_shadow_angle_box) == true then
		
		min_shadow_angle_ref=min_shadow_angle_ref + MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/min_shadow_angle"),min_shadow_angle_ref)
		if min_shadow_angle_ref<=-180 then
			min_shadow_angle_ref=-180
			setDataf(findDataref("sim/private/controls/skyc/min_shadow_angle"),min_shadow_angle_ref)
		elseif min_shadow_angle_ref>180 then
			min_shadow_angle_ref=180
			setDataf(findDataref("sim/private/controls/skyc/min_shadow_angle"),min_shadow_angle_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, max_dsf_vis_ever_box) == true then
		
		max_dsf_vis_ever_ref=max_dsf_vis_ever_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"),max_dsf_vis_ever_ref)
		if max_dsf_vis_ever_ref<=0 then
			max_dsf_vis_ever_ref=0
			setDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"),max_dsf_vis_ever_ref)
		elseif max_dsf_vis_ever_ref>100000 then
			max_dsf_vis_ever_ref=100000
			setDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"),max_dsf_vis_ever_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, dsf_fade_ratio_box) == true then
		
		dsf_fade_ratio_ref=dsf_fade_ratio_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"),dsf_fade_ratio_ref)
		if dsf_fade_ratio_ref<=0 then
			dsf_fade_ratio_ref=0
			setDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"),dsf_fade_ratio_ref)
		elseif dsf_fade_ratio_ref>0.99 then
			dsf_fade_ratio_ref=0.99
			setDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"),dsf_fade_ratio_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, dsf_cutover_scale_box) == true then
		
		dsf_cutover_scale_ref=dsf_cutover_scale_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale"),dsf_cutover_scale_ref)
		if dsf_cutover_scale_ref<=0 then
			dsf_cutover_scale_ref=0
			setDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale"),dsf_cutover_scale_ref)
		elseif dsf_cutover_scale_ref>2 then
			dsf_cutover_scale_ref=2
			setDataf(findDataref("sim/private/controls/skyc/dsf_cutover_scale"),dsf_cutover_scale_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, min_tone_angle_box) == true  and xEnviro==0 then
		
		min_tone_angle_ref=min_tone_angle_ref + MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/min_tone_angle"),min_tone_angle_ref)
		if min_tone_angle_ref<=-100 then
			min_tone_angle_ref=-100
			setDataf(findDataref("sim/private/controls/skyc/min_tone_angle"),min_tone_angle_ref)
		elseif min_tone_angle_ref>100 then
			min_tone_angle_ref=100
			setDataf(findDataref("sim/private/controls/skyc/min_tone_angle"),min_tone_angle_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, max_tone_angle_box) == true  and xEnviro==0 then
		
		max_tone_angle_ref=max_tone_angle_ref + MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/max_tone_angle"),max_tone_angle_ref)
		if max_tone_angle_ref<=-100 then
			max_tone_angle_ref=-100
			setDataf(findDataref("sim/private/controls/skyc/max_tone_angle"),max_tone_angle_ref)
		elseif max_tone_angle_ref>100 then
			max_tone_angle_ref=100
			setDataf(findDataref("sim/private/controls/skyc/max_tone_angle"),max_tone_angle_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_clean_box) == true and xEnviro==0 then
		
		tone_ratio_clean_ref=tone_ratio_clean_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"),tone_ratio_clean_ref)
		if tone_ratio_clean_ref<=-50 then
			tone_ratio_clean_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"),tone_ratio_clean_ref)
		elseif tone_ratio_clean_ref>50 then
			tone_ratio_clean_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_clean"),tone_ratio_clean_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_foggy_box) == true and xEnviro==0 then
		
		tone_ratio_foggy_ref=tone_ratio_foggy_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"),tone_ratio_foggy_ref)
		if tone_ratio_foggy_ref<=-50 then
			tone_ratio_foggy_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"),tone_ratio_foggy_ref)
		elseif tone_ratio_foggy_ref>50 then
			tone_ratio_foggy_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_foggy"),tone_ratio_foggy_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_hazy_box) == true and xEnviro==0  then
		
		tone_ratio_hazy_ref=tone_ratio_hazy_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"),tone_ratio_hazy_ref)
		if tone_ratio_hazy_ref<=-50 then
			tone_ratio_hazy_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"),tone_ratio_hazy_ref)
		elseif tone_ratio_hazy_ref>50 then
			tone_ratio_hazy_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hazy"),tone_ratio_hazy_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_snowy_box) == true and xEnviro==0  then
		
		tone_ratio_snowy_ref=tone_ratio_snowy_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"),tone_ratio_snowy_ref)
		if tone_ratio_snowy_ref<=-50 then
			tone_ratio_snowy_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"),tone_ratio_snowy_ref)
		elseif tone_ratio_snowy_ref>50 then
			tone_ratio_snowy_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_snowy"),tone_ratio_snowy_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_ocast_box) == true and xEnviro==0  then
		
		tone_ratio_ocast_ref=tone_ratio_ocast_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"),tone_ratio_ocast_ref)
		if tone_ratio_ocast_ref<=-50 then
			tone_ratio_ocast_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"),tone_ratio_ocast_ref)
		elseif tone_ratio_ocast_ref>50 then
			tone_ratio_ocast_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_ocast"),tone_ratio_ocast_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_strat_box) == true and xEnviro==0  then
		
		tone_ratio_strat_ref=tone_ratio_strat_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"),tone_ratio_strat_ref)
		if tone_ratio_strat_ref<=-50 then
			tone_ratio_strat_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"),tone_ratio_strat_ref)
		elseif tone_ratio_strat_ref>50 then
			tone_ratio_strat_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_strat"),tone_ratio_strat_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_clouds_and_sky_item, tone_ratio_hialt_box) == true and xEnviro==0  then
		
		tone_ratio_hialt_ref=tone_ratio_hialt_ref + 0.1*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"),tone_ratio_hialt_ref)
		if tone_ratio_hialt_ref<=-50 then
			tone_ratio_hialt_ref=-50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"),tone_ratio_hialt_ref)
		elseif tone_ratio_hialt_ref>50 then
			tone_ratio_hialt_ref=50
			setDataf(findDataref("sim/private/controls/skyc/tone_ratio_hialt"),tone_ratio_hialt_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	----- VISIBILITY AND LIGHTS
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, visibility_reported_m_box) == true then
		
		visibility_reported_m_ref=visibility_reported_m_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/weather/visibility_reported_m"),visibility_reported_m_ref)
		if visibility_reported_m_ref<=0 then
			visibility_reported_m_ref=0
			setDataf(findDataref("sim/weather/visibility_reported_m"),visibility_reported_m_ref)
		elseif visibility_reported_m_ref>150000 then
			visibility_reported_m_ref=150000
			setDataf(findDataref("sim/weather/visibility_reported_m"),visibility_reported_m_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, LOD_bias_rat_box) == true then
		
		LOD_bias_rat_ref=LOD_bias_rat_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"),LOD_bias_rat_ref)
		if LOD_bias_rat_ref<=0.1 then
			LOD_bias_rat_ref=0.1
			setDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"),LOD_bias_rat_ref)
		elseif LOD_bias_rat_ref>20 then
			LOD_bias_rat_ref=20
			setDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"),LOD_bias_rat_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, cars_lod_min_box) == true then
		
		cars_lod_min_ref=cars_lod_min_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/cars/lod_min"),cars_lod_min_ref)
		if cars_lod_min_ref<=0 then
			cars_lod_min_ref=0
			setDataf(findDataref("sim/private/controls/cars/lod_min"),cars_lod_min_ref)
		elseif cars_lod_min_ref>100000 then
			cars_lod_min_ref=100000
			setDataf(findDataref("sim/private/controls/cars/lod_min"),cars_lod_min_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, tile_lod_bias_box) == true then
		
		tile_lod_bias_ref=tile_lod_bias_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/ag/tile_lod_bias"),tile_lod_bias_ref)
		if tile_lod_bias_ref<=0 then
			tile_lod_bias_ref=0
			setDataf(findDataref("sim/private/controls/ag/tile_lod_bias"),tile_lod_bias_ref)
		elseif tile_lod_bias_ref>1 then
			tile_lod_bias_ref=1
			setDataf(findDataref("sim/private/controls/ag/tile_lod_bias"),tile_lod_bias_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, fade_start_rat_box) == true then
		
		fade_start_rat_ref=fade_start_rat_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/terrain/fade_start_rat"),fade_start_rat_ref)
		if fade_start_rat_ref<=0 then
			fade_start_rat_ref=0
			setDataf(findDataref("sim/private/controls/terrain/fade_start_rat"),fade_start_rat_ref)
		elseif fade_start_rat_ref>1 then
			fade_start_rat_ref=1
			setDataf(findDataref("sim/private/controls/terrain/fade_start_rat"),fade_start_rat_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, composite_far_dist_bias_box) == true then
		
		composite_far_dist_bias_ref=composite_far_dist_bias_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"),composite_far_dist_bias_ref)
		if composite_far_dist_bias_ref<=0 then
			composite_far_dist_bias_ref=0
			setDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"),composite_far_dist_bias_ref)
		elseif composite_far_dist_bias_ref>1 then
			composite_far_dist_bias_ref=1
			setDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"),composite_far_dist_bias_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, fog_be_gone_box) == true then
		
		fog_be_gone_ref=fog_be_gone_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/fog/fog_be_gone"),fog_be_gone_ref)
		if fog_be_gone_ref<=0 then
			fog_be_gone_ref=0
			setDataf(findDataref("sim/private/controls/fog/fog_be_gone"),fog_be_gone_ref)
		elseif fog_be_gone_ref>5 then
			fog_be_gone_ref=5
			setDataf(findDataref("sim/private/controls/fog/fog_be_gone"),fog_be_gone_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, scale_near_box) == true and xEnviro==0  then
		
		scale_near_ref=scale_near_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/scale_near"),scale_near_ref)
		if scale_near_ref<=0 then
			scale_near_ref=0
			setDataf(findDataref("sim/private/controls/lights/scale_near"),scale_near_ref)
		elseif scale_near_ref>5 then
			scale_near_ref=5
			setDataf(findDataref("sim/private/controls/lights/scale_near"),scale_near_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, scale_far_box) == true and xEnviro==0  then
		
		scale_far_ref=scale_far_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/scale_far"),scale_far_ref)
		if scale_far_ref<=0 then
			scale_far_ref=0
			setDataf(findDataref("sim/private/controls/lights/scale_far"),scale_far_ref)
		elseif scale_far_ref>5 then
			scale_far_ref=5
			setDataf(findDataref("sim/private/controls/lights/scale_far"),scale_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, dist_near_box) == true then
		
		dist_near_ref=dist_near_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
		if dist_near_ref<=0 then
			dist_near_ref=0
			setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
		elseif dist_near_ref>99999 then
			dist_near_ref=99999
			setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
		end
		if dist_near_ref>=dist_far_ref then
			dist_far_ref=dist_near_ref
			dist_near_ref=dist_far_ref-100
			
			setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
			setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, dist_far_box) == true then
		
		dist_far_ref=dist_far_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
		if dist_far_ref<=0 then
			dist_far_ref=0
			setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
		elseif dist_far_ref>99999 then
			dist_far_ref=99999
			setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
		end
		if dist_far_ref<=dist_near_ref then
			dist_near_ref=dist_far_ref
			dist_far_ref=dist_near_ref+100
			setDataf(findDataref("sim/private/controls/lights/dist_near"),dist_near_ref)
			setDataf(findDataref("sim/private/controls/lights/dist_far"),dist_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, exponent_near_box) == true then
		
		exponent_near_ref=exponent_near_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/exponent_near"),exponent_near_ref)
		if exponent_near_ref<=0 then
			exponent_near_ref=0
			setDataf(findDataref("sim/private/controls/lights/exponent_near"),exponent_near_ref)
		elseif exponent_near_ref>1 then
			exponent_near_ref=1
			setDataf(findDataref("sim/private/controls/lights/exponent_near"),exponent_near_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, exponent_far_box) == true then
		
		exponent_far_ref=exponent_far_ref + 0.01*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/exponent_far"),exponent_far_ref)
		if exponent_far_ref<=0 then
			exponent_far_ref=0
			setDataf(findDataref("sim/private/controls/lights/exponent_far"),exponent_far_ref)
		elseif exponent_far_ref>1 then
			exponent_far_ref=1
			setDataf(findDataref("sim/private/controls/lights/exponent_far"),exponent_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, bloom_near_box) == true then
		
		bloom_near_ref=bloom_near_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
		if bloom_near_ref<=0 then
			bloom_near_ref=0
			setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
		elseif bloom_near_ref>99999 then
			bloom_near_ref=99999
			setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
		end
		if bloom_near_ref>=bloom_far_ref then
			bloom_far_ref=bloom_near_ref
			setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
			setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	if m_inbox_inn_tabs(d_tab, tab_visibility_item, bloom_far_box) == true then
		
		bloom_far_ref=bloom_far_ref + 100*MOUSE_WHEEL_CLICKS
		setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
		
		if bloom_far_ref<=0 then
			bloom_far_ref=0
			setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
		elseif bloom_far_ref>99999 then
			bloom_far_ref=99999
			setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
		end
		if bloom_far_ref<=bloom_near_ref then
			bloom_near_ref=bloom_far_ref
			setDataf(findDataref("sim/private/controls/lights/bloom_near"),bloom_near_ref)
			setDataf(findDataref("sim/private/controls/lights/bloom_far"),bloom_far_ref)
		end
		preset_loaded=0
		RESUME_MOUSE_WHEEL = true
	end
	
end
function exit_code_logic()
	save_settings()
end
set_interface_pos(0,0)
load_settings()
read_dref()
check_values_change()
do_often("read_dref()")
do_every_draw("on_start_up()")
do_every_draw("check_for_default()")
duration = 7
fade_time = 2
fade_switch = true
do_every_draw("draw_version_title(duration, fade_time, fade_switch, 0, 0, 390, 30,1)")
do_every_draw("draw_tab()")
do_every_draw("need_reload_func()")
do_every_draw("draw_menu_items()")
do_every_draw("draw_main_misc_settings()")
do_every_draw("draw_reflection_detail()")
do_every_draw("draw_shadow_on_scenery()")
do_every_draw("draw_number_of_objects()")
do_every_draw("texture_quality()")
do_every_draw("draw_clouds_and_atmo()")
do_every_draw("draw_visibility_and_lights()")
do_every_draw("draw_plugin_settings()")
do_on_mouse_click("mouse_click_events()")
do_on_mouse_wheel("wheel_mouse_events()")
do_on_exit( "exit_code_logic()" )
do_every_draw("first_reload()")
-- custom
setDataf(findDataref("sim/private/controls/planet/hires_steps"),1.0)
setDataf(findDataref("sim/private/controls/skyc/min_dsf_vis_ever"),60000.00)
setDataf(findDataref("sim/private/controls/perf/kill_udp_read"),0)
setDataf(findDataref("sim/private/controls/perf/kill_atc"),1)
