methodmap GameVoting
{
	public void show_menu(int client, int itype) {
		g_player[client][current_type] = itype;

		#if defined PLUGIN_DEBUG
			PrintToChatAll("Inited menu for client - %N [#%d]", client, itype);
		#endif

		Menu mymenu = new Menu(menu_handler);
		mymenu.SetTitle(PLUGIN_TAG);
		char Name[48], id[11];
		for(int i=0;i<GetMaxClients();i++) {
			if(player.valid(i)) {
				IntToString(i, id, sizeof(id));
				FormatEx(Name,sizeof(Name),"%N",i);
				mymenu.AddItem(id,Name);
			}
		}
		mymenu.Display(client, 30);
	}

	public int get_count_votes(int client, int itype) {
		int count = 0;
		for(int i=0;i<GetMaxClients();i++) {
			if(player.valid(i) && g_player[i][vote_for][itype] == client) count++;
		}
		return count;
	}

	public int get_cur_players() {
		int num = 0;
		for(int i=0;i<GetMaxClients();i++) 
			if(player.valid(i)) num++;
		return num;
	}

	public int get_needle_votes(int itype) {
		int percent = 75;
		return (percent*this.get_cur_players())/100;
	}

	public int reset_votes_for_player(int client) {
		for(int i=0;i<GetMaxClients();i++) {
			if(player.valid(i)) {
				if(g_player[i][vote_for][BAN_TYPE] == client) g_player[i][vote_for][BAN_TYPE] = 0;
				if(g_player[i][vote_for][KICK_TYPE] == client) g_player[i][vote_for][KICK_TYPE] = 0;
				if(g_player[i][vote_for][GAG_TYPE] == client) g_player[i][vote_for][GAG_TYPE] = 0;
				if(g_player[i][vote_for][MUTE_TYPE] == client) g_player[i][vote_for][MUTE_TYPE] = 0;
			}
		}
	}

	public void do_Vacation(int itype, int client) {
		if(!player.valid(client)) return;
		switch(itype) {
			case BAN_TYPE: {
				this.reset_votes_for_player(client);
				if(client > 0) {
					ServerCommand("sm_ban #%d %d \"Gamevoting\"", GetClientUserId(client), ConVars[CONVAR_BAN_DURATION].IntValue);
				} else {
					ServerCommand("sm_ban #%d %d \"Gamevoting\"", GetClientUserId(client), ConVars[CONVAR_BAN_DURATION].IntValue);
				}
				PrintToChatAll("Player %N was banned by GameVoting.", client);
			}
			case KICK_TYPE: {
				KickClient(client, "Kicked by GameVoting");
			}
			case GAG_TYPE: {
				
			}
			case MUTE_TYPE: {
				
			}
		}
	}

	public bool vote_for_player(int client, int victim, int itype) {
		if(!player.valid(client) || !player.valid(victim)) return false;
		g_player[client][vote_for][itype] = victim;
		int needle_votes = this.get_needle_votes(itype);
		int cur_votes = this.get_count_votes(victim,itype);
		char name1[32],name2[32];
		GetClientName(client, name1, sizeof(name1));
		GetClientName(victim, name2, sizeof(name2));
		switch(itype) {
			case BAN_TYPE: PrintToChatAll("%t", "player_vote_for_ban", name1, name2, cur_votes, needle_votes);
			case KICK_TYPE: PrintToChatAll("%t", "player_vote_for_kick", name1, name2, cur_votes, needle_votes);
			case GAG_TYPE: PrintToChatAll("%t", "player_vote_for_mute", name1, name2, cur_votes, needle_votes);
			case MUTE_TYPE: PrintToChatAll("%t", "player_vote_for_gag", name1, name2, cur_votes, needle_votes);
		}
		if(cur_votes >= needle_votes) this.do_Vacation(itype, victim);
		return true;
	}

	public void reset_votes(int client) {
		for(int i=0;i<4;i++) {
			g_player[client][vote_for][i] = 0;
		}
	}
}

GameVoting gv;