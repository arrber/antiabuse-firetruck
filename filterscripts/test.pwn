#include <YSI_Coding\y_hooks>
#include <YSI_Data\y_foreach>

#include <camera>

public OnFilterScriptInit()
{
    print("Firetruck anti abuse script started!");
}

CMD:vcfiretruck(playerid, params[])
{
    new
        veh,
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:Angle
	;
	GetPlayerPos( playerid, X, Y, Z );
    GetPlayerFacingAngle(playerid, Angle);

    veh = CreateVehicle(407, x, y, z, angle, -1, -1, 0, 0);

    PutPlayerInVehicle(playerid, veh, 0);

	return 1;
}

public OnPlayerUpdate(playerid)
{
	static
		iKeys, iLeftRight;
    
	GetPlayerKeys( playerid, iKeys, tmpVariable, iLeftRight );

	if ((iKeys & KEY_FIRE))
	{
		new
			using_firetruck = GetVehicleModel(GetPlayerVehicleID(playerid)) == 407;

		if (using_firetruck)
		{
		    static
				Float: iX, Float: iY, Float: iZ;

			foreach (new i : Player)
		    {
				GetPlayerPos(i, iX, iY, iZ);

				if ( IsPlayerInRangeOfPoint(playerid, 25, iX, iY, iZ ) && IsPlayerAimingAt( playerid, iX, iY, iZ, 1 ) )
				{
					SendClientMessage(playerid, -1, "[CAUTION]You've been detected by using a firetruck to water someone. This is forbidden! Stop doing it!");

					RemovePlayerFromVehicle(playerid);

					break;
				}
			}
		}
	}
	return 1;
}