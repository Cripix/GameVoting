methodmap GameVoting
{
	public void show_menu(int client, int itype) {
		g_player[client][current_type] = itype;

		#if defined PLUGIN_DEBUG
			PrintToChatAll("Inited menu for client - %N [#%d]", client, itype);
		#endif

		Menu mymenu = new Menu(menu_handler);
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

	public int get_needle_votes(int itype) {
		return 10;
	}

	public bool vote_for_player(int client, int victim, int itype) {
		g_player[client][vote_for][itype] = victim;
		switch(itype) {
			case BAN_TYPE:  PrintToChatAll("Player %N voted for ban %N (%d/%d)", client, victim, this.get_count_votes(victim,BAN_TYPE),this.get_needle_votes(BAN_TYPE));
			case KICK_TYPE: PrintToChatAll("Player %N voted for kick %N (%d/%d)", client, victim, this.get_count_votes(victim,KICK_TYPE),this.get_needle_votes(KICK_TYPE));
			case GAG_TYPE:  PrintToChatAll("Player %N voted for gag %N (%d/%d)", client, victim, this.get_count_votes(victim,GAG_TYPE),this.get_needle_votes(GAG_TYPE));
			case MUTE_TYPE: PrintToChatAll("Player %N voted for mute %N (%d/%d)", client, victim, this.get_count_votes(victim,MUTE_TYPE),this.get_needle_votes(MUTE_TYPE));
		}
		return true;
	}

	public void reset_votes(int client) {
		for(int i=0;i<4;i++) {
			g_player[client][vote_for][i] = 0;
		}
	}
}

GameVoting gv;