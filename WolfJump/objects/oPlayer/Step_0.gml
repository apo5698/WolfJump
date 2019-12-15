#region //Get player input

if (hascontrol)
{
	key_left = keyboard_check(vk_left);
	key_right = keyboard_check(vk_right);
	key_jump = keyboard_check_pressed(vk_space);
}
else
{
	key_right = 0;
	key_left = 0;
	key_jump = 0;
}

#endregion

#region //Calculate Horizontal Movement
walljumpdelay = max(walljumpdelay-1,0);
if (walljumpdelay == 0)
{
	var dir = key_right - key_left;
	hsp += dir * hsp_acc;
	if (dir == 0)
	{
		var hsp_fric_final = hsp_fric_ground;
		if (!onground) hsp_fric_final = hsp_fric_air;
		hsp = Approach(hsp,0,hsp_fric_final);
	}
	hsp = clamp(hsp,-hsp_walk,hsp_walk);
}
//Wall Jump
if (onwall != 0) && (!onground) && (key_jump)
{
	walljumpdelay = walljumpdelay_max;
	
	hsp = -onwall * hsp_wjump;
	vsp = vsp_wjump;
	
	hsp_frac = 0;
	vsp_frac = 0;
}

#endregion

#region //Calculate Vertical Movement
var grv_final = grv;
var vsp_max_final = vsp_max;
if (onwall != 0) && (vsp > 0)
{
	grv_final = grv_wall;
	vsp_max_final = vsp_max_wall
}
vsp += grv_final;
vsp = clamp(vsp,-vsp_max_final,vsp_max_final);

//Ground Jumping
if (jumpbuffer > 0)
{
	jumpbuffer--;
	if(key_jump)
	{
		jumpbuffer = 0;
		vsp = vsp_jump;
		vsp_frac = 0;
	}
}
vsp = clamp(vsp,-vsp_max,vsp_max);

#endregion

#region //Dump fractions and get final integer speeds
hsp += hsp_frac;
vsp += vsp_frac;
hsp_frac = frac(hsp);
vsp_frac = frac(vsp);
hsp -= hsp_frac;
vsp -= vsp_frac

#endregion

#region //Horizontal Collision
if (place_meeting(x+hsp,y,oWall))
{
	var onepixel = sign(hsp);
	while (!place_meeting(x+onepixel,y,oWall)) x += onepixel;
	hsp = 0;
	hsp_frac = 0;
}
//Horizontal Move
x += hsp;

#endregion

#region //Vertical Collision
if (place_meeting(x,y+vsp,oWall))
{
	var onepixel = sign(vsp);
	while (!place_meeting(x,y+onepixel,oWall)) y += onepixel;
	vsp = 0;
	vsp_frac = 0;
}
//Veritcal Move
y += vsp;

#endregion

#region //Calculate Current Status
onground = place_meeting(x,y+1,oWall);
onwall = place_meeting(x+1,y,oWall) - place_meeting(x-1,y,oWall);
if (onground) jumpbuffer = 6;

#endregion

#region //Animations
if (!place_meeting(x,y+1,oWall))
{
	if (onwall != 0)
	{
		sprite_index = sPlayerA;
		image_xscale = onwall;
		
		var side = bbox_left;
		if (onwall == 1) side = bbox_right;
		dust++;
		if ((dust > 2) && (vsp > 0)) with (instance_create_layer(side,bbox_top,"Player",oDust))
		{
			other.dust = 0;
			hspeed = -other.onwall*0.5;
		}
	}
	else
	{
		dust = 0;
		sprite_index = sPlayerA;
		image_speed = 0;
		if (sign(vsp) > 0) image_index = 1; else image_index = 0;
	}
}
else
{
	jumpbuffer = 10;
	if (sprite_index == sPlayerA)
	{
		audio_sound_pitch(snLanding,choose(0.8,1.0,1.2));
		audio_play_sound(snLanding,4,false);
		repeat(5)
		{
			with (instance_create_layer(x,bbox_bottom,"Player",oDust))
			{
				vsp = 0;
			}
		}
	}
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = sPlayer;
	}
	else
	{
		sprite_index = sPlayerR;
	}
}

if (hsp != 0) image_xscale = sign(hsp);

#endregion