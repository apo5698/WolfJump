/// @description Sign text

//Equation Generator
operation = floor(random_range(1,4.99));
if operation == 1
{
	X = floor(random_range(1,50.99));
	Y = floor(random_range(1,50.99));
	S = X + Y;
	text = string(X) + "+" + string(Y) + "= ";
}
else if operation == 2
{
	X = floor(random_range(1,100.99));
	Y = floor(random_range(1,100.99));
	if X >= Y
	{
		text = string(X) + "-" + string(Y) + "= ";
		S = X - Y;
	}
	else
	{
		text = string(Y) + "-" + string(X) + "= ";
		S = Y - X;
	}
}
else if operation == 3
{
	X = floor(random_range(1,12.99));
	Y = floor(random_range(1,12.99));
	S = X * Y;
	text = string(X) + "x" + string(Y) + "= ";
}
else if operation == 4
{
	S = floor(random_range(1,12.99));
	Y = floor(random_range(1,12.99));
	X = S * Y;
	text = string(X) + "/" + string(Y) + "= ";
}




//Proximity
if (instance_exists(oPlayer)) && (point_in_circle(oPlayer.x,oPlayer.y,x,y,64)) && (!instance_exists(oText))
{
	nearby = true;
	if (keyboard_check_pressed(vk_up))
	{
		flagid = instance_nearest(oPlayer.x,oPlayer.y,oFlag)
		with (instance_create_layer(x,y-64,layer,oText))
		{
			flagid = other.flagid;
			S = other.S;
			text = other.text;
			length = string_length(text);
		}
	
		with (oCamera)
		{
			follow = other.id;
		}
	}
}
else nearby = false;
