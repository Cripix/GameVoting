#pragma semicolon 1
#pragma newdecls required
/*
	GameVoting 1.8.0dev (sourcemod-1.8.0-git5967)
	- Author: Vladimir Zhelnov (neatek.pw)
	- 24.12.2016 - 17:19
*/

#define GV_DEBUG  1
#define BAN_TYPE  0
#define KICK_TYPE 1
#define GAG_TYPE  2
#define MUTE_TYPE 3
#define BAN_COMMAND  "voteban"
#define KICK_COMMAND "votekick"
#define GAG_COMMAND  "votegag"
#define MUTE_COMMAND "votemute"

enum Attributes {
	vote_for[4],
	current_type
}
int g_player[MAXPLAYERS+1][Attributes];
#include "gv_classes/class_clients.sp"
#include "gv_classes/class_counter.sp"
public void OnPluginStart() {
	LoadTranslations("gamevoting.txt");
}
public void OnClientPostAdminCheck(int client) {
	gv.reset_votes(client);
}
public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs)
{
	if(!player.valid(client)) return Plugin_Continue;
	if(sArgs[0] == '!' && sArgs[1] == 'v' && sArgs[2] == 'o' && sArgs[3] == 't' && sArgs[4] == 'e') CheckCommand(client, sArgs, "!");
	else if(sArgs[0] == '/' && sArgs[1] == 'v' && sArgs[2] == 'o' && sArgs[3] == 't' && sArgs[4] == 'e') CheckCommand(client, sArgs, "/");
	else if(sArgs[0] == 'v' && sArgs[1] == 'o' && sArgs[2] == 't' && sArgs[3] == 'e') CheckCommand(client, sArgs, "");
	return Plugin_Continue;
}
public void CheckCommand(int client, const char[] args, const char[] pref) {
	// !vote..? /vote..? vote..?
	char command[24];
	strcopy(command, sizeof(command), args);
	TrimString(command);
	if(strlen(pref) > 0) ReplaceString(command, sizeof(command), pref, "", true);
	if(StrEqual(command, BAN_COMMAND, false)) gv.show_menu(client,BAN_TYPE);
	else if(StrEqual(command, KICK_COMMAND, false)) gv.show_menu(client,KICK_TYPE);
	else if(StrEqual(command, GAG_COMMAND, false)) gv.show_menu(client,GAG_TYPE);
	else if(StrEqual(command, MUTE_COMMAND, false)) gv.show_menu(client,MUTE_TYPE);
}
public int menu_handler(Menu menu, MenuAction action, int client, int item) {
	if (action == MenuAction_Select) {
		char info[11];
		GetMenuItem(menu, item, info, sizeof(info));
		int victim = StringToInt(info);
		gv.vote_for_player(client, victim, g_player[client][current_type]);
	}
	else if (action == MenuAction_End) {
		CloseHandle(menu);
	}
}