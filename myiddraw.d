/**
 *	
 */
module myiddraw;

import ddraw;

import logger;
import std.conv;

import myiddrawsurface;
import myipalette;

__gshared HWND g_hWnd;
__gshared MyIDirectDrawSurface[] g_mySurfaces;
__gshared MyIDirectDrawPalette[] g_myPalettes;

alias MyIDirectDrawB!(1) MyIDirectDraw; ///
alias MyIDirectDrawB!(2) MyIDirectDraw2; ///
alias MyIDirectDrawB!(4) MyIDirectDraw4; ///
alias MyIDirectDrawB!(7) MyIDirectDraw7; ///

class MyIDirectDrawB(uint ver) : IDirectDrawB!(ver)
{
private:
	static if (ver < 4)
		alias LPDDSCAPS LPProperDDSCaps;
	else
		alias LPDDSCAPS2 LPProperDDSCaps;
	
	static if (ver < 4)
		alias LPDDSURFACEDESC LPProperSurfaceDesc;
	else
		alias LPDDSURFACEDESC2 LPProperSurfaceDesc;

	static if (ver < 4)
		alias LPDDENUMSURFACESCALLBACK LPProperDDEnumSurfacesCallback;
	else static if (ver < 7)
		alias LPDDENUMSURFACESCALLBACK2 LPProperDDEnumSurfacesCallback;
	else
		alias LPDDENUMSURFACESCALLBACK7 LPProperDDEnumSurfacesCallback;
	
	static if (ver < 2)
		alias LPDDENUMMODESCALLBACK LPProperDDEnumModesCallback;
	else
		alias LPDDENUMMODESCALLBACK2 LPProperDDEnumModesCallback;

	static if (ver < 2)
		alias LPDIRECTDRAWSURFACE LPProperDirectDrawSurface;
//	else static if (ver < 4)
//		alias LPDIRECTDRAWSURFACE2 LPProperDirectDrawSurface;
	else static if (ver < 7)
		alias LPDIRECTDRAWSURFACE4 LPProperDirectDrawSurface;
	else
		alias LPDIRECTDRAWSURFACE7 LPProperDirectDrawSurface;

	static if (ver < 7)
		alias LPDDDEVICEIDENTIFIER LPProperDDDeviceIdentifier;
	else
		alias LPDDDEVICEIDENTIFIER2 LPProperDDDeviceIdentifier;


	alias IDirectDrawB!(ver) BaseInterface;
	BaseInterface _lpDD;

public:
	this(void** lplpDD)
	{
		Logger.addEntry("MyIDirectDraw created");
		_lpDD = cast(BaseInterface) *lplpDD; // save the interface as a member
		*lplpDD = cast(void*) cast(BaseInterface) this; // alter the given pointer to this class instance
		// it's crucial to cast to the base interface here
	}
extern(Windows):
	
	/// 
	override HRESULT QueryInterface(REFIID riid, LPVOID* ppvObj)
	{
		Logger.addEntry("MyIDirectDraw.QueryInterface(", riid, ")");

		/+
		HRESULT hResult;

		if((hResult = _lpDD.QueryInterface(riid, ppvObj)) == S_OK)
		{
			if(*riid == IID_IDirectDraw4)
			{
				MyIDirectDraw4 lpDD = new MyIDirectDraw4(cast(void**) ppvObj);
				ppvObj = cast(LPVOID*) lpDD;
			}
		}
		
		return hResult;
		+/
		return _lpDD.QueryInterface(riid, ppvObj);
	}

	/// 
	override ULONG AddRef()
	{
		auto res = _lpDD.AddRef();
		Logger.addEntry("MyIDirectDraw.AddRef() = ", res);
		return res;
	}
	
	/// 
	override ULONG Release()
	{
		auto res = _lpDD.Release();
		Logger.addEntry("MyIDirectDraw.Release() = ", res);
		return res;
	}
	
	/// 
	override DDRESULT Compact()
	{
		auto res = _lpDD.Compact();
		Logger.addEntry("MyIDirectDraw.Compact() = ", res);
		return res;
	}
	
	/// 
	override DDRESULT CreateClipper(DWORD dwFlags, LPDIRECTDRAWCLIPPER* lplpDDClipper, IUnknown* pUnkOuter)
	{
		auto res = _lpDD.CreateClipper(dwFlags, lplpDDClipper, pUnkOuter);
		Logger.addEntry("MyIDirectDraw.CreateClipper(", dwFlags, lplpDDClipper, ") = ", res);
		return res;
	}
	
	/// 
	override DDRESULT CreatePalette(DWORD dwFlags, LPPALETTEENTRY lpColorTable, LPDIRECTDRAWPALETTE* lplpDDPalette, IUnknown* pUnkOuter)
	{
		DDRESULT res;
		if ((res = _lpDD.CreatePalette(dwFlags, lpColorTable, lplpDDPalette, pUnkOuter)) == DD_OK)
//			g_myPalettes ~= new MyIDirectDrawPalette(lplpDDPalette);
		{}
		Logger.addEntry("MyIDirectDraw.CreatePalette(", dwFlags, lplpDDPalette, ") = ", res);
		return res;
	}
	
	/// 
	override DDRESULT CreateSurface(LPProperSurfaceDesc lpDDSurfaceDesc, LPProperDirectDrawSurface* lplpDDSurface, IUnknown* pUnkOuter)
	{
		DDRESULT res;
		version(forceWindowed)
		{
			// original primary surface .dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT
			if (lpDDSurfaceDesc.dwFlags & DDSD_BACKBUFFERCOUNT)
			{
				lpDDSurfaceDesc.dwFlags = DDSD_CAPS;
				lpDDSurfaceDesc.dwWidth = 640;
				lpDDSurfaceDesc.dwHeight = 480;
				lpDDSurfaceDesc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
			}
			
			// rest of the surfaces has .dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS
			// video surfaces ? dwCaps = DDSCAPS_TEXTURE | DDSCAPS_OWNDC | DDSCAPS_LIVEVIDEO | DDSCAPS_HWCODEC | DDSCAPS_MODEX
			// normal sprites: DDSCAPS_COMPLEX | DDSCAPS_ALPHA | DDSCAPS_RESERVED1 | DDSCAPS_FLIP | DDSCAPS_FRONTBUFFER | DDSCAPS_OFFSCREENPLAIN | DDSCAPS_PALETTE | DDSCAPS_PRIMARYSURFACE | DDSCAPS_RESERVED3 | DDSCAPS_VIDEOMEMORY | 
		}
		version(NoSurfaceHooking)
			res = _lpDD.CreateSurface(lpDDSurfaceDesc, lplpDDSurface, pUnkOuter);
		else
		{
			if((res = _lpDD.CreateSurface(lpDDSurfaceDesc, lplpDDSurface, pUnkOuter)) == DD_OK)
			{
				Logger.addEntry("original surface looks like ", (cast(ubyte*) *cast(IDirectDrawSurface*)lplpDDSurface)[0 .. IDirectDrawSurface.sizeof]);
				g_mySurfaces ~= new MyIDirectDrawSurface(lplpDDSurface);
				Logger.addEntry("my surface looks like ", (cast(ubyte*) *cast(IDirectDrawSurface*)lplpDDSurface)[0 .. IDirectDrawSurface.sizeof]);
			}
		}
		Logger.addEntry("MyIDirectDraw.CreateSurface(", lplpDDSurface, lpDDSurfaceDesc, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT DuplicateSurface(LPProperDirectDrawSurface lpDDSurface, LPProperDirectDrawSurface* lplpDupDDSurface)
	{
		auto res = _lpDD.DuplicateSurface(lpDDSurface, lplpDupDDSurface);
		Logger.addEntry("MyIDirectDraw.DuplicateSurface(" ~ "" ~ ") = ", res);
		return res;
	}

	/// 
	override DDRESULT EnumDisplayModes(DWORD dwFlags, LPProperSurfaceDesc lpDDSurfaceDesc, LPVOID lpContext, LPProperDDEnumModesCallback lpEnumCallback)
	{
		auto res = _lpDD.EnumDisplayModes(dwFlags, lpDDSurfaceDesc, lpContext, lpEnumCallback);
		Logger.addEntry("MyIDirectDraw.EnumDisplayModes(", dwFlags, ") = ", res);
		return res;
	}
	/// 
	override DDRESULT EnumSurfaces(DWORD dwFlags, LPProperSurfaceDesc lpddsd, LPVOID lpContext, LPProperDDEnumSurfacesCallback lpEnumCallback)
	{
		auto res = _lpDD.EnumSurfaces(dwFlags, lpddsd, lpContext, lpEnumCallback);
		Logger.addEntry("MyIDirectDraw.EnumSurfaces(", dwFlags, lpddsd, ") = ", res);
		return res;
	}
	/// 
	override DDRESULT FlipToGDISurface()
	{
		auto res = _lpDD.FlipToGDISurface();
		Logger.addEntry("MyIDirectDraw.FlipToGDISurface() = ", res);
		return res;
	}
	/// 
	override DDRESULT GetCaps(LPDDCAPS lpDDDriverCaps, LPDDCAPS lpDDHELCaps)
	{
		auto res = _lpDD.GetCaps(lpDDDriverCaps, lpDDHELCaps);
		Logger.addEntry("MyIDirectDraw.GetCaps(" ~ "" ~ ") = ", res);
		return res;
	}
	/// 
	override DDRESULT GetDisplayMode(LPProperSurfaceDesc lpDDSurfaceDesc)
	{
		auto res = _lpDD.GetDisplayMode(lpDDSurfaceDesc);
		Logger.addEntry("MyIDirectDraw.GetDisplayMode(" ~ "" ~ ") = ", res);
		return res;
	}
	/// 
	override DDRESULT GetFourCCCodes(DWORD* lpNumCodes, DWORD* lpCodes)
	{
		auto res = _lpDD.GetFourCCCodes(lpNumCodes, lpCodes);
		Logger.addEntry("MyIDirectDraw.GetFourCCCodes(", lpNumCodes, lpCodes, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetGDISurface(LPProperDirectDrawSurface* lplpGDIDDSSurface)
	{
		auto res = _lpDD.GetGDISurface(lplpGDIDDSSurface);
		Logger.addEntry("MyIDirectDraw.GetGDISurface()"); // ~ to!string(cast(size_t)*lplpGDIDDSSurface, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetMonitorFrequency(LPDWORD lpdwFrequency)
	{
		auto res = _lpDD.GetMonitorFrequency(lpdwFrequency);
		Logger.addEntry("MyIDirectDraw.GetMonitorFrequency(", lpdwFrequency, ")");
		return res;
	}

	/// 
	override DDRESULT GetScanLine(LPDWORD lpdwScanLine)
	{
		auto res = _lpDD.GetScanLine(lpdwScanLine);
		Logger.addEntry("MyIDirectDraw.GetScanLine(" ~ "" ~ ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetVerticalBlankStatus(LPBOOL lpbIsInVB)
	{
		auto res = _lpDD.GetVerticalBlankStatus(lpbIsInVB);
		Logger.addEntry("MyIDirectDraw.GetVerticalBlankStatus(" ~ "" ~ ") = ", res);
		return res;
	}

	/// 
	override DDRESULT Initialize(GUID* lpGUID)
	{
		auto res = _lpDD.Initialize(lpGUID);
		Logger.addEntry("MyIDirectDraw.Initialize() = ", res);
		return res;
	}

	/// 
	override DDRESULT RestoreDisplayMode()
	{
		Logger.addEntry("MyIDirectDraw.RestoreDisplayMode()");
		auto res = _lpDD.RestoreDisplayMode();
		return res;
	}


	/// 
	override DDRESULT SetCooperativeLevel(HWND hWnd, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDraw.SetCooperativeLevel(", hWnd, dwFlags, ")");
		g_hWnd = hWnd;
		version (forceWindowed)
			return _lpDD.SetCooperativeLevel(hWnd, DDSCL_NORMAL);
		else
			return _lpDD.SetCooperativeLevel(hWnd, dwFlags);
	}

	static if (ver < 2)
	/// 
	override DDRESULT SetDisplayMode(DWORD dwWidth, DWORD dwHeight, DWORD dwBpp)
	{
		Logger.addEntry("MyIDirectDraw.SetDisplayMode(", dwWidth, dwHeight, dwBpp, ")");
		
		version (forceWindowed)
			return DD_OK;
		else
			return _lpDD.SetDisplayMode(dwWidth, dwHeight, dwBpp);
	}
	
	else
	///
	override DDRESULT SetDisplayMode(DWORD dwWidth, DWORD dwHeight, DWORD dwBpp, DWORD dwRefreshRate, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDraw.SetDisplayMode(", dwWidth, dwHeight, dwBpp, dwRefreshRate, dwFlags, ")");
		
		version (forceWindowed)
			return DD_OK;
		else
			return _lpDD.SetDisplayMode(dwWidth, dwHeight, dwBpp, dwRefreshRate, dwFlags);
	}

	/// 
	override DDRESULT WaitForVerticalBlank(DWORD dwFlags, HANDLE hEvent)
	{
		auto res = _lpDD.WaitForVerticalBlank(dwFlags, hEvent);
		Logger.addEntry("MyIDirectDraw.WaitForVerticalBlank(", dwFlags, hEvent, ") = ", res);
		return res;
	}
	
static if(ver >= 2)

	/// 
	override DDRESULT GetAvailableVidMem(LPProperDDSCaps lpDDSCaps, LPDWORD lpdwTotal, LPDWORD lpdwFree)
	{
		auto res = _lpDD.GetAvailableVidMem(lpDDSCaps, lpdwTotal, lpdwFree);
		Logger.addEntry("MyIDirectDraw.GetAvailableVidMem(", lpDDSCaps, ") = ", res);
		return res;
	}

static if(ver >= 4)
{
	/// 
	override DDRESULT GetSurfaceFromDC(HDC hdc, LPProperDirectDrawSurface* lpdds)
	{
		auto res = _lpDD.GetSurfaceFromDC(hdc, lpdds);
		Logger.addEntry("MyIDirectDraw.GetSurfaceFromDC() = ", res);
		return res;
	}

	/// 
	override DDRESULT RestoreAllSurfaces()
	{
		auto res = _lpDD.RestoreAllSurfaces();
		Logger.addEntry("MyIDirectDraw.RestoreAllSurfaces() = ", res);
		return res;
	}

	/// 
	override DDRESULT TestCooperativeLevel()
	{
		auto res = _lpDD.TestCooperativeLevel();
		Logger.addEntry("MyIDirectDraw.TestCooperativeLevel() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetDeviceIdentifier(LPProperDDDeviceIdentifier lpdddi, DWORD dwFlags)
	{
		auto res = _lpDD.GetDeviceIdentifier(lpdddi, dwFlags);
		Logger.addEntry("MyIDirectDraw.GetDeviceIdentifier(", dwFlags, ") = ", res);
		return res;
	}
}
	
static if(ver >= 7)
{

	/// 
	override DDRESULT StartModeTest(LPSIZE lpModesToTest, DWORD dwNumEntries, DWORD dwFlags)
	{
		auto res = _lpDD.StartModeTest(lpModesToTest, dwNumEntries, dwFlags);
		Logger.addEntry("MyIDirectDraw.StartModeTest(", dwFlags, ") = ", res);
		return res;
	}


	/// 
	override DDRESULT EvaluateMode(DWORD dwFlags, DWORD* secondsUntilTimeout)
	{
		auto res = _lpDD.EvaluateMode(dwFlags, secondsUntilTimeout);
		Logger.addEntry("MyIDirectDraw.EvaluateMode(", dwFlags, ") = ", res);
		return res;
	}
}
}