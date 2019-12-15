/// @description Timer countdown

if room != rMenu
{
	timer --;
}

seconds = floor(timer/60) mod 60;

minutes = floor(timer/3600);

global.time = string(minutes) + ":" + string(seconds);

if timer == 0
{
	game_restart();
}