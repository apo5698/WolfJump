/// @description Equations Completed Counter (and time eventually)
if (room != rMenu) && (instance_exists(oPlayer))
{
	{
		flagtextscale = max(flagtextscale * 0.95, 1);
		DrawSetText(c_black, fMenu, fa_right, fa_top);
		draw_text_transformed(RES_W-8,12,string(global.flagscollected) + " Flags Collected", flagtextscale, flagtextscale, 0);
		draw_set_color(c_white);
		draw_text_transformed(RES_W-10,10,string(global.flagscollected) + " Flags Collected", flagtextscale, flagtextscale, 0);
	}
	{
		timescale = 1;
		DrawSetText(c_black, fMenu, fa_left, fa_top);
		draw_text_transformed(RES_W-1000,12,string(global.time) + " Time Remaining", timescale, timescale, 0);
		draw_set_color(c_white);
		draw_text_transformed(RES_W-1002,10,string(global.time) + " Time Remaining", timescale, timescale, 0);
	}
}
