ConVar ConVars[20];
public void register_ConVars() {
	ConVars[CONVAR_VERSION] = CreateConVar("sm_gamevoting_version", "1.8.2dev", "Version of gamevoting plugin. Author: Neatek, www.neatek.ru www.neatek.pw", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	ConVars[CONVAR_ENABLED] = CreateConVar("gamevoting_enable",	"1", "Enable or disable plugin (def:1)", _, true, 0.0, true, 1.0);	
	ConVars[CONVAR_BAN_DURATION] = CreateConVar("gamevoting_voteban_delay", "120", "Ban duration in minutes (def:120)", _, true, 0.0, false);
	AutoExecConfig(true, "Gamevoting");
}