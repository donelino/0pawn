#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


main()
{}



public OnGameModeInit ()
{
	new level = 5;
	if (level == 1)
	{
		print("Level 1");
	}
	else if (level == 2)
	{
		print("Level 2");
	}
	else if (level == 3)
	{
		print("Level 3");
	}
	else if (level >= 4 && level <= 6)
	{
		print("Level >= 4 && Level <= 6");
	}
	else
	{
		print("Level Unknown");
	}


	switch (level)
	{
		case 1: // if (level == 1)
		{
			print("(switch) Level 1");
		}
		case 2: // if (level == 2)
		{
			print("(switch) Level 2");
		}
		case 3: // if (level == 3)
		{
			print("(switch) Level 3");
		}
		case 4..6:
		{
			print("(switch) Level >= 4 && Level <= 6");
		}
		default:
		{
			print("(switch) Level Unknown");
		}
	}

	new value = 0;
	while (value < 10)
	{
		printf("Value = %d", value);
		value++;
	}

	printf("Value after loop = %d", value);

	value = 10;
	do 
	{
		printf("Do while: %d", value);
		value++;
	} while (value < 10);


	for (new i = 0; i < 10; i+=2)
	{
		printf("i = %d", i);
	}


	







































	

	SetGameModeText("0Pawn by Don_Elino");
	ShowNameTags(1);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();

	AddPlayerClass(66,1569.976,-1243.9622,277.8773,270.0,0,0,0,0,-1,-1);
	return 1;
}

public OnPlayerConnect (playerid)
{
	return 1;
}

public OnPlayerRequestClass (playerid, classid)
{
	if (IsValidPVar(playerid, "PlayerLoginStarted"))
		return 0;

	if (IsValidPVar(playerid, "PlayerInGame"))
	{
		return SpawnPlayer(playerid);
	}

	SendClientMessage(playerid, 0xEAC700FF, " Добро пожаловать на курс {FF1100}0Pawn {EAC700}от {FF1100}Don_Elino{EAC700}!");

	SetPVarInt(playerid, "PlayerLoginStarted", 1);

	SetTimerEx(#SpawnPlayerTimeout, 100, false, "i", playerid);
	return 1;
}

forward SpawnPlayerTimeout (playerid);
public SpawnPlayerTimeout (playerid)
{
	DeletePVar(playerid, "PlayerLoginStarted");
	SetPVarInt(playerid, "PlayerInGame", 1);
	SpawnPlayer(playerid);
}

public OnPlayerRequestSpawn (playerid)
{
	if (!IsValidPVar(playerid, "PlayerInGame"))
	{
		SendClientMessage(playerid, 0xAFAFAFFF, " Нельзя самому спавниться, я сам тебя заспавню!");
		return 0;
	}
	return 1;
}

public OnPlayerSpawn (playerid)
{
	SetPlayerPos(playerid, 1154.1499,-1769.3466,16.5938);
	SetPlayerFacingAngle(playerid, 0.0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetCameraBehindPlayer(playerid);

	if (!IsValidPVar(playerid, "IsFirstSpawn"))
	{
		new str[128], nikname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, nikname, MAX_PLAYER_NAME);
		format(str, sizeof(str), "~w~Welcome~n~~b~%s", nikname);
		GameTextForPlayer(playerid, str, 5000, 1);

		SetPVarInt(playerid, "IsFirstSpawn", 1);
	}
	return 1;
}


stock IsValidPVar (playerid, varname[])
{
	return (GetPVarType(playerid, varname) != PLAYER_VARTYPE_NONE);
}