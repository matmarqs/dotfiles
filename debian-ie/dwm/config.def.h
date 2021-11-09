/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const unsigned int gappih    = 15;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 15;       /* vert inner gap between windows */
static const unsigned int gappoh    = 15;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 15;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Ubuntu Mono:style=Regular:size=12", "FontAwesome:style=Regular:size=12", "Noto Sans Mono CJK JP:style=Regular:size=10" };
static const char dmenufont[]       = "Ubuntu Mono:style=Regular:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_purpl[]       = "#2a0d4a";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_purpl,  "#5fff5f" },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

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
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "D[]",      deck },
	{ "[M]",      monocle },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ NULL,       NULL },
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
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_purpl, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browser[]  = { "qutebrowser", NULL };
static const char *fileman[]  = { "st", "-e", "ranger", NULL };
static const char *clipman[]  = { "clipmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_purpl, "-sf", col_gray4, NULL };
//static const char *warning[]  = { "zathura", "/home/darkin/path/to/guia.pdf", NULL };
static const char *printsz[]  = { "scrot", "-s", "/home/darkin/Pictures/prints/%b-%d-%H:%M:%S.png", NULL };
static const char *printfs[]  = { "scrot", "/home/darkin/Pictures/prints/%b-%d-%H:%M:%S.png", NULL };

static Key keys[] = {
	/* modifier                     key                function        argument */
	{ MODKEY,                       XK_d,              spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,         spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_w,              spawn,          {.v = browser } },
	{ MODKEY|ShiftMask,             XK_Return,         spawn,          {.v = fileman } },
	{ MODKEY,                       XK_backslash,      spawn,          {.v = clipman } },
//	{ MODKEY,                       XK_F1,             spawn,          {.v = warning } },
	{ 0,                            XK_Print,          spawn,          {.v = printsz } },
	{ MODKEY,                       XK_Print,          spawn,          {.v = printfs } },
	{ MODKEY,                       XK_Up,             spawn,          SHCMD("amixer -q set Master 5%+; kill -44 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,             XK_Up,             spawn,          SHCMD("amixer -q set Master 15%+; kill -44 $(pidof dwmblocks)") },
	{ MODKEY,                       XK_Down,           spawn,          SHCMD("amixer -q set Master 5%-; kill -44 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,             XK_Down,           spawn,          SHCMD("amixer -q set Master 15%-; kill -44 $(pidof dwmblocks)") },
	{ MODKEY,                       XK_BackSpace,      spawn,          SHCMD("amixer -q set Master toggle; kill -44 $(pidof dwmblocks)") },
	{ MODKEY,                       XK_b,              togglebar,      {0} },
	{ MODKEY,                       XK_j,              focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,              focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,              pushdown,       {0} },
	{ MODKEY|ShiftMask,             XK_k,              pushup,         {0} },
	{ MODKEY,                       XK_n,              incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_n,              incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,              setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_l,              setmfact,       {.f = +0.02} },
	{ MODKEY,                       XK_m,              zoom,           {0} },
	{ MODKEY,                       XK_minus,          incrgaps,       {.i = +1 } },
	{ MODKEY,                       XK_equal,          incrgaps,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_minus,          defaultgaps,    {0} },
	{ MODKEY|ShiftMask,             XK_equal,          togglegaps,     {0} },
//	{ MODKEY|Mod4Mask,              XK_i,              incrigaps,      {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,              incrigaps,      {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_o,              incrogaps,      {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,              incrogaps,      {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_6,              incrihgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,              incrihgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_7,              incrivgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,              incrivgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_8,              incrohgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,              incrohgaps,     {.i = -1 } },
//	{ MODKEY|Mod4Mask,              XK_9,              incrovgaps,     {.i = +1 } },
//	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,              incrovgaps,     {.i = -1 } },
	{ MODKEY,                       XK_Tab,            view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,              killclient,     {0} },
	{ MODKEY,                       XK_q,              setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_e,              setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_w,              setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_e,              setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_r,              setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,             XK_r,              setlayout,      {.v = &layouts[5]} },
	{ MODKEY,                       XK_t,              setlayout,      {.v = &layouts[6]} },
	{ MODKEY|ShiftMask,             XK_t,              setlayout,      {.v = &layouts[7]} },
	{ MODKEY,                       XK_y,              setlayout,      {.v = &layouts[8]} },
	{ MODKEY|ShiftMask,             XK_y,              setlayout,      {.v = &layouts[9]} },
	{ MODKEY,                       XK_u,              setlayout,      {.v = &layouts[10]} },
	{ MODKEY|ShiftMask,             XK_u,              setlayout,      {.v = &layouts[11]} },
	{ MODKEY,                       XK_i,              setlayout,      {.v = &layouts[12]} },
	{ MODKEY|ShiftMask,             XK_i,              setlayout,      {.v = &layouts[13]} },
	{ MODKEY,                       XK_comma,          cyclelayout,    {.i = -1 } },
	{ MODKEY,                       XK_period,         cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_space,          setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,          togglefloating, {0} },
	{ MODKEY,                       XK_f,              togglefullscr,  {0} },
	{ MODKEY,                       XK_0,              view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,              tag,            {.ui = ~0 } },
    /******* As funcoes focusmon e tagmon so servem para multiplos monitores *******/
//	{ MODKEY,                       XK_comma,          focusmon,       {.i = -1 } },
//	{ MODKEY,                       XK_period,         focusmon,       {.i = +1 } },
//	{ MODKEY|ShiftMask,             XK_comma,          tagmon,         {.i = -1 } },
//	{ MODKEY|ShiftMask,             XK_period,         tagmon,         {.i = +1 } },
    /*******************************************************************************/
	{ MODKEY,                       XK_Left,           rotatetags,     {.i = -1 } },
	{ MODKEY,                       XK_Right,          rotatetags,     {.i = +1 } },
	TAGKEYS(                        XK_1,                              0)
	TAGKEYS(                        XK_2,                              1)
	TAGKEYS(                        XK_3,                              2)
	TAGKEYS(                        XK_4,                              3)
	TAGKEYS(                        XK_5,                              4)
	TAGKEYS(                        XK_6,                              5)
	TAGKEYS(                        XK_7,                              6)
	TAGKEYS(                        XK_8,                              7)
	TAGKEYS(                        XK_9,                              8)
	{ MODKEY|MADKEY|ControlMask,    XK_End,            quit,           {0} },
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

