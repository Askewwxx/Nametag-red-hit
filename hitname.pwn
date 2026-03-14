#include <a_samp>
#include <YSI_Coding\y_hooks>

new HitFlash[MAX_PLAYERS];
new OldColor[MAX_PLAYERS];
new HitTimer[MAX_PLAYERS];

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(!IsPlayerConnected(playerid))
        return 1;

    // Simpan warna asli kalau belum dalam mode flash
    if(!HitFlash[playerid])
    {
        OldColor[playerid] = GetPlayerColor(playerid);
        HitFlash[playerid] = 1;
    }

    // Set warna merah
    SetPlayerColor(playerid, 0xE65555FF);
    RefreshNametag(playerid);

    // Kill timer lama kalau ada
    if(HitTimer[playerid])
        KillTimer(HitTimer[playerid]);

    HitTimer[playerid] = SetTimerEx("ResetHitColor", 300, false, "i", playerid);

    return 1;
}

forward ResetHitColor(playerid);
public ResetHitColor(playerid)
{
    if(!IsPlayerConnected(playerid))
        return 1;

    SetPlayerColor(playerid, OldColor[playerid]);
    RefreshNametag(playerid);

    HitFlash[playerid] = 0;
    HitTimer[playerid] = 0;

    return 1;
}