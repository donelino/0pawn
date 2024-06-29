#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


main()
{}



public OnGameModeInit ()
{
	// Целочисленые
	new money = 100_000; // 100000

	// С плавающей точкой
	new Float:hp = 50.5;

	// Логическая переменная (всего два значения)
	new bool:isLocked = true; // true / false
	new bool:isAdmin = false;

	/*

	Для целочисленых - %d / %i
	Плавающая точка - %f
	Строка - %s
	Одна буква - %c

	*/
	printf("Money: %d", money);

	printf("HP: %f", hp);

	printf("isLocked: %d", isLocked);
	printf("isAdmin: %d", isAdmin);

	new vehicles[3];
	vehicles[0] = 50;
	vehicles[1] = 100;

	printf("Index 0: %d, Index 1: %d, Index 2: %d", vehicles[0], vehicles[1], vehicles[2]);
	// A - 65, B - 66, C - 67... H - 72
	// "Hello, World!"

	new string[10] = "Hello!";

	print(string);
	printf("Value: %d", string[0]);
	printf("Value: %c", string[0]);

	printf("Text: %s", string);











	

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