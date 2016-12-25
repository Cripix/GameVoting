#define VERSION "1.8.2dev"
#define GV_DEBUG  1
#define BAN_TYPE  0
#define KICK_TYPE 1
#define GAG_TYPE  2
#define MUTE_TYPE 3
#define BAN_COMMAND  "voteban"
#define KICK_COMMAND "votekick"
#define GAG_COMMAND  "votegag"
#define MUTE_COMMAND "votemute"
#define PLUGIN_TAG "[GameVoting]"
#define CONVAR_VERSION 0
#define CONVAR_ENABLED 1
#define CONVAR_BAN_DURATION 2

public Plugin myinfo =
{
	name = "GameVoting",
	author = "Neatek",
	description = "Simple sourcemod plugin for voting",
	version = VERSION,
	url = "https://github.com/neatek/GameVoting"
};