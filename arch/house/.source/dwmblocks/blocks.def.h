//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/    /*Command*/                      /*Update Interval*/       /*Update Signal*/
  {"",        "/usr/local/scripts/vol",        0,                        10},
  {"",        "/usr/local/scripts/bri",        0,                        11},
  {"",        "/usr/local/scripts/bat",        60,                       12},
  {"",        "/usr/local/scripts/hor",        60,                       13},
};

// alternative command to get current volume:
// amixer get Master | grep "Left:" | awk -F'[][]' '{print $2}'

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
