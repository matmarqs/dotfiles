//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/   /*Command*/											  /*Interval*/	/*Signal*/
	{"  BAT ", "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}'", 30,		10},
      /*{" VOL ",  "amixer get Master | grep "Left:" | awk '{print $5}'",					  0,		11},*/
	{"VOL ",   "pamixer --get-volume-human",								  10,		11},
	{"",       "date '+%a, %b %d, %R '",									  60,		12},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
