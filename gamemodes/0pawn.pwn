#include "a_samp.inc"
#include "core.inc"
#include "streamer.inc"


main()
{}



public OnGameModeInit ()
{
	// Логическая переменная (всего два значения)
	new bool:isLocked = true; // true / false
	new bool:isAdmin = false;

	/*
	
	>    больше
	>=   больше или равно
	<    меньше
	<=   меньше или равно
	==   сравнение переменных
	!=   не равно

	*/

	new money = 1_000_000;

	if (money != 10000)
	{
		//
	}

	if (isAdmin)
	{
		print("Admin");
	}
	else
	{
		print("Not Admin");
	}

	// isAdmin == false
	// !isAdmin
	if (!isAdmin)
	{

	}
	
	/*
		
	И - &&
	ИЛИ - ||

	*/


	if (isAdmin && isLocked)
	{
		print("You are admin and vehicle is locked");
	}

	if (isAdmin || isLocked)
	{

	}


	new price = 1_000_000;

	if (!isLocked || (!isAdmin && money >= price))
	{
		print("Поздравляю! Машина твоя!");
	}
	else
	{
		print("Тебе нельзя купить машину!");
	}


	// Домашнее задание:

	// 1. Вывести текст "Машин достаточно", если их больше 50
	new vehicles = 100;

	// 2. Вывести текст "Вы не можете написать в репорт", если администрации нет онлайн или репортов больше или равно 10
	// Вывести текст "Репорт отправлен" в ином случае
	new adminsOnline = 8;
	new reports = 10;

	// 3.* Вывести текст "Чётное", если число чётное, "Не чётное", если не чётное
	// Подсказка: Нужно придумать какие числа являются чётными, какие нет, и написать корректное условие
	new value = 10;
	new value2 = 11;
	


























	

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