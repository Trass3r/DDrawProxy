/**
 *	
 */
module myipalette;

import ddraw;

import logger;

class MyIDirectDrawPalette : IDirectDrawPalette
{
private:
	IDirectDrawPalette _lpDDP;

public:
	this(LPDIRECTDRAWPALETTE* lplpDDP)
	{
		_lpDDP = cast(IDirectDrawPalette) *lplpDDP; // save the interface as a member
		*lplpDDP = cast(IDirectDrawPalette) this; // alter the given pointer to this class instance
		// it's crucial to cast to the base interface here
	}

extern(Windows):

	/// 
	override HRESULT QueryInterface(REFIID riid, LPVOID* ppvObj)
	{
		Logger.addEntry("MyIDirectDrawPalette.QueryInterface(", riid, ")");

		return _lpDDP.QueryInterface(riid, ppvObj);
	}

	/// 
	override ULONG AddRef()
	{
		Logger.addEntry("MyIDirectDrawPalette.AddRef()");
		return _lpDDP.AddRef();
	}
	
	/// 
	override ULONG Release()
	{
		Logger.addEntry("MyIDirectDrawPalette.Release()");
		return _lpDDP.Release();
	}
	
	/// This method retrieves the capabilities of this palette object
	override DDRESULT GetCaps(LPDWORD lpdwCaps)
	{
		auto res = _lpDDP.GetCaps(lpdwCaps);
		Logger.addEntry("MyIDirectDrawPalette.GetCaps(", lpdwCaps, ")");
		return res;
	}
	
	///
	override DDRESULT GetEntries(DWORD dwFlags, DWORD dwBase, DWORD dwNumEntries, LPPALETTEENTRY lpEntries )
	{
		Logger.addEntry("MyIDirectDrawPalette.GetEntries(", dwFlags, dwBase, dwNumEntries, ")");
		return _lpDDP.GetEntries(dwFlags, dwBase, dwNumEntries, lpEntries);
	}
	
	///
	override DDRESULT Initialize(LPDIRECTDRAW lpDD, DWORD dwFlags, LPPALETTEENTRY lpDDColorTable)
	{
		Logger.addEntry("MyIDirectDrawPalette.Initialize(", dwFlags, ")");
		return _lpDDP.Initialize(lpDD, dwFlags, lpDDColorTable);
	}
	
	///
	override DDRESULT SetEntries(DWORD dwFlags, DWORD dwStartingEntry, DWORD dwCount, LPPALETTEENTRY lpEntries)
	{
		Logger.addEntry("MyIDirectDrawPalette.SetEntries(", dwFlags, dwStartingEntry, dwCount, ")");
		return _lpDDP.SetEntries(dwFlags, dwStartingEntry, dwCount, lpEntries);
	}
}