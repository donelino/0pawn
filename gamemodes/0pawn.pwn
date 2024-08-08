#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


#define CALLBACK%0(%1) \
	forward%0(%1); public%0(%1)


main()
{}


enum pInfo
{
	pNikname[32],
	pLevel,
	pCash,
	Float:pHP,
};


public OnGameModeInit ()
{
	new player[pInfo] = {
		"Don_Elino",
		10,
		10_000_000,
		100.0
	};


	printf("Nikaname = %s, Level = %d, Cash = %d, HP = %f", player[pNikname], player[pLevel], player[pCash], player[pHP]);


	/*
		Домашнее задание:
		Создать структуру данных farm со значениями:
		- fOwner (ник владельца)
		- fProds (кол-во продуктов)
		- fEnterX (Координаты входа: x (с плавающей точкой))
		- fEnterY (Координаты входа: y (с плавающей точкой))
		- fEnterZ (Координаты входа: z (с плавающей точкой))

		Вывести эти данные через 5 секунд после запуска игрового мода
	*/
























	

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