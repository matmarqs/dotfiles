//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/    /*Command*/                         /*Update Interval*/       /*Update Signal*/
  {"",        "/usr/local/scripts/sb-vol",        60,                       10},
  {"",        "/usr/local/scripts/sb-bri",        60,                       11},
  {"",        "/usr/local/scripts/sb-bat",        60,                       12},
  {"",        "/usr/local/scripts/sb-hor",        60,                       13},
};

// alternative command to get current volume:
// amixer get Master | grep "Left:" | awk -F'[][]' '{print $2}'

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
