#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


main()
{}



public OnGameModeInit ()
{
	new x = 1; // Присваивание переменной x значения 1
	new y = 5; // Присваивание переменной y значения 5

	new a = x + y; // В результате сложения в перменной a будет 6
	
	printf("Значение переменной X = %d, а переменной Y = %d", x, y);

	printf("Сумма значений = %d", a);

	a = 5;

	printf("Новое значение = %d", a);

	a = x - y;

	printf("Разница значений = %d", a);

	x = 2;
	y = 4;

	a = x * y; // 8
	printf("a = %d", a);

	a = y / x;

	printf("a = %d", a);

	x = 10;
	y = 3;

	a = x % y; // 1
	printf("Остаток: %d", a);

	// x = x + 1;
	x++; // 11


	// y = y - 1;
	y--; // 2

	













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

	SendClientMessage(playerid, 0xEAC700FF, " ??? ????? ? ?? {FF1100}0Pawn {EAC700}? {FF1100}Don_Elino{EAC700}!");

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
		SendClientMessage(playerid, 0xAFAFAFFF, " ??? ??? ?????, ? ?? ?? ????!");
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