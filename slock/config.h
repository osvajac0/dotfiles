/* user and group to drop privileges to */
static const char *user  = "pax"; // put your username here
static const char *group = "wheel"; // put your group here

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#000000",     /* after initialization */
	[INPUT] =  "#353749", /* during input */
	[FAILED] = "#9e3131",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
