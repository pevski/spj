#include <sourcemod>
#include <DynamicChannels>
#include <shavit>

bool g_bEnabled[MAXPLAYERS + 1]

#define PLUGIN_VERSION "1.00"

public Plugin myinfo = 
{
	name = "spj", 
	author = "pev, also s/o my nigga log-ical", 
	description = "shows spj in float", 
	version = PLUGIN_VERSION, 
	url = "/pevlindir/"
}

public void OnPluginStart()
{
	RegConsoleCmd("sm_spj", Command);
}

public Action Command(int client, int args)
{
	if (!client)
	{
		ReplyToCommand(client, "This command cannot be used in server console. If you are in-game please make sure you are on a dedicated server.");
		return Plugin_Handled;
	}
	
	g_bEnabled[client] = !g_bEnabled[client];
	return Plugin_Handled;
}

public void OnClientPutInServer(int client)
{
	if (!IsFakeClient(client))
	{
		g_bEnabled[client] = false;
	}
}

public Action OnPlayerRunCmd(int client)
{
	float fClientJumps = float(Shavit_GetClientJumps(client));
	
	if (g_bEnabled[client])
	{
		if (fClientJumps > 0.0)
		{
			float fClientStrafes = float(Shavit_GetStrafeCount(client));
			float fJumpsOverStrafes = fClientStrafes / fClientJumps;
			SetHudTextParams(-1.0, -1.0, 1.0, 255, 255, 255, 255);
			ShowHudText(client, 1, "%0.2f", fJumpsOverStrafes);
		}
	}
} 
