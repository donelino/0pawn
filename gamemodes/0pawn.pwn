#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


main()
{}


GetArea (width, height)
{
	if (width < 0 || height < 0)
	{
		return 0;
	}

	new area = width * height;
	return area;
}

IsEven (value)
{
	/*
		Задание: Определить, является ли значение value чётным
		Вернуть: Если чётное -   1
		         Если нечётное - 0
	*/
    return 1;
}

public OnGameModeInit ()
{
	new area1 = GetArea(5, 10);
	new area2 = GetArea(7, 12);
	new area3 = GetArea(8, 14);
	new area4 = GetArea(-8, 12);

	printf("Area1 = %d", area1);
	printf("Area2 = %d", area2);
	printf("Area3 = %d", area3);
	printf("Area4 = %d", area4);

	for (new i = 0; i < 10; i++)
	{
		if (i == 3)
			break;

		print("a");
	}

	/*
		Домашнее задание
	*/

	new value = 10;
	printf("Число %d является %s", value, IsEven(value) ? ("чётным") : ("нечётным"));
	value = 21;
	printf("Число %d является %s", value, IsEven(value) ? ("чётным") : ("нечётным"));
	value = 0;
	printf("Число %d является %s", value, IsEven(value) ? ("чётным") : ("нечётным"));






























	

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