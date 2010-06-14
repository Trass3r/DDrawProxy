/**
 *	
 */
module main;

import std.c.windows.com;
import std.c.windows.windows;
import core.dll_helper;
//import std.stdio;
import ddraw;
import myiddraw;
import logger;


alias const ref IID REFIID; 

extern(Windows) HMODULE LoadLibraryW(LPCWSTR libnameW);

extern(Windows) uint GetSystemDirectoryW(wchar* lpBuffer, uint uSize);
extern(Windows) uint GetSystemWow64DirectoryW(wchar* lpBuffer, uint uSize);

pragma(lib, "uuid");

__gshared HINSTANCE g_hInst;

extern (Windows)
BOOL DllMain(HINSTANCE hInstance, ULONG ulReason, LPVOID pvReserved)
{
	switch (ulReason)
	{
	case DLL_PROCESS_ATTACH:
		g_hInst = hInstance;
		// DisableThreadLibraryCalls(hInstance);
		dll_process_attach( hInstance, true ); // important to initialize first

		Logger.init("log.txt");
		loadOriginalDll();
		break;

	case DLL_PROCESS_DETACH:
		Logger.close();
		dll_process_detach( hInstance, true );
		break;

	case DLL_THREAD_ATTACH:
		dll_thread_attach( true, true );
		break;

	case DLL_THREAD_DETACH:
		dll_thread_detach( true, true );
		break;
	}
	return true;
}

__gshared HMODULE g_originalDDrawDll;
//extern(Windows) int MessageBoxW(HWND hWnd, const wchar* lpText, const wchar* lpCaption, uint uType);

/// search and load the original ddraw.dll in the system directory
void loadOriginalDll()
{
	Logger.addEntry("loadOriginalDll()");
	wchar[MAX_PATH] buffer = 0; // wchar.init strangefully isn't 0

	// Getting path to system dir and to ddraw.dll
	version(WOW64DLL)
		uint len = GetSystemWow64DirectoryW(&buffer[0], MAX_PATH);
	else
		uint len = GetSystemDirectoryW(&buffer[0], MAX_PATH);


	// Append dll name
	assert(len < MAX_PATH - 10);
	buffer[len .. len + 10] = r"\ddraw.dll"w;
	
	g_originalDDrawDll = LoadLibraryW(buffer.ptr);

	// Debug
	if (!g_originalDDrawDll)
		throw new Exception("Original ddraw.dll couldn't be loaded");

}

extern(Windows):
__gshared MyIDirectDraw g_myIDDraw;
__gshared MyIDirectDraw2 g_myIDDraw2;
__gshared MyIDirectDraw4 g_myIDDraw4;
__gshared MyIDirectDraw7 g_myIDDraw7;

/// An exported function (faking ddraw.dll's export)
export HRESULT DirectDrawCreateHook(GUID* lpGUID, LPDIRECTDRAW* lplpDD, IUnknown* pUnkOuter)
{
	Logger.addEntry("DDRAWPROXY: Exported function DirectDrawCreate reached.");
	
	alias extern(Windows) HRESULT function(GUID*, LPDIRECTDRAW*, IUnknown*) DirectDrawCreateFn;
	auto DirectDrawCreate = cast(DirectDrawCreateFn) GetProcAddress( g_originalDDrawDll, "DirectDrawCreate");
 
	HRESULT res;
	if((res = DirectDrawCreate(lpGUID, lplpDD, pUnkOuter)) == DD_OK)
	{
		g_myIDDraw = new MyIDirectDraw(lplpDD);
	}

	return res;
}

HRESULT DirectDrawCreateExHook(GUID* lpGuid, LPVOID* lplpDD, REFIID iid, IUnknown* pUnkOuter)
{
	alias extern(Windows) HRESULT function(GUID*, LPVOID*, REFIID, IUnknown*) DirectDrawCreateExFn;
	auto DirectDrawCreateEx = cast(DirectDrawCreateExFn) GetProcAddress( g_originalDDrawDll, "DirectDrawCreateEx");
	
	HRESULT res;
	if ((res = DirectDrawCreateEx(lpGuid, lplpDD, iid, pUnkOuter)) == DD_OK)
	{
		if (iid == IID_IDirectDraw)
			g_myIDDraw = new MyIDirectDraw(lplpDD);
		else if (iid == IID_IDirectDraw2)
			g_myIDDraw2 = new MyIDirectDraw2(lplpDD);
		else if (iid == IID_IDirectDraw4)
			g_myIDDraw4 = new MyIDirectDraw4(lplpDD);
		else if (iid == IID_IDirectDraw7)
			g_myIDDraw7 = new MyIDirectDraw7(lplpDD);
	}
	
	return res;
}