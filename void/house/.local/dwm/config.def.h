/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const unsigned int gappih    = 13;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 13;       /* vert inner gap between windows */
static const unsigned int gappoh    = 13;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 13;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "mononoki:style=Regular:size=10", "Font Awesome 5 Free:style=Solid:size=10", "Noto Sans CJK JP:style=Medium:size=9" };
static const char dmenufont[]       = "mononoki:style=Regular:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#1e8c4c";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  "#1ca6fb" },
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 },
//	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "Firefox", NULL,     NULL,           0,         0,          0,          -1,        -1 },
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	       /* symbol     arrange function */
/*  0  */  { "[]=",      tile },    /* first entry is default */
/*  1  */  { "|M|",      centeredmaster },
/*  2  */  { "[@]",      spiral },
/*  3  */  { ":::",      gaplessgrid },
/*  4  */  { ">M>",      centeredfloatingmaster },
/*  5  */  { "D[]",      deck },
/*  6  */  { "TTT",      bstack },
/*  7  */  { "[M]",      monocle },
/*  8  */  { "><>",      NULL },    /* no layout function means floating behavior */
           { NULL,       NULL },
/*  ?  *///{ "---",      horizgrid },
/*  ?  *///{ "HHH",      grid },
/*  ?  *///{ "[\\]",     dwindle },
/*  ?  *///{ "###",      nrowgrid },
/*  ?  *///{ "===",      bstackhoriz },
};

/* key definitions */
#define MODKEY Mod4Mask
#define MADKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browser[]  = { "firefox", NULL };
static const char *fileman[]  = { "st", "-e", "ranger", NULL };
static const char *clipman[]  = { "clipmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *printsz[]  = { "scrot", "-s", "$HOME/Pictures/prints/%b_%d_%H-%M-%S.png", NULL };
static const char *printfs[]  = { "scrot", "$HOME/Pictures/prints/%b_%d_%H-%M-%S.png", NULL };


static Key keys[] = {
	/* modifier                     key            function        argument */
	{ MODKEY,                       XK_d,          spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,     spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_w,          spawn,          {.v = browser } },
	{ MODKEY|ShiftMask,             XK_Return,     spawn,          {.v = fileman } },
	{ MODKEY,                       XK_backslash,  spawn,          {.v = clipman } },
	{ 0,                            XK_Print,      spawn,          {.v = printsz } },
	{ MODKEY,                       XK_Print,      spawn,          {.v = printfs } },
    /************************************************************* LIGHT **************************************************************/
	{ MODKEY,                       XK_Prior,      spawn,	        SHCMD("xbacklight -inc 5; kill -45 $(pidof dwmblocks)") },          // UP
	{ MODKEY|ShiftMask,             XK_Prior,      spawn,	        SHCMD("xbacklight -inc 15; kill -45 $(pidof dwmblocks)") },         // BIG UP
	{ MODKEY,                       XK_Next,       spawn,	        SHCMD("xbacklight -dec 5; kill -45 $(pidof dwmblocks)") },          // DOWN
	{ MODKEY|ShiftMask,             XK_Next,       spawn,	        SHCMD("xbacklight -dec 15; kill -45 $(pidof dwmblocks)") },         // BIG DOWN
    /************************************************************* VOLUME *************************************************************/
	{ MODKEY,                       XK_equal,      spawn,          SHCMD("amixer -q set Master 5%+; kill -44 $(pidof dwmblocks)") },    // UP
	{ MODKEY|ShiftMask,             XK_equal,      spawn,          SHCMD("amixer -q set Master 15%+; kill -44 $(pidof dwmblocks)") },   // BIG UP
	{ MODKEY,                       XK_minus,      spawn,          SHCMD("amixer -q set Master 5%-; kill -44 $(pidof dwmblocks)") },    // DOWN
	{ MODKEY|ShiftMask,             XK_minus,      spawn,          SHCMD("amixer -q set Master 15%-; kill -44 $(pidof dwmblocks)") },   // BIG DOWN
	{ MODKEY,                       XK_BackSpace,  spawn,          SHCMD("amixer -q set Master toggle; kill -44 $(pidof dwmblocks)") }, // PLAY-PAUSE
    /************************************************************* MUSIC **************************************************************/
	{ MODKEY|ControlMask,           XK_equal,      spawn,          SHCMD("/usr/local/scripts/music-vol_up") },      // UP
	{ MODKEY|ControlMask,           XK_Up,         spawn,          SHCMD("/usr/local/scripts/music-vol_up") },      // UP
	{ MODKEY|ControlMask|ShiftMask, XK_equal,      spawn,          SHCMD("/usr/local/scripts/music-vol_bigup") },   // BIG UP
	{ MODKEY|ControlMask|ShiftMask, XK_Up,         spawn,          SHCMD("/usr/local/scripts/music-vol_bigup") },   // BIG UP
	{ MODKEY|ControlMask,           XK_minus,      spawn,          SHCMD("/usr/local/scripts/music-vol_down") },    // DOWN
	{ MODKEY|ControlMask,           XK_Down,       spawn,          SHCMD("/usr/local/scripts/music-vol_down") },    // DOWN
	{ MODKEY|ControlMask|ShiftMask, XK_minus,      spawn,          SHCMD("/usr/local/scripts/music-vol_bigdown") }, // BIG DOWN
	{ MODKEY|ControlMask|ShiftMask, XK_Down,       spawn,          SHCMD("/usr/local/scripts/music-vol_bigdown") }, // BIG DOWN
	{ 0,                            XK_Pause,      spawn,          SHCMD("/usr/local/scripts/music-playpause") },   // PLAY-PAUSE
	{ MODKEY|ControlMask,           XK_Right,      spawn,          SHCMD("/usr/local/scripts/music-next") },        // NEXT
	{ MODKEY|ControlMask,           XK_Left,       spawn,          SHCMD("/usr/local/scripts/music-prev") },        // PREVIOUS
    /**********************************************************************************************************************************/
	{ MODKEY,                       XK_b,          togglebar,      {0} },
	{ MODKEY,                       XK_j,          focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Down,       focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,          focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Up,         focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,          pushdown,       {0} },
	{ MODKEY|ShiftMask,             XK_Down,       pushdown,       {0} },
	{ MODKEY|ShiftMask,             XK_k,          pushup,         {0} },
	{ MODKEY|ShiftMask,             XK_Up,         pushup,         {0} },
	{ MODKEY,                       XK_n,          incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_n,          incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,          setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_Left,       setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_l,          setmfact,       {.f = +0.02} },
	{ MODKEY,                       XK_Right,      setmfact,       {.f = +0.02} },
	{ MODKEY,                       XK_m,          zoom,           {0} },
	{ MODKEY,                       XK_o,          incrgaps,       {.i = +1 } },
	{ MODKEY,                       XK_p,          incrgaps,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_o,          defaultgaps,    {0} },
	{ MODKEY|ShiftMask,             XK_p,          togglegaps,     {0} },
    /* vanity gaps has a lot of unnecessary functions. disable some functions */
//	{ MODKEY|Mod4Mask,              XK_i,          incrigaps,      {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,          incrigaps,      {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_o,          incrogaps,      {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,          incrogaps,      {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_6,          incrihgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,          incrihgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_7,          incrivgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,          incrivgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_8,          incrohgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,          incrohgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_9,          incrovgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,          incrovgaps,     {.i = -1 } },
    /*******************************************************************************/
	{ MODKEY,                       XK_Tab,        view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,          killclient,     {0} },
	{ MODKEY,                       XK_q,          setlayout,      {.v = &layouts[0]} }, // tile
	{ MODKEY,                       XK_w,          setlayout,      {.v = &layouts[7]} }, // monocle
	{ MODKEY,                       XK_e,          setlayout,      {.v = &layouts[8]} }, // floating
	{ MODKEY,                       XK_s,          setlayout,      {.v = &layouts[2]} }, // spiral
	{ MODKEY,                       XK_y,          setlayout,      {.v = &layouts[5]} }, // deck
	{ MODKEY,                       XK_u,          setlayout,      {.v = &layouts[3]} }, // ::: gapless grid
	{ MODKEY|ShiftMask,             XK_u,          setlayout,      {.v = &layouts[6]} }, // TTT bstack
	{ MODKEY,                       XK_i,          setlayout,      {.v = &layouts[1]} }, // centered master
	{ MODKEY|ShiftMask,             XK_i,          setlayout,      {.v = &layouts[4]} }, // floating centered master
    /***********************************  some useless layouts i think ***********************************/
//	{ MODKEY,                       XK_?,          setlayout,      {.v = &layouts[??]} }, // --- horizgrid
//	{ MODKEY,                       XK_?,          setlayout,      {.v = &layouts[??]} }, // HHH grid
//	{ MODKEY,                       XK_?,          setlayout,      {.v = &layouts[??]} }, // dwindle
//	{ MODKEY|ShiftMask,             XK_?,          setlayout,      {.v = &layouts[??]} }, // ### nrowgrid
//	{ MODKEY|ShiftMask,             XK_?,          setlayout,      {.v = &layouts[8]}  }, // === bstack horiz
    /*****************************************************************************************************/
	{ MODKEY,                       XK_comma,      cyclelayout,    {.i = -1 } },
	{ MODKEY,                       XK_period,     cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_a,          setlayout,      {0} },
	{ MODKEY,                       XK_space,      togglefloating, {0} },
	{ MODKEY,                       XK_f,          togglefullscr,  {0} },
	{ MODKEY,                       XK_0,          view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,          tag,            {.ui = ~0 } },
    /********* the functions focusmon and tagmon are only useful for multiple monitors ********/
//	{ MODKEY,                       XK_comma,      focusmon,       {.i = -1 } },
//	{ MODKEY,                       XK_period,     focusmon,       {.i = +1 } },
//	{ MODKEY|ShiftMask,             XK_comma,      tagmon,         {.i = -1 } },
//	{ MODKEY|ShiftMask,             XK_period,     tagmon,         {.i = +1 } },
    /******************************************************************************************/
	{ MODKEY,                       XK_ccedilla,   rotatetags,     {.i = -1 } },
	{ MODKEY,                       XK_dead_tilde, rotatetags,     {.i = +1 } },
	TAGKEYS(                        XK_1,                          0)
	TAGKEYS(                        XK_2,                          1)
	TAGKEYS(                        XK_3,                          2)
	TAGKEYS(                        XK_4,                          3)
	TAGKEYS(                        XK_5,                          4)
	TAGKEYS(                        XK_6,                          5)
	TAGKEYS(                        XK_7,                          6)
	TAGKEYS(                        XK_8,                          7)
	TAGKEYS(                        XK_9,                          8)
	{ MODKEY|MADKEY|ControlMask,    XK_End,        quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
