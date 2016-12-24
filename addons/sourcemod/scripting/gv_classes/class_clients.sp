/*
	Neatek Shop Client Class
*/
methodmap ClientsClass
{
	public bool valid(int client) {
		if(client > 4096) client = EntRefToEntIndex(client);
		if(client < 1 || client > MaxClients) return false;
		if(!IsClientConnected(client)) return false;
		if(!IsClientInGame(client)) return false;
		return true;
	}
	public bool isadmin(int client) {
		if(GetUserAdmin(client) != INVALID_ADMIN_ID)
			return true;
		return false;
	}
}
ClientsClass player;