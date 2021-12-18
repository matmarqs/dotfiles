//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/    /*Command*/                                 /*Update Interval*/       /*Update Signal*/
  {"",        "/home/sekai/scripts/statusbar/vol",        0,                        10},
  {"",        "/home/sekai/scripts/statusbar/bri",        0,                        11},
  {"",        "/home/sekai/scripts/statusbar/bat",        60,                       12},
  {"",        "/home/sekai/scripts/statusbar/hor",        60,                       13},
};

// Comando alternativo para obter o volume:
// amixer get Master | grep "Left:" | awk -F'[][]' '{print $2}'

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
