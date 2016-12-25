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
		if(!player.valid(client) || !player.valid(victim)) return false;
		g_player[client][vote_for][itype] = victim;
		int needle_votes = this.get_needle_votes(itype);
		int cur_votes = this.get_count_votes(victim,itype);
		char name1[32],name2[32];
		GetClientName(client, name1, sizeof(name1));
		GetClientName(victim, name2, sizeof(name2));
		switch(itype) {
			case BAN_TYPE:  {
				//PrintToChatAll("Player %N voted for ban %N (%d/%d)", client, victim, cur_votes,needle_votes);
				PrintToChatAll("%t", "player_vote_for_ban", name1, name2, cur_votes, needle_votes);
			}
			case KICK_TYPE: {
				//PrintToChatAll("Player %N voted for kick %N (%d/%d)", client, victim, cur_votes,needle_votes);
				PrintToChatAll("%t", "player_vote_for_kick", name1, name2, cur_votes, needle_votes);
			}
			case GAG_TYPE:  {
				//PrintToChatAll("Player %N voted for gag %N (%d/%d)", name1, name2, cur_votes,needle_votes);
				PrintToChatAll("%t", "player_vote_for_mute", name1, name2, cur_votes, needle_votes);
			}
			case MUTE_TYPE: {
				//PrintToChatAll("Player %N voted for mute %N (%d/%d)", name1, name2, cur_votes,needle_votes);
				PrintToChatAll("%t", "player_vote_for_gag", name1, name2, cur_votes, needle_votes);
			}
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