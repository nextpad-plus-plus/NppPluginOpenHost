/*
 * NppPluginOpenHost for Notepad++ macOS
 * Ported from NppPluginOpenHost by jejemorg
 *
 * Original: https://github.com/jejemorg/NppPluginOpenHost
 * License: Apache License 2.0
 *
 * Opens the system hosts file in a new Notepad++ tab via NPPM_DOOPEN.
 * Windows original opens C:\Windows\system32\drivers\etc\hosts;
 * on macOS the equivalent is /etc/hosts.
 */

#include "NppPluginInterfaceMac.h"
#include "Scintilla.h"
#import <Cocoa/Cocoa.h>
#include <cstring>

// ── Plugin state ────────────────────────────────────────────────────────

static const char *PLUGIN_NAME = "Open Host file";
static const int NB_FUNC = 1;
static FuncItem funcItem[NB_FUNC];
static NppData nppData;

// macOS hosts file path
static const char *HOSTS_FILE_PATH = "/etc/hosts";

// ── Forward declarations ────────────────────────────────────────────────

static void openHostsFile();

// ── Helpers ─────────────────────────────────────────────────────────────

static intptr_t npp(uint32_t msg, uintptr_t w = 0, intptr_t l = 0)
{
    return nppData._sendMessage(nppData._nppHandle, msg, w, l);
}

// ── Commands ────────────────────────────────────────────────────────────

static void openHostsFile()
{
    // Use NPPM_DOOPEN to open the hosts file in a new tab
    npp(NPPM_DOOPEN, 0, (intptr_t)HOSTS_FILE_PATH);
}

// ── Plugin exports ──────────────────────────────────────────────────────

extern "C" NPP_EXPORT void setInfo(NppData data)
{
    nppData = data;

    strlcpy(funcItem[0]._itemName, "Open", NPP_MENU_ITEM_SIZE);
    funcItem[0]._pFunc = openHostsFile;
    funcItem[0]._init2Check = false;
    funcItem[0]._pShKey = nullptr;
}

extern "C" NPP_EXPORT const char *getName()
{
    return PLUGIN_NAME;
}

extern "C" NPP_EXPORT FuncItem *getFuncsArray(int *nbF)
{
    *nbF = NB_FUNC;
    return funcItem;
}

extern "C" NPP_EXPORT void beNotified(SCNotification *notifyCode)
{
    switch (notifyCode->nmhdr.code) {
        case NPPN_SHUTDOWN:
            break;
        default:
            break;
    }
}

extern "C" NPP_EXPORT intptr_t messageProc(uint32_t, uintptr_t, intptr_t)
{
    return 1;
}
