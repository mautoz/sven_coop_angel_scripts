void MapInit()
{
    g_EngineFuncs.ServerPrint("Script is running!\n"); // Prints to server console
    g_EngineFuncs.CVarSetFloat("sv_gravity", 400); // Set lower gravity

    g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @PlayerSpawn); // Hook to remove weapons on spawn
    g_Hooks.RegisterHook(Hooks::Player::ClientSay, @ClientSay); // Hook for chat commands
}

// Function to handle player spawn (jump boost & remove weapons)
HookReturnCode PlayerSpawn(CBasePlayer@ pPlayer)
{
    if (pPlayer is null || !pPlayer.IsConnected()) 
        return HOOK_CONTINUE;

    pPlayer.RemoveAllItems(false); // Remove all weapons including medkit

    return HOOK_CONTINUE;
}

// Dictionary to store saved teleport positions
dictionary g_TeleportPositions;

// Function to handle chat commands
HookReturnCode ClientSay(SayParameters@ pParams)
{
    CBasePlayer@ pPlayer = pParams.GetPlayer();

    string message = pParams.GetCommand(); // Get the chat message
    message.ToLowercase(); // Make it case-insensitive

    if (message == "/s") // Save position
    {
        g_TeleportPositions[pPlayer.entindex()] = pPlayer.pev.origin;
        g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTTALK, "Your position was saved!\n");
        return HOOK_HANDLED;
    }
    else if (message == "/t") // Teleport
    {
        if (g_TeleportPositions.exists(pPlayer.entindex()))
        {
            Vector savedPos;
            g_TeleportPositions.get(pPlayer.entindex(), savedPos);
            pPlayer.SetOrigin(savedPos);
            g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTTALK, "Teleport successful!\n");
        }
        else
        {
            g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTTALK, "No position saved! Use /s first.\n");
        }
        return HOOK_HANDLED;
    }

    return HOOK_CONTINUE;
}
