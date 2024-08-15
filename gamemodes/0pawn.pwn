#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


#define CALLBACK%0(%1) \
	forward%0(%1); public%0(%1)


main()
{}


/*
	Координаты (x, y, z),
	Остаток
	Доступен
	ИД Игрока
*/

#define MAX_BUSHES 5

enum Bush
{
	Float:Bush_x,
	Float:Bush_y,
	Float:Bush_z,
	Bush_remaining,
	bool:Bush_available,
	Bush_playerid,
};

new bushes[10][Bush] =
{
	// X    Y     Z     remaining,  available, playerid   
	{ 1.0,  1.0,  10.0, MAX_BUSHES, false,     -1 },
	{ 2.0,  2.0,  10.0, MAX_BUSHES, true,      -1 },
	{ 3.0,  3.0,  10.0, MAX_BUSHES, false,     -1 },
	{ 4.0,  4.0,  10.0, MAX_BUSHES, false,     -1 },
	{ 5.0,  5.0,  10.0, MAX_BUSHES, true,      -1 },
	{ 6.0,  6.0,  10.0, MAX_BUSHES, false,     -1 },
	{ 7.0,  7.0,  10.0, MAX_BUSHES, true,      -1 },
	{ 8.0,  8.0,  10.0, MAX_BUSHES, false,     -1 },
	{ 9.0,  9.0,  10.0, MAX_BUSHES, true,      -1 },
	{ 10.0, 10.0, 10.0, MAX_BUSHES, true,      -1 }
};


stock GenerateBush (playerid)
{
	if (!HasAvailableBushes())
	{
		print("No bushes available!");
		return;
	}

	new bushid = -1;
	do 
	{
		bushid = random(sizeof(bushes));
	} while(bushes[bushid][Bush_available] == false || bushes[bushid][Bush_playerid] != -1);

	bushes[bushid][Bush_playerid] = playerid;
	PrintBush(bushid);
}

stock HasAvailableBushes ()
{
	for (new i = 0; i < sizeof(bushes); i++)
	{
		if (bushes[i][Bush_available] && bushes[i][Bush_playerid] == -1)
			return true;
		
	}
	return false;
}

stock PrintBush (id)
{
	printf("Bush %d. Remainig: %d, Available: %d, PlayerId: %d", id, bushes[id][Bush_remaining], bushes[id][Bush_available], bushes[id][Bush_playerid]);
}




public OnGameModeInit ()
{
	GenerateBush(0);
	GenerateBush(1);
	GenerateBush(2);
	GenerateBush(3);
	GenerateBush(4);
	GenerateBush(5);


	print(" ");
	print(" ");
	for (new i = 0; i < sizeof(bushes); i++)
	{
		PrintBush(i);
	}


	/*
		Домашнее задание
		Дополнить код из этого урока:
		Дописать очистку всех игроков каждую минуту с выводом в лог (print)

		Дополнительно*
		Генерировать 5 новых доступных кустов 
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