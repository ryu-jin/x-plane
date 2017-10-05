-----XP11 TheULTIMATE MOD v2.0 Beta
local start_time = os.clock()
local do_once = false 

function sim()
	if os.clock() > start_time and do_once == false then
	-----Misc
    set( "sim/private/controls/reno/draw_deer_birds", 0)
	set( "sim/private/controls/reno/draw_fire_ball", 0)
	---To enable Boats (1) to Disable Boats (0) 
	set( "sim/private/controls/reno/draw_boats", 0)
	set( "sim/private/controls/reno/draw_aurora", 0)
	set( "sim/private/controls/reno/draw_scattering", 1)
	set( "sim/private/controls/reno/draw_volume_fog01", 1)
	set( "sim/private/controls/reno/draw_per_pix_liting", 1)

-----Fog Vis
	set( "sim/private/controls/fog/fog_be_gone", 0.5)
-----Lights 
    set( "sim/private/controls/lights/scale_near", 0.1)
	set( "sim/private/controls/lights/scale_far", 1)
	set( "sim/private/controls/lights/dist_near", 200)
	set( "sim/private/controls/lights/dist_far", 8500)
	set( "sim/private/controls/lights/exponent_near", 0.5)
	set( "sim/private/controls/lights/exponent_far", 0.45)
	set( "sim/private/controls/lights/bloom_near", 100)
    set( "sim/private/controls/lights/bloom_far", 2500) 
    do_once=true 
	end
end
do_often("sim()")
	
    
   
    
	
	
	
	

	