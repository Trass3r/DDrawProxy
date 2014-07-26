module ddraw;
/*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:	   ddraw.h
 *  Content:	DirectDraw include file
 *
 ***************************************************************************/


public import std.c.windows.windows;
public import std.c.windows.com;

import std.traits;

// a helper function to make elements of enums accessable without EnumType. prefix
private string bringToCurrentScope(alias EnumType)()
{
	string res = "";
	foreach (e; __traits(allMembers, EnumType))
	{
		res ~= "alias " ~ EnumType.stringof ~ "." ~ e ~ " " ~ e ~ ";\n";
	}
	return res;
}

extern(Windows):
nothrow:
@nogc:

union LARGE_INTEGER
{
	struct
	{
		DWORD LowPart;
		LONG  HighPart;
	}
	struct u
	{
		DWORD LowPart;
		LONG  HighPart;
	}
	long QuadPart;
}
alias LARGE_INTEGER* PLARGE_INTEGER;

struct SIZE
{ 
	LONG cx; 
	LONG cy; 
}
alias SIZE* LPSIZE;

struct RGNDATA
{
	RGNDATAHEADER rdh;
	char		  Buffer[1];
	}
alias RGNDATA* LPRGNDATA;

struct RGNDATAHEADER
{
	DWORD dwSize;
	DWORD iType;
	DWORD nCount;
	DWORD nRgnSize;
	RECT  rcBound;
}
alias RGNDATAHEADER* LPRGNDATAHEADER;

alias IID* REFIID;

enum CO_E_NOTINITIALIZED = 0x800401F0;

/*
 * If you wish an application built against the newest version of DirectDraw
 * to run against an older DirectDraw run time then define DIRECTDRAW_VERSION
 * to be the earlies version of DirectDraw you wish to run against. For,
 * example if you wish an application to run against a DX 3 runtime define
 * DIRECTDRAW_VERSION to be 0x0300.
 */
enum DIRECTDRAW_VERSION = 0x0700;

/*
 * FOURCC codes for DX compressed-texture pixel formats
 */

private uint MAKEFOURCC(char ch0, char ch1, char ch2, char ch3)
{
	return cast(uint)ch0 | (cast(uint)ch1 << 8) | (cast(uint)ch2 << 16) | (cast(uint)ch3 << 24);
}

enum FOURCC_DXT1 = MAKEFOURCC('D','X','T','1');
enum FOURCC_DXT2 = MAKEFOURCC('D','X','T','2');
enum FOURCC_DXT3 = MAKEFOURCC('D','X','T','3');
enum FOURCC_DXT4 = MAKEFOURCC('D','X','T','4');
enum FOURCC_DXT5 = MAKEFOURCC('D','X','T','5');

/*
 * GUIDS used by DirectDraw objects
 */

immutable GUID CLSID_DirectDraw				= {0xD7B70EE0, 0x4340, 0x11CF, [0xB0, 0x63, 0x00, 0x20, 0xAF, 0xC2, 0xCD, 0x35]};
immutable GUID CLSID_DirectDraw7			= {0x3c305196, 0x50db, 0x11d3, [0x9c, 0xfe, 0x00, 0xc0, 0x4f, 0xd9, 0x30, 0xc5]};
immutable GUID CLSID_DirectDrawClipper		= {0x593817A0, 0x7DB3, 0x11CF, [0xA2, 0xDE, 0x00, 0xAA, 0x00, 0xb9, 0x33, 0x56]};
immutable GUID IID_IDirectDraw				= {0x6C14DB80, 0xA733, 0x11CE, [0xA5, 0x21, 0x00, 0x20, 0xAF, 0x0B, 0xE5, 0x60]};
immutable GUID IID_IDirectDraw2				= {0xB3A6F3E0, 0x2B43, 0x11CF, [0xA2, 0xDE, 0x00, 0xAA, 0x00, 0xB9, 0x33, 0x56]};
immutable GUID IID_IDirectDraw4				= {0x9c59509a, 0x39bd, 0x11d1, [0x8c, 0x4a, 0x00, 0xc0, 0x4f, 0xd9, 0x30, 0xc5]};
immutable GUID IID_IDirectDraw7				= {0x15e65ec0, 0x3b9c, 0x11d2, [0xb9, 0x2f, 0x00, 0x60, 0x97, 0x97, 0xea, 0x5b]};
immutable GUID IID_IDirectDrawSurface		= {0x6C14DB81, 0xA733, 0x11CE, [0xA5, 0x21, 0x00, 0x20, 0xAF, 0x0B, 0xE5, 0x60]};
immutable GUID IID_IDirectDrawSurface2		= {0x57805885, 0x6eec, 0x11cf, [0x94, 0x41, 0xa8, 0x23, 0x03, 0xc1, 0x0e, 0x27]};
immutable GUID IID_IDirectDrawSurface3		= {0xDA044E00, 0x69B2, 0x11D0, [0xA1, 0xD5, 0x00, 0xAA, 0x00, 0xB8, 0xDF, 0xBB]};
immutable GUID IID_IDirectDrawSurface4		= {0x0B2B8630, 0xAD35, 0x11D0, [0x8E, 0xA6, 0x00, 0x60, 0x97, 0x97, 0xEA, 0x5B]};
immutable GUID IID_IDirectDrawSurface7		= {0x06675a80, 0x3b9b, 0x11d2, [0xb9, 0x2f, 0x00, 0x60, 0x97, 0x97, 0xea, 0x5b]};
immutable GUID IID_IDirectDrawPalette		= {0x6C14DB84, 0xA733, 0x11CE, [0xA5, 0x21, 0x00, 0x20, 0xAF, 0x0B, 0xE5, 0x60]};
immutable GUID IID_IDirectDrawClipper		= {0x6C14DB85, 0xA733, 0x11CE, [0xA5, 0x21, 0x00, 0x20, 0xAF, 0x0B, 0xE5, 0x60]};
immutable GUID IID_IDirectDrawColorControl	= {0x4B9F0EE0, 0x0D7E, 0x11D0, [0x9B, 0x06, 0x00, 0xA0, 0xC9, 0x03, 0xA3, 0xB8]};
immutable GUID IID_IDirectDrawGammaControl	= {0x69C11C3E, 0xB46B, 0x11D1, [0xAD, 0x7A, 0x00, 0xC0, 0x4F, 0xC2, 0x9B, 0x4E]};

/*
 * INTERACES FOLLOW:
 *	  IDirectDraw
 *	  IDirectDrawClipper
 *	  IDirectDrawPalette
 *	  IDirectDrawSurface
 */

alias IDirectDrawSurface  = IDirectDrawSurfaceB!(1);
alias IDirectDrawSurface2 = IDirectDrawSurfaceB!(2);
alias IDirectDrawSurface3 = IDirectDrawSurfaceB!(3);
alias IDirectDrawSurface4 = IDirectDrawSurfaceB!(4);
alias IDirectDrawSurface7 = IDirectDrawSurfaceB!(7);

/**
 * IDirectDrawSurface and related interfaces
 */
interface IDirectDrawSurfaceB(uint ver) : IUnknown
{
private
{
	static if (ver < 4)
		alias LPDDSCAPS LPProperDDSCaps;
	else
		alias LPDDSCAPS2 LPProperDDSCaps;
	
	static if (ver < 4)
		alias LPDDSURFACEDESC LPProperDDSurfaceDesc;
	else
		alias LPDDSURFACEDESC2 LPProperDDSurfaceDesc;
	
	static if (ver < 4)
		alias LPDDENUMSURFACESCALLBACK LPProperDDEnumSurfacesCallback;
	else static if (ver < 7)
		alias LPDDENUMSURFACESCALLBACK2 LPProperDDEnumSurfacesCallback;
	else
		alias LPDDENUMSURFACESCALLBACK7 LPProperDDEnumSurfacesCallback;
	
	static if (ver < 2)
		alias LPDIRECTDRAWSURFACE LPProperDirectDrawSurface;
	else static if (ver < 3)
		alias LPDIRECTDRAWSURFACE2 LPProperDirectDrawSurface;
	else static if (ver < 4)
		alias LPDIRECTDRAWSURFACE3 LPProperDirectDrawSurface;
	else static if (ver < 7)
		alias LPDIRECTDRAWSURFACE4 LPProperDirectDrawSurface;
	else
		alias LPDIRECTDRAWSURFACE7 LPProperDirectDrawSurface;
}
	DDRESULT AddAttachedSurface(LPProperDirectDrawSurface );
	DDRESULT AddOverlayDirtyRect(LPRECT );
	DDRESULT Blt(LPRECT, LPProperDirectDrawSurface, LPRECT, DWORD, LPDDBLTFX );
	DDRESULT BltBatch(LPDDBLTBATCH, DWORD, DWORD );
	DDRESULT BltFast(DWORD, DWORD, LPProperDirectDrawSurface, LPRECT, DWORD );
	DDRESULT DeleteAttachedSurface(DWORD, LPProperDirectDrawSurface );
	DDRESULT EnumAttachedSurfaces(LPVOID, LPProperDDEnumSurfacesCallback );
	DDRESULT EnumOverlayZOrders(DWORD, LPVOID, LPProperDDEnumSurfacesCallback );
	DDRESULT Flip(LPProperDirectDrawSurface, DWORD );
	DDRESULT GetAttachedSurface(LPProperDDSCaps, LPProperDirectDrawSurface *);
	DDRESULT GetBltStatus(DWORD );
	DDRESULT GetCaps(LPProperDDSCaps );
	DDRESULT GetClipper(LPDIRECTDRAWCLIPPER *);
	DDRESULT GetColorKey(DWORD, LPDDCOLORKEY );
	DDRESULT GetDC(HDC *);
	DDRESULT GetFlipStatus(DWORD );
	DDRESULT GetOverlayPosition(LPLONG, LPLONG );
	DDRESULT GetPalette(LPDIRECTDRAWPALETTE *);
	DDRESULT GetPixelFormat(LPDDPIXELFORMAT );
	DDRESULT GetSurfaceDesc(LPProperDDSurfaceDesc );
	DDRESULT Initialize(LPDIRECTDRAW, LPProperDDSurfaceDesc ); // LPDIRECTDRA is correct
	DDRESULT IsLost();
	DDRESULT Lock(LPRECT, LPProperDDSurfaceDesc, DWORD, HANDLE );
	DDRESULT ReleaseDC(HDC );
	DDRESULT Restore();
	DDRESULT SetClipper(LPDIRECTDRAWCLIPPER );
	DDRESULT SetColorKey(DWORD, LPDDCOLORKEY );
	DDRESULT SetOverlayPosition(LONG, LONG );
	DDRESULT SetPalette(LPDIRECTDRAWPALETTE );
	DDRESULT Unlock(LPRECT ); // was LPVOID before ver4
	DDRESULT UpdateOverlay(LPRECT, LPProperDirectDrawSurface, LPRECT, DWORD, LPDDOVERLAYFX );
	DDRESULT UpdateOverlayDisplay(DWORD );
	DDRESULT UpdateOverlayZOrder(DWORD, LPProperDirectDrawSurface );
	
	// IDirectDrawSurface2
	static if (ver >= 2)
	{
		DDRESULT GetDDInterface(LPVOID *);
		DDRESULT PageLock(DWORD );
		DDRESULT PageUnlock(DWORD );
	}
	
	// IDirectDrawSurface3
	static if (ver >= 3)
		DDRESULT SetSurfaceDesc(LPProperDDSurfaceDesc, DWORD );

	// IDirectDrawSurface4
	static if (ver >= 4)
	{
		DDRESULT SetPrivateData(GUID *, LPVOID, DWORD, DWORD );
		DDRESULT GetPrivateData(GUID *, LPVOID, LPDWORD );
		DDRESULT FreePrivateData(GUID *);
		DDRESULT GetUniquenessValue(LPDWORD );
		DDRESULT ChangeUniquenessValue();
	}
	
	// IDirectDrawSurface7 from Texture7 methods
	static if (ver >= 7)
	{
		DDRESULT SetPriority(DWORD );
		DDRESULT GetPriority(LPDWORD );
		DDRESULT SetLOD(DWORD );
		DDRESULT GetLOD(LPDWORD );
	}
}


/*============================================================================
*
* DirectDraw Structures
*
* Various structures used to invoke DirectDraw.
*
*==========================================================================*/
// TODO: is this correct not being pointers since D classes are reference types?
alias IDirectDrawB!(1) IDirectDraw; ///
alias IDirectDrawB!(2) IDirectDraw2; ///
alias IDirectDrawB!(4) IDirectDraw4; ///
alias IDirectDrawB!(7) IDirectDraw7; ///

alias IDirectDrawB!(1) LPDIRECTDRAW;
alias IDirectDrawB!(2) LPDIRECTDRAW2;
alias IDirectDrawB!(4) LPDIRECTDRAW4;
alias IDirectDrawB!(7) LPDIRECTDRAW7;
alias IDirectDrawSurfaceB!(1) LPDIRECTDRAWSURFACE;
alias IDirectDrawSurfaceB!(2) LPDIRECTDRAWSURFACE2;
alias IDirectDrawSurfaceB!(3) LPDIRECTDRAWSURFACE3;
alias IDirectDrawSurfaceB!(4) LPDIRECTDRAWSURFACE4;
alias IDirectDrawSurfaceB!(7) LPDIRECTDRAWSURFACE7;

alias IDirectDrawPalette LPDIRECTDRAWPALETTE;
alias IDirectDrawClipper LPDIRECTDRAWCLIPPER;
alias IDirectDrawColorControl LPDIRECTDRAWCOLORCONTROL;
alias IDirectDrawGammaControl LPDIRECTDRAWGAMMACONTROL;

alias void* LPDDFXROP; //alias _DDFXROP *LPDDFXROP;
alias DDSURFACEDESC* LPDDSURFACEDESC;
alias DDSURFACEDESC2* LPDDSURFACEDESC2;
alias DDCOLORCONTROL* LPDDCOLORCONTROL;


interface IDirectDrawB(uint ver) : IUnknown
{
private
{
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
//		alias LPDIRECTDRAWSURFACE2 LPProperDirectDrawSurface; // doesn't seem to be used
	else static if (ver < 7)
		alias LPDIRECTDRAWSURFACE4 LPProperDirectDrawSurface;
	else
		alias LPDIRECTDRAWSURFACE7 LPProperDirectDrawSurface;
	
	static if (ver < 7)
		alias LPDDDEVICEIDENTIFIER LPProperDDDeviceIdentifier;
	else
		alias LPDDDEVICEIDENTIFIER2 LPProperDDDeviceIdentifier;
}

	DDRESULT Compact();
	DDRESULT CreateClipper(DWORD, LPDIRECTDRAWCLIPPER *, IUnknown *);
	DDRESULT CreatePalette(DWORD, LPPALETTEENTRY, LPDIRECTDRAWPALETTE *, IUnknown *);
	DDRESULT CreateSurface(LPProperSurfaceDesc, LPProperDirectDrawSurface *, IUnknown *);
	DDRESULT DuplicateSurface(LPProperDirectDrawSurface, LPProperDirectDrawSurface *);
	DDRESULT EnumDisplayModes(DWORD, LPProperSurfaceDesc, LPVOID, LPProperDDEnumModesCallback );
	DDRESULT EnumSurfaces(DWORD, LPProperSurfaceDesc, LPVOID, LPProperDDEnumSurfacesCallback );
	DDRESULT FlipToGDISurface();
	DDRESULT GetCaps(LPDDCAPS, LPDDCAPS );
	DDRESULT GetDisplayMode(LPProperSurfaceDesc );
	DDRESULT GetFourCCCodes(LPDWORD, LPDWORD );
	DDRESULT GetGDISurface(LPProperDirectDrawSurface *);
	DDRESULT GetMonitorFrequency(LPDWORD );
	DDRESULT GetScanLine(LPDWORD );
	DDRESULT GetVerticalBlankStatus(LPBOOL );
	DDRESULT Initialize(GUID *);
	DDRESULT RestoreDisplayMode();
	DDRESULT SetCooperativeLevel(HWND, DWORD );
	static if (ver < 2)
		DDRESULT SetDisplayMode(DWORD, DWORD, DWORD );
	else
		DDRESULT SetDisplayMode(DWORD, DWORD, DWORD, DWORD, DWORD );
	DDRESULT WaitForVerticalBlank(DWORD, HANDLE );
	
	static if(ver >= 2)
		DDRESULT GetAvailableVidMem(LPProperDDSCaps, LPDWORD, LPDWORD );
	
	static if(ver >= 4)
	{
		DDRESULT GetSurfaceFromDC(HDC, LPProperDirectDrawSurface *);
		DDRESULT RestoreAllSurfaces();
		DDRESULT TestCooperativeLevel();
		DDRESULT GetDeviceIdentifier(LPProperDDDeviceIdentifier, DWORD );
	}
	
	static if(ver >= 7)
	{
		DDRESULT StartModeTest(LPSIZE, DWORD, DWORD );
		DDRESULT EvaluateMode(DWORD, DWORD *);
	}
}

/**
 * IDirectDrawPalette
 */
interface IDirectDrawPalette : IUnknown
{
	DDRESULT GetCaps(LPDWORD );
	DDRESULT GetEntries(DWORD, DWORD, DWORD, LPPALETTEENTRY );
	DDRESULT Initialize(LPDIRECTDRAW, DWORD, LPPALETTEENTRY );
	DDRESULT SetEntries(DWORD, DWORD, DWORD, LPPALETTEENTRY );
}

/**
 * IDirectDrawClipper
 */
interface IDirectDrawClipper : IUnknown
{
	DDRESULT GetClipList(LPRECT, LPRGNDATA, LPDWORD );
	DDRESULT GetHWnd(HWND *);
	DDRESULT Initialize(LPDIRECTDRAW, DWORD );
	DDRESULT IsClipListChanged(BOOL *);
	DDRESULT SetClipList(LPRGNDATA, DWORD );
	DDRESULT SetHWnd(DWORD, HWND );
}

/**
 * IDirectDrawColorControl
 */
interface IDirectDrawColorControl : IUnknown
{
	DDRESULT GetColorControls(LPDDCOLORCONTROL );
	DDRESULT SetColorControls(LPDDCOLORCONTROL );
}

/**
 * IDirectDrawGammaControl
 */
interface IDirectDrawGammaControl : IUnknown
{
	DDRESULT GetGammaRamp(DWORD, LPDDGAMMARAMP );
	DDRESULT SetGammaRamp(DWORD, LPDDGAMMARAMP );
}

/*
 * API's
 */
alias BOOL  function(GUID *, LPSTR, LPSTR, LPVOID )LPDDENUMCALLBACKA;
alias BOOL  function(GUID *, LPWSTR, LPWSTR, LPVOID )LPDDENUMCALLBACKW;

DDRESULT DirectDrawEnumerateW(LPDDENUMCALLBACKW lpCallback, LPVOID lpContext);
DDRESULT DirectDrawEnumerateA(LPDDENUMCALLBACKA lpCallback, LPVOID lpContext);

static assert(functionLinkage!LPDDENUMCALLBACKA == "Windows");
static assert(functionLinkage!DirectDrawEnumerateA == "Windows");


alias HANDLE HMONITOR;
alias BOOL  function(GUID *, LPSTR, LPSTR, LPVOID, HMONITOR )LPDDENUMCALLBACKEXA;
alias BOOL  function(GUID *, LPWSTR, LPWSTR, LPVOID, HMONITOR )LPDDENUMCALLBACKEXW;
DDRESULT DirectDrawEnumerateExW(LPDDENUMCALLBACKEXW lpCallback, LPVOID lpContext, DWORD dwFlags);
DDRESULT DirectDrawEnumerateExA(LPDDENUMCALLBACKEXA lpCallback, LPVOID lpContext, DWORD dwFlags);
alias HRESULT  function(LPDDENUMCALLBACKEXA lpCallback, LPVOID lpContext, DWORD dwFlags)LPDIRECTDRAWENUMERATEEXA;
alias HRESULT  function(LPDDENUMCALLBACKEXW lpCallback, LPVOID lpContext, DWORD dwFlags)LPDIRECTDRAWENUMERATEEXW;

alias LPDDENUMCALLBACKA LPDDENUMCALLBACK;
alias DirectDrawEnumerateA DirectDrawEnumerate;
alias LPDDENUMCALLBACKEXA LPDDENUMCALLBACKEX;
alias LPDIRECTDRAWENUMERATEEXA LPDIRECTDRAWENUMERATEEX;
alias DirectDrawEnumerateExA DirectDrawEnumerateEx;
extern (Windows):
DDRESULT DirectDrawCreate(GUID *lpGUID, LPDIRECTDRAW *lplpDD, IUnknown *pUnkOuter);
DDRESULT DirectDrawCreateEx(GUID *lpGuid, LPVOID *lplpDD, const ref IID iid, IUnknown *pUnkOuter);
DDRESULT DirectDrawCreateClipper(DWORD dwFlags, LPDIRECTDRAWCLIPPER *lplpDDClipper, IUnknown *pUnkOuter);
/*
 * Flags for DirectDrawEnumerateEx
 * DirectDrawEnumerateEx supercedes DirectDrawEnumerate. You must use GetProcAddress to
 * obtain a function pointer (of type LPDIRECTDRAWENUMERATEEX) to DirectDrawEnumerateEx.
 * By default, only the primary display device is enumerated.
 * DirectDrawEnumerate is equivalent to DirectDrawEnumerate(,,DDENUM_NONDISPLAYDEVICES)
 */

/*
 * This flag causes enumeration of any GDI display devices which are part of
 * the Windows Desktop
 */

const DDENUM_ATTACHEDSECONDARYDEVICES = 0x00000001;
/*
 * This flag causes enumeration of any GDI display devices which are not
 * part of the Windows Desktop
 */

const DDENUM_DETACHEDSECONDARYDEVICES = 0x00000002;
/*
 * This flag causes enumeration of non-display devices
 */

const DDENUM_NONDISPLAYDEVICES = 0x00000004;


const DDCREATE_HARDWAREONLY = 0x00000001;

const DDCREATE_EMULATIONONLY = 0x00000002;

alias LPDDENUMMODESCALLBACK  = HRESULT function(LPDDSURFACEDESC,  LPVOID);
alias LPDDENUMMODESCALLBACK2 = HRESULT function(LPDDSURFACEDESC2, LPVOID);

alias LPDDENUMSURFACESCALLBACK  = HRESULT function(LPDIRECTDRAWSURFACE,  LPDDSURFACEDESC,  LPVOID);
alias LPDDENUMSURFACESCALLBACK2 = HRESULT function(LPDIRECTDRAWSURFACE4, LPDDSURFACEDESC2, LPVOID);
alias LPDDENUMSURFACESCALLBACK7 = HRESULT function(LPDIRECTDRAWSURFACE7, LPDDSURFACEDESC2, LPVOID);

/**
 * Generic pixel format with 8-bit RGB and alpha components
 */
struct DDARGB
{
	BYTE blue;
	BYTE green;
	BYTE red;
	BYTE alpha;
}
alias DDARGB *LPDDARGB;

/**
 * This version of the structure remains for backwards source compatibility.
 * The DDARGB structure is the one that should be used for all DirectDraw APIs.
 */
struct DDRGBA
{
	BYTE red;
	BYTE green;
	BYTE blue;
	BYTE alpha;
}
alias DDRGBA *LPDDRGBA;


/**
 * DDCOLORKEY
 */
										// be treated as Color Key, inclusive
										// to be treated as Color Key, inclusive
struct DDCOLORKEY
{
	DWORD dwColorSpaceLowValue;
	DWORD dwColorSpaceHighValue;
}
alias DDCOLORKEY *LPDDCOLORKEY;

/**
 * DDBLTFX
 * Used to pass override information to the DIRECTDRAWSURFACE callback Blt.
 */
struct DDBLTFX
{
    DWORD	dwSize;				// size of structure
    DWORD	dwDDFX;				// FX operations
    DWORD	dwROP;				// Win32 raster operations
    DWORD	dwDDROP;			// Raster operations new for DirectDraw
    DWORD	dwRotationAngle;		// Rotation angle for blt
    DWORD	dwZBufferOpCode;		// ZBuffer compares
    DWORD	dwZBufferLow;			// Low limit of Z buffer
    DWORD	dwZBufferHigh;			// High limit of Z buffer
    DWORD	dwZBufferBaseDest;		// Destination base value
    DWORD	dwZDestConstBitDepth;		// Bit depth used to specify Z constant for destination
    union
    {
	DWORD	dwZDestConst;			// Constant to use as Z buffer for dest
	LPDIRECTDRAWSURFACE lpDDSZBufferDest;	// Surface to use as Z buffer for dest
    }
    DWORD	dwZSrcConstBitDepth;		// Bit depth used to specify Z constant for source
    union
    {
	DWORD	dwZSrcConst;			// Constant to use as Z buffer for src
	LPDIRECTDRAWSURFACE lpDDSZBufferSrc;	// Surface to use as Z buffer for src
    }
    DWORD	dwAlphaEdgeBlendBitDepth;	// Bit depth used to specify constant for alpha edge blend
    DWORD	dwAlphaEdgeBlend;		// Alpha for edge blending
    DWORD	dwReserved;
    DWORD	dwAlphaDestConstBitDepth;	// Bit depth used to specify alpha constant for destination
    union
    {
	DWORD	dwAlphaDestConst;		// Constant to use as Alpha Channel
	LPDIRECTDRAWSURFACE lpDDSAlphaDest;	// Surface to use as Alpha Channel
    }
    DWORD	dwAlphaSrcConstBitDepth;	// Bit depth used to specify alpha constant for source
    union
    {
	DWORD	dwAlphaSrcConst;		// Constant to use as Alpha Channel
	LPDIRECTDRAWSURFACE lpDDSAlphaSrc;	// Surface to use as Alpha Channel
    }
    union
    {
	DWORD	dwFillColor;			// color in RGB or Palettized
	DWORD   dwFillDepth;                    // depth value for z-buffer
	LPDIRECTDRAWSURFACE lpDDSPattern;	// Surface to use as pattern
    }
    DDCOLORKEY	ddckDestColorkey;		// DestColorkey override
    DDCOLORKEY	ddckSrcColorkey;		// SrcColorkey override
}
alias DDBLTFX *LPDDBLTFX; /// ditto



/**
 * DDSCAPS
 */
struct DDSCAPS
{
	DWORD dwCaps;
}
alias DDSCAPS* LPDDSCAPS;


/**
 * DDOSCAPS
 */
struct DDOSCAPS
{
	DWORD dwCaps;
}
alias DDOSCAPS* LPDDOSCAPS;

/**
 * This structure is used internally by DirectDraw.
 */
struct DDSCAPSEX
{
	DWORD dwCaps2;
	DWORD dwCaps3;
	union
	{
		DWORD dwCaps4;
		DWORD dwVolumeDepth;
	}
}
alias DDSCAPSEX *LPDDSCAPSEX;

/**
 * DDSCAPS2
 */
struct DDSCAPS2
{
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCaps3;
	union
	{
		DWORD dwCaps4;
		DWORD dwVolumeDepth;
	}
}
alias DDSCAPS2 *LPDDSCAPS2;

/*
 * DDCAPS
 */
/*
 * NOTE: Our choosen structure number scheme is to append a single digit to
 * the end of the structure giving the version that structure is associated
 * with.
 */

/*
 * This structure represents the DDCAPS structure released in DirectDraw 1.0.  It is used internally
 * by DirectDraw to interpret caps passed into ddraw by drivers written prior to the release of DirectDraw 2.0.
 * New applications should use the DDCAPS structure defined below.
 */
struct _DDCAPS_DX1
{
	DWORD dwSize;
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCKeyCaps;
	DWORD dwFXCaps;
	DWORD dwFXAlphaCaps;
	DWORD dwPalCaps;
	DWORD dwSVCaps;
	DWORD dwAlphaBltConstBitDepths;
	DWORD dwAlphaBltPixelBitDepths;
	DWORD dwAlphaBltSurfaceBitDepths;
	DWORD dwAlphaOverlayConstBitDepths;
	DWORD dwAlphaOverlayPixelBitDepths;
	DWORD dwAlphaOverlaySurfaceBitDepths;
	DWORD dwZBufferBitDepths;
	DWORD dwVidMemTotal;
	DWORD dwVidMemFree;
	DWORD dwMaxVisibleOverlays;
	DWORD dwCurrVisibleOverlays;
	DWORD dwNumFourCCCodes;
	DWORD dwAlignBoundarySrc;
	DWORD dwAlignSizeSrc;
	DWORD dwAlignBoundaryDest;
	DWORD dwAlignSizeDest;
	DWORD dwAlignStrideAlign;
	DWORD [8]dwRops;
	DDSCAPS ddsCaps;
	DWORD dwMinOverlayStretch;
	DWORD dwMaxOverlayStretch;
	DWORD dwMinLiveVideoStretch;
	DWORD dwMaxLiveVideoStretch;
	DWORD dwMinHwCodecStretch;
	DWORD dwMaxHwCodecStretch;
	DWORD dwReserved1;
	DWORD dwReserved2;
	DWORD dwReserved3;
}
alias _DDCAPS_DX1 DDCAPS_DX1;

alias DDCAPS_DX1 *LPDDCAPS_DX1;

/*
 * This structure is the DDCAPS structure as it was in version 2 and 3 of Direct X.
 * It is present for back compatability.
 */
struct _DDCAPS_DX3
{
	DWORD dwSize;
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCKeyCaps;
	DWORD dwFXCaps;
	DWORD dwFXAlphaCaps;
	DWORD dwPalCaps;
	DWORD dwSVCaps;
	DWORD dwAlphaBltConstBitDepths;
	DWORD dwAlphaBltPixelBitDepths;
	DWORD dwAlphaBltSurfaceBitDepths;
	DWORD dwAlphaOverlayConstBitDepths;
	DWORD dwAlphaOverlayPixelBitDepths;
	DWORD dwAlphaOverlaySurfaceBitDepths;
	DWORD dwZBufferBitDepths;
	DWORD dwVidMemTotal;
	DWORD dwVidMemFree;
	DWORD dwMaxVisibleOverlays;
	DWORD dwCurrVisibleOverlays;
	DWORD dwNumFourCCCodes;
	DWORD dwAlignBoundarySrc;
	DWORD dwAlignSizeSrc;
	DWORD dwAlignBoundaryDest;
	DWORD dwAlignSizeDest;
	DWORD dwAlignStrideAlign;
	DWORD [8]dwRops;
	DDSCAPS ddsCaps;
	DWORD dwMinOverlayStretch;
	DWORD dwMaxOverlayStretch;
	DWORD dwMinLiveVideoStretch;
	DWORD dwMaxLiveVideoStretch;
	DWORD dwMinHwCodecStretch;
	DWORD dwMaxHwCodecStretch;
	DWORD dwReserved1;
	DWORD dwReserved2;
	DWORD dwReserved3;
	DWORD dwSVBCaps;
	DWORD dwSVBCKeyCaps;
	DWORD dwSVBFXCaps;
	DWORD [8]dwSVBRops;
	DWORD dwVSBCaps;
	DWORD dwVSBCKeyCaps;
	DWORD dwVSBFXCaps;
	DWORD [8]dwVSBRops;
	DWORD dwSSBCaps;
	DWORD dwSSBCKeyCaps;
	DWORD dwSSBFXCaps;
	DWORD [8]dwSSBRops;
	DWORD dwReserved4;
	DWORD dwReserved5;
	DWORD dwReserved6;
}
alias _DDCAPS_DX3 DDCAPS_DX3;
alias DDCAPS_DX3 *LPDDCAPS_DX3;

/*
 * This structure is the DDCAPS structure as it was in version 5 of Direct X.
 * It is present for back compatability.
 */
/*  0*/
/*  4*/
/*  8*/
/*  c*/
/* 10*/
/* 14*/
/* 18*/
/* 1c*/
/* 20*/
/* 24*/
/* 28*/
/* 2c*/
/* 30*/
/* 34*/
/* 38*/
/* 3c*/
/* 40*/
/* 44*/
/* 48*/
/* 4c*/
/* 50*/
/* 54*/
/* 58*/
/* 5c*/
/* 60*/
/* 64*/
/* 84*/
/* 88*/
/* 8c*/
/* 90*/
/* 94*/
/* 98*/
/* 9c*/
/* a0*/
/* a4*/
/* a8*/
/* ac*/
/* b0*/
/* b4*/
/* b8*/
/* d8*/
/* dc*/
/* e0*/
/* e4*/
/*104*/
/*108*/
/*10c*/
/*110*/
// Members added for DX5:
/*130*/
/*134*/
/*138*/
/*13c*/
/*140*/
/*144*/
/*148*/
/*14c*/
struct _DDCAPS_DX5
{
	DWORD dwSize;
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCKeyCaps;
	DWORD dwFXCaps;
	DWORD dwFXAlphaCaps;
	DWORD dwPalCaps;
	DWORD dwSVCaps;
	DWORD dwAlphaBltConstBitDepths;
	DWORD dwAlphaBltPixelBitDepths;
	DWORD dwAlphaBltSurfaceBitDepths;
	DWORD dwAlphaOverlayConstBitDepths;
	DWORD dwAlphaOverlayPixelBitDepths;
	DWORD dwAlphaOverlaySurfaceBitDepths;
	DWORD dwZBufferBitDepths;
	DWORD dwVidMemTotal;
	DWORD dwVidMemFree;
	DWORD dwMaxVisibleOverlays;
	DWORD dwCurrVisibleOverlays;
	DWORD dwNumFourCCCodes;
	DWORD dwAlignBoundarySrc;
	DWORD dwAlignSizeSrc;
	DWORD dwAlignBoundaryDest;
	DWORD dwAlignSizeDest;
	DWORD dwAlignStrideAlign;
	DWORD [8]dwRops;
	DDSCAPS ddsCaps;
	DWORD dwMinOverlayStretch;
	DWORD dwMaxOverlayStretch;
	DWORD dwMinLiveVideoStretch;
	DWORD dwMaxLiveVideoStretch;
	DWORD dwMinHwCodecStretch;
	DWORD dwMaxHwCodecStretch;
	DWORD dwReserved1;
	DWORD dwReserved2;
	DWORD dwReserved3;
	DWORD dwSVBCaps;
	DWORD dwSVBCKeyCaps;
	DWORD dwSVBFXCaps;
	DWORD [8]dwSVBRops;
	DWORD dwVSBCaps;
	DWORD dwVSBCKeyCaps;
	DWORD dwVSBFXCaps;
	DWORD [8]dwVSBRops;
	DWORD dwSSBCaps;
	DWORD dwSSBCKeyCaps;
	DWORD dwSSBFXCaps;
	DWORD [8]dwSSBRops;
	DWORD dwMaxVideoPorts;
	DWORD dwCurrVideoPorts;
	DWORD dwSVBCaps2;
	DWORD dwNLVBCaps;
	DWORD dwNLVBCaps2;
	DWORD dwNLVBCKeyCaps;
	DWORD dwNLVBFXCaps;
	DWORD [8]dwNLVBRops;
}
alias _DDCAPS_DX5 DDCAPS_DX5;
alias DDCAPS_DX5 *LPDDCAPS_DX5;

/*  0*/
/*  4*/
/*  8*/
/*  c*/
/* 10*/
/* 14*/
/* 18*/
/* 1c*/
/* 20*/
/* 24*/
/* 28*/
/* 2c*/
/* 30*/
/* 34*/
/* 38*/
/* 3c*/
/* 40*/
/* 44*/
/* 48*/
/* 4c*/
/* 50*/
/* 54*/
/* 58*/
/* 5c*/
/* 60*/
/* 64*/
/* 84*/
/* 88*/
/* 8c*/
/* 90*/
/* 94*/
/* 98*/
/* 9c*/
/* a0*/
/* a4*/
/* a8*/
/* ac*/
/* b0*/
/* b4*/
/* b8*/
/* d8*/
/* dc*/
/* e0*/
/* e4*/
/*104*/
/*108*/
/*10c*/
/*110*/
/*130*/
/*134*/
/*138*/
/*13c*/
/*140*/
/*144*/
/*148*/
/*14c*/
// Members added for DX6 release
/*16c*/
struct _DDCAPS_DX6
{
	DWORD dwSize;
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCKeyCaps;
	DWORD dwFXCaps;
	DWORD dwFXAlphaCaps;
	DWORD dwPalCaps;
	DWORD dwSVCaps;
	DWORD dwAlphaBltConstBitDepths;
	DWORD dwAlphaBltPixelBitDepths;
	DWORD dwAlphaBltSurfaceBitDepths;
	DWORD dwAlphaOverlayConstBitDepths;
	DWORD dwAlphaOverlayPixelBitDepths;
	DWORD dwAlphaOverlaySurfaceBitDepths;
	DWORD dwZBufferBitDepths;
	DWORD dwVidMemTotal;
	DWORD dwVidMemFree;
	DWORD dwMaxVisibleOverlays;
	DWORD dwCurrVisibleOverlays;
	DWORD dwNumFourCCCodes;
	DWORD dwAlignBoundarySrc;
	DWORD dwAlignSizeSrc;
	DWORD dwAlignBoundaryDest;
	DWORD dwAlignSizeDest;
	DWORD dwAlignStrideAlign;
	DWORD [8]dwRops;
	DDSCAPS ddsOldCaps;
	DWORD dwMinOverlayStretch;
	DWORD dwMaxOverlayStretch;
	DWORD dwMinLiveVideoStretch;
	DWORD dwMaxLiveVideoStretch;
	DWORD dwMinHwCodecStretch;
	DWORD dwMaxHwCodecStretch;
	DWORD dwReserved1;
	DWORD dwReserved2;
	DWORD dwReserved3;
	DWORD dwSVBCaps;
	DWORD dwSVBCKeyCaps;
	DWORD dwSVBFXCaps;
	DWORD [8]dwSVBRops;
	DWORD dwVSBCaps;
	DWORD dwVSBCKeyCaps;
	DWORD dwVSBFXCaps;
	DWORD [8]dwVSBRops;
	DWORD dwSSBCaps;
	DWORD dwSSBCKeyCaps;
	DWORD dwSSBFXCaps;
	DWORD [8]dwSSBRops;
	DWORD dwMaxVideoPorts;
	DWORD dwCurrVideoPorts;
	DWORD dwSVBCaps2;
	DWORD dwNLVBCaps;
	DWORD dwNLVBCaps2;
	DWORD dwNLVBCKeyCaps;
	DWORD dwNLVBFXCaps;
	DWORD [8]dwNLVBRops;
	DDSCAPS2 ddsCaps;
}
alias _DDCAPS_DX6 DDCAPS_DX6;
alias DDCAPS_DX6 *LPDDCAPS_DX6;

/*  0*/
/*  4*/
/*  8*/
/*  c*/
/* 10*/
/* 14*/
/* 18*/
/* 1c*/
/* 20*/
/* 24*/
/* 28*/
/* 2c*/
/* 30*/
/* 34*/
/* 38*/
/* 3c*/
/* 40*/
/* 44*/
/* 48*/
/* 4c*/
/* 50*/
/* 54*/
/* 58*/
/* 5c*/
/* 60*/
/* 64*/
/* 84*/
/* 88*/
/* 8c*/
/* 90*/
/* 94*/
/* 98*/
/* 9c*/
/* a0*/
/* a4*/
/* a8*/
/* ac*/
/* b0*/
/* b4*/
/* b8*/
/* d8*/
/* dc*/
/* e0*/
/* e4*/
/*104*/
/*108*/
/*10c*/
/*110*/
/*130*/
/*134*/
/*138*/
/*13c*/
/*140*/
/*144*/
/*148*/
/*14c*/
// Members added for DX6 release
/*16c*/
struct DDCAPS_DX7
{
	DWORD dwSize;
	DWORD dwCaps;
	DWORD dwCaps2;
	DWORD dwCKeyCaps;
	DWORD dwFXCaps;
	DWORD dwFXAlphaCaps;
	DWORD dwPalCaps;
	DWORD dwSVCaps;
	DWORD dwAlphaBltConstBitDepths;
	DWORD dwAlphaBltPixelBitDepths;
	DWORD dwAlphaBltSurfaceBitDepths;
	DWORD dwAlphaOverlayConstBitDepths;
	DWORD dwAlphaOverlayPixelBitDepths;
	DWORD dwAlphaOverlaySurfaceBitDepths;
	DWORD dwZBufferBitDepths;
	DWORD dwVidMemTotal;
	DWORD dwVidMemFree;
	DWORD dwMaxVisibleOverlays;
	DWORD dwCurrVisibleOverlays;
	DWORD dwNumFourCCCodes;
	DWORD dwAlignBoundarySrc;
	DWORD dwAlignSizeSrc;
	DWORD dwAlignBoundaryDest;
	DWORD dwAlignSizeDest;
	DWORD dwAlignStrideAlign;
	DWORD [8]dwRops;
	DDSCAPS ddsOldCaps;
	DWORD dwMinOverlayStretch;
	DWORD dwMaxOverlayStretch;
	DWORD dwMinLiveVideoStretch;
	DWORD dwMaxLiveVideoStretch;
	DWORD dwMinHwCodecStretch;
	DWORD dwMaxHwCodecStretch;
	DWORD dwReserved1;
	DWORD dwReserved2;
	DWORD dwReserved3;
	DWORD dwSVBCaps;
	DWORD dwSVBCKeyCaps;
	DWORD dwSVBFXCaps;
	DWORD [8]dwSVBRops;
	DWORD dwVSBCaps;
	DWORD dwVSBCKeyCaps;
	DWORD dwVSBFXCaps;
	DWORD [8]dwVSBRops;
	DWORD dwSSBCaps;
	DWORD dwSSBCKeyCaps;
	DWORD dwSSBFXCaps;
	DWORD [8]dwSSBRops;
	DWORD dwMaxVideoPorts;
	DWORD dwCurrVideoPorts;
	DWORD dwSVBCaps2;
	DWORD dwNLVBCaps;
	DWORD dwNLVBCaps2;
	DWORD dwNLVBCKeyCaps;
	DWORD dwNLVBFXCaps;
	DWORD [8]dwNLVBRops;
	DDSCAPS2 ddsCaps;
}
alias DDCAPS_DX7 *LPDDCAPS_DX7;


alias DDCAPS_DX7 DDCAPS;

alias DDCAPS *LPDDCAPS;



/**
 * DDPIXELFORMAT
 */
										// format list and if DDPF_D3DFORMAT is set
struct DDPIXELFORMAT
{
	DWORD dwSize;
	DWORD dwFlags;
	DWORD dwFourCC;
	union
	{
		DWORD dwRGBBitCount;
		DWORD dwYUVBitCount;
		DWORD dwZBufferBitDepth;
		DWORD dwAlphaBitDepth;
		DWORD dwLuminanceBitCount;
		DWORD dwBumpBitCount;
		DWORD dwPrivateFormatBitCount;
	}
	union
	{
		DWORD dwRBitMask;
		DWORD dwYBitMask;
		DWORD dwStencilBitDepth;
		DWORD dwLuminanceBitMask;
		DWORD dwBumpDuBitMask;
		DWORD dwOperations;
	}
	union
	{
		DWORD dwGBitMask;
		DWORD dwUBitMask;
		DWORD dwZBitMask;
		DWORD dwBumpDvBitMask;
		struct MultiSampleCaps
		{
			WORD wFlipMSTypes;
			WORD wBltMSTypes;
		}
	}
	union
	{
		DWORD dwBBitMask;
		DWORD dwVBitMask;
		DWORD dwStencilBitMask;
		DWORD dwBumpLuminanceBitMask;
	}
	union
	{
		DWORD dwRGBAlphaBitMask;
		DWORD dwYUVAlphaBitMask;
		DWORD dwLuminanceAlphaBitMask;
		DWORD dwRGBZBitMask;
		DWORD dwYUVZBitMask;
	}
}
alias DDPIXELFORMAT *LPDDPIXELFORMAT;

/**
 * DDOVERLAYFX
 */
struct DDOVERLAYFX
{
	DWORD dwSize;
	DWORD dwAlphaEdgeBlendBitDepth;
	DWORD dwAlphaEdgeBlend;
	DWORD dwReserved;
	DWORD dwAlphaDestConstBitDepth;
	union
	{
		DWORD dwAlphaDestConst;
		LPDIRECTDRAWSURFACE lpDDSAlphaDest;
	}
	DWORD dwAlphaSrcConstBitDepth;
	union
	{
		DWORD dwAlphaSrcConst;
		LPDIRECTDRAWSURFACE lpDDSAlphaSrc;
	}
	DDCOLORKEY dckDestColorkey;
	DDCOLORKEY dckSrcColorkey;
	DWORD dwDDFX;
	DWORD dwFlags;
}
alias DDOVERLAYFX *LPDDOVERLAYFX;


/**
 * DDBLTBATCH: BltBatch entry structure
 */
struct DDBLTBATCH
{
	LPRECT lprDest;
	LPDIRECTDRAWSURFACE lpDDSSrc;
	LPRECT lprSrc;
	DWORD dwFlags;
	LPDDBLTFX lpDDBltFx;
}
alias DDBLTBATCH *LPDDBLTBATCH;


/**
 * DDGAMMARAMP
 */
struct DDGAMMARAMP
{
	WORD[256] red;
	WORD[256] green;
	WORD[256] blue;
}
alias DDGAMMARAMP *LPDDGAMMARAMP;

/*
 *  This is the structure within which DirectDraw returns data about the current graphics driver and chipset
 */


const MAX_DDDEVICEID_STRING = 512;
	/*
	 * These elements are for presentation to the user only. They should not be used to identify particular
	 * drivers, since this is unreliable and many different strings may be associated with the same
	 * device, and the same driver from different vendors.
	 */

	/*
	 * This element is the version of the DirectDraw/3D driver. It is legal to do <, > comparisons
	 * on the whole 64 bits. Caution should be exercised if you use this element to identify problematic
	 * drivers. It is recommended that guidDeviceIdentifier is used for this purpose.
	 *
	 * This version has the form:
	 *  wProduct = HIWORD(liDriverVersion.HighPart)
	 *  wVersion = LOWORD(liDriverVersion.HighPart)
	 *  wSubVersion = HIWORD(liDriverVersion.LowPart)
	 *  wBuild = LOWORD(liDriverVersion.LowPart)
	 */


	/*
	 * These elements can be used to identify particular chipsets. Use with extreme caution.
	 *   dwVendorId	 Identifies the manufacturer. May be zero if unknown.
	 *   dwDeviceId	 Identifies the type of chipset. May be zero if unknown.
	 *   dwSubSysId	 Identifies the subsystem, typically this means the particular board. May be zero if unknown.
	 *   dwRevision	 Identifies the revision level of the chipset. May be zero if unknown.
	 */

	/*
	 * This element can be used to check changes in driver/chipset. This GUID is a unique identifier for the
	 * driver/chipset pair. Use this element if you wish to track changes to the driver/chipset in order to
	 * reprofile the graphics subsystem.
	 * This element can also be used to identify particular problematic drivers.
	 */
	
struct DDDEVICEIDENTIFIER
{
	char [512]szDriver;
	char [512]szDescription;
	LARGE_INTEGER liDriverVersion;
	DWORD dwVendorId;
	DWORD dwDeviceId;
	DWORD dwSubSysId;
	DWORD dwRevision;
	GUID guidDeviceIdentifier;
}
alias DDDEVICEIDENTIFIER *LPDDDEVICEIDENTIFIER;

	/*
	 * These elements are for presentation to the user only. They should not be used to identify particular
	 * drivers, since this is unreliable and many different strings may be associated with the same
	 * device, and the same driver from different vendors.
	 */

	/*
	 * This element is the version of the DirectDraw/3D driver. It is legal to do <, > comparisons
	 * on the whole 64 bits. Caution should be exercised if you use this element to identify problematic
	 * drivers. It is recommended that guidDeviceIdentifier is used for this purpose.
	 *
	 * This version has the form:
	 *  wProduct = HIWORD(liDriverVersion.HighPart)
	 *  wVersion = LOWORD(liDriverVersion.HighPart)
	 *  wSubVersion = HIWORD(liDriverVersion.LowPart)
	 *  wBuild = LOWORD(liDriverVersion.LowPart)
	 */


	/*
	 * These elements can be used to identify particular chipsets. Use with extreme caution.
	 *   dwVendorId	 Identifies the manufacturer. May be zero if unknown.
	 *   dwDeviceId	 Identifies the type of chipset. May be zero if unknown.
	 *   dwSubSysId	 Identifies the subsystem, typically this means the particular board. May be zero if unknown.
	 *   dwRevision	 Identifies the revision level of the chipset. May be zero if unknown.
	 */

	/*
	 * This element can be used to check changes in driver/chipset. This GUID is a unique identifier for the
	 * driver/chipset pair. Use this element if you wish to track changes to the driver/chipset in order to
	 * reprofile the graphics subsystem.
	 * This element can also be used to identify particular problematic drivers.
	 */

	/*
	 * This element is used to determine the Windows Hardware Quality Lab (WHQL)
	 * certification level for this driver/device pair.
	 */

struct DDDEVICEIDENTIFIER2
{
	char[512] szDriver;
	char[512] szDescription;
	LARGE_INTEGER liDriverVersion;
	DWORD dwVendorId;
	DWORD dwDeviceId;
	DWORD dwSubSysId;
	DWORD dwRevision;
	GUID guidDeviceIdentifier;
	DWORD dwWHQLLevel;
}
alias DDDEVICEIDENTIFIER2 *LPDDDEVICEIDENTIFIER2;

/*
 * Flags for the IDirectDraw4::GetDeviceIdentifier method
 */

/*
 * This flag causes GetDeviceIdentifier to return information about the host (typically 2D) adapter in a system equipped
 * with a stacked secondary 3D adapter. Such an adapter appears to the application as if it were part of the
 * host adapter, but is typically physcially located on a separate card. The stacked secondary's information is
 * returned when GetDeviceIdentifier's dwFlags field is zero, since this most accurately reflects the qualities
 * of the DirectDraw object involved.
 */

const DDGDI_GETHOSTIDENTIFIER = 0x00000001;
/*
 * Macros for interpretting DDEVICEIDENTIFIER2.dwWHQLLevel
 */


/**
 * callbacks
 */
alias DWORD  function(LPDIRECTDRAWCLIPPER lpDDClipper, HWND hWnd, DWORD code, LPVOID lpContext)LPCLIPPERCALLBACK;


/**
 * DDSURFACEDESC
 */
struct DDSURFACEDESC
{
	DWORD dwSize;
	DWORD dwFlags;
	DWORD dwHeight;
	DWORD dwWidth;
	union
	{
		LONG lPitch;
		DWORD dwLinearSize;
	}
	DWORD dwBackBufferCount;
	union
	{
		DWORD dwMipMapCount;
		DWORD dwZBufferBitDepth;
		DWORD dwRefreshRate;
	}
	DWORD dwAlphaBitDepth;
	DWORD dwReserved;
	LPVOID lpSurface;
	DDCOLORKEY ddckCKDestOverlay;
	DDCOLORKEY ddckCKDestBlt;
	DDCOLORKEY ddckCKSrcOverlay;
	DDCOLORKEY ddckCKSrcBlt;
	DDPIXELFORMAT ddpfPixelFormat;
	DDSCAPS ddsCaps;
}

/**
 * DDSURFACEDESC2
 * 
 * dwZBufferBitDepth removed, use ddpfPixelFormat one instead
 */
struct DDSURFACEDESC2
{
	DWORD dwSize;
	DWORD dwFlags;
	DWORD dwHeight;
	DWORD dwWidth;
	union
	{
		LONG lPitch;
		DWORD dwLinearSize;
	}
	union
	{
		DWORD dwBackBufferCount;
		DWORD dwDepth;
	}
	union
	{
		DWORD dwMipMapCount;
		DWORD dwRefreshRate;
		DWORD dwSrcVBHandle;
	}
	DWORD dwAlphaBitDepth;
	DWORD dwReserved;
	LPVOID lpSurface;
	union
	{
		DDCOLORKEY ddckCKDestOverlay;
		DWORD dwEmptyFaceColor;
	}
	DDCOLORKEY ddckCKDestBlt;
	DDCOLORKEY ddckCKSrcOverlay;
	DDCOLORKEY ddckCKSrcBlt;
	union
	{
		DDPIXELFORMAT ddpfPixelFormat;
		DWORD dwFVF;
	}
	DDSCAPS2 ddsCaps;
	DWORD dwTextureStage;
}

/*
 * ddsCaps field is valid.
 */

const DDSD_CAPS = 0x00000001;
/*
 * dwHeight field is valid.
 */

const DDSD_HEIGHT = 0x00000002;
/*
 * dwWidth field is valid.
 */

const DDSD_WIDTH = 0x00000004;
/*
 * lPitch is valid.
 */

const DDSD_PITCH = 0x00000008;
/*
 * dwBackBufferCount is valid.
 */

const DDSD_BACKBUFFERCOUNT = 0x00000020;
/*
 * dwZBufferBitDepth is valid.  (shouldnt be used in DDSURFACEDESC2)
 */

const DDSD_ZBUFFERBITDEPTH = 0x00000040;
/*
 * dwAlphaBitDepth is valid.
 */

const DDSD_ALPHABITDEPTH = 0x00000080;

/*
 * lpSurface is valid.
 */

const DDSD_LPSURFACE = 0x00000800;
/*
 * ddpfPixelFormat is valid.
 */

const DDSD_PIXELFORMAT = 0x00001000;
/*
 * ddckCKDestOverlay is valid.
 */

const DDSD_CKDESTOVERLAY = 0x00002000;
/*
 * ddckCKDestBlt is valid.
 */

const DDSD_CKDESTBLT = 0x00004000;
/*
 * ddckCKSrcOverlay is valid.
 */

const DDSD_CKSRCOVERLAY = 0x00008000;
/*
 * ddckCKSrcBlt is valid.
 */

const DDSD_CKSRCBLT = 0x00010000;
/*
 * dwMipMapCount is valid.
 */

const DDSD_MIPMAPCOUNT = 0x00020000;
 /*
  * dwRefreshRate is valid
  */

const DDSD_REFRESHRATE = 0x00040000;
/*
 * dwLinearSize is valid
 */

const DDSD_LINEARSIZE = 0x00080000;
/*
 * dwTextureStage is valid
 */
/*
const DDSD_TEXTURESTAGE = 0x00100000;
 * dwFVF is valid
 */
/*
const DDSD_FVF = 0x00200000;
 * dwSrcVBHandle is valid
 */

const DDSD_SRCVBHANDLE = 0x00400000;
/*
 * dwDepth is valid
 */

const DDSD_DEPTH = 0x00800000;
/*
 * All input fields are valid.
 */

const DDSD_ALL = 0x00fff9ee;
/*
 * DDOPTSURFACEDESC
 */
struct DDOPTSURFACEDESC
{
	DWORD dwSize;
	DWORD dwFlags;
	DDSCAPS2 ddSCaps;
	DDOSCAPS ddOSCaps;
	GUID guid;
	DWORD dwCompressionRatio;
}

/*
 * guid field is valid.
 */

const DDOSD_GUID = 0x00000001;
/*
 * dwCompressionRatio field is valid.
 */

const DDOSD_COMPRESSION_RATIO = 0x00000002;
/*
 * ddSCaps field is valid.
 */

const DDOSD_SCAPS = 0x00000004;
/*
 * ddOSCaps field is valid.
 */

const DDOSD_OSCAPS = 0x00000008;
/*
 * All input fields are valid.
 */

const DDOSD_ALL = 0x0000000f;
/*
 * The surface's optimized pixelformat is compressed
 */

const DDOSDCAPS_OPTCOMPRESSED = 0x00000001;
/*
 * The surface's optimized pixelformat is reordered
 */

const DDOSDCAPS_OPTREORDERED = 0x00000002;
/*
 * The opt surface is a monolithic mipmap
 */

const DDOSDCAPS_MONOLITHICMIPMAP = 0x00000004;
/*
 * The valid Surf caps:
 * #define DDSCAPS_SYSTEMMEMORY				 0x00000800l
 * #define DDSCAPS_VIDEOMEMORY		  0x00004000l
 * #define DDSCAPS_LOCALVIDMEM		  0x10000000l
 * #define DDSCAPS_NONLOCALVIDMEM	   0x20000000l
 */

const DDOSDCAPS_VALIDSCAPS = 0x30004800;
/*
 * The valid OptSurf caps
 */

const DDOSDCAPS_VALIDOSCAPS = 0x00000007;

/*
 * DDCOLORCONTROL
 */
struct _DDCOLORCONTROL
{
	DWORD dwSize;
	DWORD dwFlags;
	LONG lBrightness;
	LONG lContrast;
	LONG lHue;
	LONG lSaturation;
	LONG lSharpness;
	LONG lGamma;
	LONG lColorEnable;
	DWORD dwReserved1;
}
alias _DDCOLORCONTROL DDCOLORCONTROL;


/*
 * lBrightness field is valid.
 */

const DDCOLOR_BRIGHTNESS = 0x00000001;
/*
 * lContrast field is valid.
 */

const DDCOLOR_CONTRAST = 0x00000002;
/*
 * lHue field is valid.
 */

const DDCOLOR_HUE = 0x00000004;
/*
 * lSaturation field is valid.
 */

const DDCOLOR_SATURATION = 0x00000008;
/*
 * lSharpness field is valid.
 */

const DDCOLOR_SHARPNESS = 0x00000010;
/*
 * lGamma field is valid.
 */

const DDCOLOR_GAMMA = 0x00000020;
/*
 * lColorEnable field is valid.
 */

const DDCOLOR_COLORENABLE = 0x00000040;


/*============================================================================
 *
 * Direct Draw Capability Flags
 *
 * These flags are used to describe the capabilities of a given Surface.
 * All flags are bit flags.
 *
 *==========================================================================*/

/****************************************************************************
 *
 * DIRECTDRAWSURFACE CAPABILITY FLAGS
 *
 ****************************************************************************/

/*
 * This bit is reserved. It should not be specified.
 */

const DDSCAPS_RESERVED1 = 0x00000001;
/*
 * Indicates that this surface contains alpha-only information.
 * (To determine if a surface is RGBA/YUVA, the pixel format must be
 * interrogated.)
 */

const DDSCAPS_ALPHA = 0x00000002;
/*
 * Indicates that this surface is a backbuffer.  It is generally
 * set by CreateSurface when the DDSCAPS_FLIP capability bit is set.
 * It indicates that this surface is THE back buffer of a surface
 * flipping structure.  DirectDraw supports N surfaces in a
 * surface flipping structure.  Only the surface that immediately
 * precedeces the DDSCAPS_FRONTBUFFER has this capability bit set.
 * The other surfaces are identified as back buffers by the presence
 * of the DDSCAPS_FLIP capability, their attachment order, and the
 * absence of the DDSCAPS_FRONTBUFFER and DDSCAPS_BACKBUFFER
 * capabilities.  The bit is sent to CreateSurface when a standalone
 * back buffer is being created.  This surface could be attached to
 * a front buffer and/or back buffers to form a flipping surface
 * structure after the CreateSurface call.  See AddAttachments for
 * a detailed description of the behaviors in this case.
 */

const DDSCAPS_BACKBUFFER = 0x00000004;
/*
 * Indicates a complex surface structure is being described.  A
 * complex surface structure results in the creation of more than
 * one surface.  The additional surfaces are attached to the root
 * surface.  The complex structure can only be destroyed by
 * destroying the root.
 */

const DDSCAPS_COMPLEX = 0x00000008;
/*
 * Indicates that this surface is a part of a surface flipping structure.
 * When it is passed to CreateSurface the DDSCAPS_FRONTBUFFER and
 * DDSCAP_BACKBUFFER bits are not set.  They are set by CreateSurface
 * on the resulting creations.  The dwBackBufferCount field in the
 * DDSURFACEDESC structure must be set to at least 1 in order for
 * the CreateSurface call to succeed.  The DDSCAPS_COMPLEX capability
 * must always be set with creating multiple surfaces through CreateSurface.
 */

const DDSCAPS_FLIP = 0x00000010;
/*
 * Indicates that this surface is THE front buffer of a surface flipping
 * structure.  It is generally set by CreateSurface when the DDSCAPS_FLIP
 * capability bit is set.
 * If this capability is sent to CreateSurface then a standalonw front buffer
 * is created.  This surface will not have the DDSCAPS_FLIP capability.
 * It can be attached to other back buffers to form a flipping structure.
 * See AddAttachments for a detailed description of the behaviors in this
 * case.
 */

const DDSCAPS_FRONTBUFFER = 0x00000020;
/*
 * Indicates that this surface is any offscreen surface that is not an overlay,
 * texture, zbuffer, front buffer, back buffer, or alpha surface.  It is used
 * to identify plain vanilla surfaces.
 */

const DDSCAPS_OFFSCREENPLAIN = 0x00000040;
/*
 * Indicates that this surface is an overlay.  It may or may not be directly visible
 * depending on whether or not it is currently being overlayed onto the primary
 * surface.  DDSCAPS_VISIBLE can be used to determine whether or not it is being
 * overlayed at the moment.
 */

const DDSCAPS_OVERLAY = 0x00000080;
/*
 * Indicates that unique DirectDrawPalette objects can be created and
 * attached to this surface.
 */

const DDSCAPS_PALETTE = 0x00000100;
/*
 * Indicates that this surface is the primary surface.  The primary
 * surface represents what the user is seeing at the moment.
 */

const DDSCAPS_PRIMARYSURFACE = 0x00000200;

/*
 * This flag used to be DDSCAPS_PRIMARYSURFACELEFT, which is now
 * obsolete.
 */
const DDSCAPS_RESERVED3 = 0x00000400;

const DDSCAPS_PRIMARYSURFACELEFT = 0x00000000;
/*
 * Indicates that this surface memory was allocated in system memory
 */

const DDSCAPS_SYSTEMMEMORY = 0x00000800;
/*
 * Indicates that this surface can be used as a 3D texture.  It does not
 * indicate whether or not the surface is being used for that purpose.
 */

const DDSCAPS_TEXTURE = 0x00001000;
/*
 * Indicates that a surface may be a destination for 3D rendering.  This
 * bit must be set in order to query for a Direct3D Device Interface
 * from this surface.
 */

const DDSCAPS_3DDEVICE = 0x00002000;
/*
 * Indicates that this surface exists in video memory.
 */

const DDSCAPS_VIDEOMEMORY = 0x00004000;
/*
 * Indicates that changes made to this surface are immediately visible.
 * It is always set for the primary surface and is set for overlays while
 * they are being overlayed and texture maps while they are being textured.
 */

const DDSCAPS_VISIBLE = 0x00008000;
/*
 * Indicates that only writes are permitted to the surface.  Read accesses
 * from the surface may or may not generate a protection fault, but the
 * results of a read from this surface will not be meaningful.  READ ONLY.
 */

const DDSCAPS_WRITEONLY = 0x00010000;
/*
 * Indicates that this surface is a z buffer. A z buffer does not contain
 * displayable information.  Instead it contains bit depth information that is
 * used to determine which pixels are visible and which are obscured.
 */

const DDSCAPS_ZBUFFER = 0x00020000;
/*
 * Indicates surface will have a DC associated long term
 */

const DDSCAPS_OWNDC = 0x00040000;
/*
 * Indicates surface should be able to receive live video
 */

const DDSCAPS_LIVEVIDEO = 0x00080000;
/*
 * Indicates surface should be able to have a stream decompressed
 * to it by the hardware.
 */

const DDSCAPS_HWCODEC = 0x00100000;
/*
 * Surface is a ModeX surface.
 *
 */

const DDSCAPS_MODEX = 0x00200000;
/*
 * Indicates surface is one level of a mip-map. This surface will
 * be attached to other DDSCAPS_MIPMAP surfaces to form the mip-map.
 * This can be done explicitly, by creating a number of surfaces and
 * attaching them with AddAttachedSurface or by implicitly by CreateSurface.
 * If this bit is set then DDSCAPS_TEXTURE must also be set.
 */

const DDSCAPS_MIPMAP = 0x00400000;
/*
 * This bit is reserved. It should not be specified.
 */

const DDSCAPS_RESERVED2 = 0x00800000;

/*
 * Indicates that memory for the surface is not allocated until the surface
 * is loaded (via the Direct3D texture Load() function).
 */

const DDSCAPS_ALLOCONLOAD = 0x04000000;
/*
 * Indicates that the surface will recieve data from a video port.
 */

const DDSCAPS_VIDEOPORT = 0x08000000;
/*
 * Indicates that a video memory surface is resident in true, local video
 * memory rather than non-local video memory. If this flag is specified then
 * so must DDSCAPS_VIDEOMEMORY. This flag is mutually exclusive with
 * DDSCAPS_NONLOCALVIDMEM.
 */

const DDSCAPS_LOCALVIDMEM = 0x10000000;
/*
 * Indicates that a video memory surface is resident in non-local video
 * memory rather than true, local video memory. If this flag is specified
 * then so must DDSCAPS_VIDEOMEMORY. This flag is mutually exclusive with
 * DDSCAPS_LOCALVIDMEM.
 */

const DDSCAPS_NONLOCALVIDMEM = 0x20000000;
/*
 * Indicates that this surface is a standard VGA mode surface, and not a
 * ModeX surface. (This flag will never be set in combination with the
 * DDSCAPS_MODEX flag).
 */

const DDSCAPS_STANDARDVGAMODE = 0x40000000;
/*
 * Indicates that this surface will be an optimized surface. This flag is
 * currently only valid in conjunction with the DDSCAPS_TEXTURE flag. The surface
 * will be created without any underlying video memory until loaded.
 */

const DDSCAPS_OPTIMIZED = 0x80000000;


/*
 * This bit is reserved
 */
const DDSCAPS2_RESERVED4 = 0x00000002;

const DDSCAPS2_HARDWAREDEINTERLACE = 0x00000000;
/*
 * Indicates to the driver that this surface will be locked very frequently
 * (for procedural textures, dynamic lightmaps, etc). Surfaces with this cap
 * set must also have DDSCAPS_TEXTURE. This cap cannot be used with
 * DDSCAPS2_HINTSTATIC and DDSCAPS2_OPAQUE.
 */

const DDSCAPS2_HINTDYNAMIC = 0x00000004;
/*
 * Indicates to the driver that this surface can be re-ordered/retiled on
 * load. This operation will not change the size of the texture. It is
 * relatively fast and symmetrical, since the application may lock these
 * bits (although it will take a performance hit when doing so). Surfaces
 * with this cap set must also have DDSCAPS_TEXTURE. This cap cannot be
 * used with DDSCAPS2_HINTDYNAMIC and DDSCAPS2_OPAQUE.
 */

const DDSCAPS2_HINTSTATIC = 0x00000008;
/*
 * Indicates that the client would like this texture surface to be managed by the
 * DirectDraw/Direct3D runtime. Surfaces with this cap set must also have
 * DDSCAPS_TEXTURE set.
 */

const DDSCAPS2_TEXTUREMANAGE = 0x00000010;
/*
 * These bits are reserved for internal use */
const DDSCAPS2_RESERVED1 = 0x00000020;

const DDSCAPS2_RESERVED2 = 0x00000040;
/*
 * Indicates to the driver that this surface will never be locked again.
 * The driver is free to optimize this surface via retiling and actual compression.
 * All calls to Lock() or Blts from this surface will fail. Surfaces with this
 * cap set must also have DDSCAPS_TEXTURE. This cap cannot be used with
 * DDSCAPS2_HINTDYNAMIC and DDSCAPS2_HINTSTATIC.
 */

const DDSCAPS2_OPAQUE = 0x00000080;
/*
 * Applications should set this bit at CreateSurface time to indicate that they
 * intend to use antialiasing. Only valid if DDSCAPS_3DDEVICE is also set.
 */

const DDSCAPS2_HINTANTIALIASING = 0x00000100;

/*
 * This flag is used at CreateSurface time to indicate that this set of
 * surfaces is a cubic environment map
 */

const DDSCAPS2_CUBEMAP = 0x00000200;
/*
 * These flags preform two functions:
 * - At CreateSurface time, they define which of the six cube faces are
 *   required by the application.
 * - After creation, each face in the cubemap will have exactly one of these
 *   bits set.
 */
const DDSCAPS2_CUBEMAP_POSITIVEX = 0x00000400;
const DDSCAPS2_CUBEMAP_NEGATIVEX = 0x00000800;
const DDSCAPS2_CUBEMAP_POSITIVEY = 0x00001000;
const DDSCAPS2_CUBEMAP_NEGATIVEY = 0x00002000;
const DDSCAPS2_CUBEMAP_POSITIVEZ = 0x00004000;

const DDSCAPS2_CUBEMAP_NEGATIVEZ = 0x00008000;
/*
 * This macro may be used to specify all faces of a cube map at CreateSurface time
 */


/*
 * This flag is an additional flag which is present on mipmap sublevels from DX7 onwards
 * It enables easier use of GetAttachedSurface rather than EnumAttachedSurfaces for surface
 * constructs such as Cube Maps, wherein there are more than one mipmap surface attached
 * to the root surface.
 * This caps bit is ignored by CreateSurface
 */

const DDSCAPS2_MIPMAPSUBLEVEL = 0x00010000;
/* This flag indicates that the texture should be managed by D3D only */

const DDSCAPS2_D3DTEXTUREMANAGE = 0x00020000;
/* This flag indicates that the managed surface can be safely lost */

const DDSCAPS2_DONOTPERSIST = 0x00040000;
/* indicates that this surface is part of a stereo flipping chain */

const DDSCAPS2_STEREOSURFACELEFT = 0x00080000;

/*
 * Indicates that the surface is a volume.
 * Can be combined with DDSCAPS_MIPMAP to indicate a multi-level volume
 */

const DDSCAPS2_VOLUME = 0x00200000;
/*
 * Indicates that the surface may be locked multiple times by the application.
 * This cap cannot be used with DDSCAPS2_OPAQUE.
 */

const DDSCAPS2_NOTUSERLOCKABLE = 0x00400000;
/*
 * Indicates that the vertex buffer data can be used to render points and
 * point sprites.
 */

const DDSCAPS2_POINTS = 0x00800000;
/*
 * Indicates that the vertex buffer data can be used to render rt pactches.
 */

const DDSCAPS2_RTPATCHES = 0x01000000;
/*
 * Indicates that the vertex buffer data can be used to render n patches.
 */

const DDSCAPS2_NPATCHES = 0x02000000;
/*
 * This bit is reserved for internal use 
 */

const DDSCAPS2_RESERVED3 = 0x04000000;

/*
 * Indicates that the contents of the backbuffer do not have to be preserved
 * the contents of the backbuffer after they are presented.
 */

const DDSCAPS2_DISCARDBACKBUFFER = 0x10000000;
/*
 * Indicates that all surfaces in this creation chain should be given an alpha channel.
 * This flag will be set on primary surface chains that may have no explicit pixel format
 * (and thus take on the format of the current display mode).
 * The driver should infer that all these surfaces have a format having an alpha channel.
 * (e.g. assume D3DFMT_A8R8G8B8 if the display mode is x888.)
 */

const DDSCAPS2_ENABLEALPHACHANNEL = 0x20000000;
/*
 * Indicates that all surfaces in this creation chain is extended primary surface format.
 * This flag will be set on extended primary surface chains that always have explicit pixel
 * format and the pixel format is typically GDI (Graphics Device Interface) couldn't handle,
 * thus only used with fullscreen application. (e.g. D3DFMT_A2R10G10B10 format)
 */

const DDSCAPS2_EXTENDEDFORMATPRIMARY = 0x40000000;
/*
 * Indicates that all surfaces in this creation chain is additional primary surface.
 * This flag will be set on primary surface chains which must present on the adapter
 * id provided on dwCaps4. Typically this will be used to create secondary primary surface
 * on DualView display adapter.
 */

const DDSCAPS2_ADDITIONALPRIMARY = 0x80000000;
/*
 * This is a mask that indicates the set of bits that may be set
 * at createsurface time to indicate number of samples per pixel
 * when multisampling
 */

const DDSCAPS3_MULTISAMPLE_MASK = 0x0000001F;
/*
 * This is a mask that indicates the set of bits that may be set
 * at createsurface time to indicate the quality level of rendering
 * for the current number of samples per pixel
 */
const DDSCAPS3_MULTISAMPLE_QUALITY_MASK = 0x000000E0;

const DDSCAPS3_MULTISAMPLE_QUALITY_SHIFT = 5;
/*
 * This bit is reserved for internal use 
 */

const DDSCAPS3_RESERVED1 = 0x00000100;
/*
 * This bit is reserved for internal use 
 */

const DDSCAPS3_RESERVED2 = 0x00000200;
/*
 * This indicates whether this surface has light-weight miplevels
 */

const DDSCAPS3_LIGHTWEIGHTMIPMAP = 0x00000400;
/*
 * This indicates that the mipsublevels for this surface are auto-generated
 */

const DDSCAPS3_AUTOGENMIPMAP = 0x00000800;
/*
 * This indicates that the mipsublevels for this surface are auto-generated
 */

const DDSCAPS3_DMAP = 0x00001000;

 /****************************************************************************
 *
 * DIRECTDRAW DRIVER CAPABILITY FLAGS
 *
 ****************************************************************************/

/*
 * Display hardware has 3D acceleration.
 */

const DDCAPS_3D = 0x00000001;
/*
 * Indicates that DirectDraw will support only dest rectangles that are aligned
 * on DIRECTDRAWCAPS.dwAlignBoundaryDest boundaries of the surface, respectively.
 * READ ONLY.
 */

const DDCAPS_ALIGNBOUNDARYDEST = 0x00000002;
/*
 * Indicates that DirectDraw will support only source rectangles  whose sizes in
 * BYTEs are DIRECTDRAWCAPS.dwAlignSizeDest multiples, respectively.  READ ONLY.
 */
/*
const DDCAPS_ALIGNSIZEDEST = 0x00000004;
 * Indicates that DirectDraw will support only source rectangles that are aligned
 * on DIRECTDRAWCAPS.dwAlignBoundarySrc boundaries of the surface, respectively.
 * READ ONLY.
 */

const DDCAPS_ALIGNBOUNDARYSRC = 0x00000008;
/*
 * Indicates that DirectDraw will support only source rectangles  whose sizes in
 * BYTEs are DIRECTDRAWCAPS.dwAlignSizeSrc multiples, respectively.  READ ONLY.
 */

const DDCAPS_ALIGNSIZESRC = 0x00000010;
/*
 * Indicates that DirectDraw will create video memory surfaces that have a stride
 * alignment equal to DIRECTDRAWCAPS.dwAlignStride.  READ ONLY.
 */

const DDCAPS_ALIGNSTRIDE = 0x00000020;
/*
 * Display hardware is capable of blt operations.
 */

const DDCAPS_BLT = 0x00000040;
/*
 * Display hardware is capable of asynchronous blt operations.
 */

const DDCAPS_BLTQUEUE = 0x00000080;
/*
 * Display hardware is capable of color space conversions during the blt operation.
 */

const DDCAPS_BLTFOURCC = 0x00000100;
/*
 * Display hardware is capable of stretching during blt operations.
 */

const DDCAPS_BLTSTRETCH = 0x00000200;
/*
 * Display hardware is shared with GDI.
 */

const DDCAPS_GDI = 0x00000400;
/*
 * Display hardware can overlay.
 */

const DDCAPS_OVERLAY = 0x00000800;
/*
 * Set if display hardware supports overlays but can not clip them.
 */

const DDCAPS_OVERLAYCANTCLIP = 0x00001000;
/*
 * Indicates that overlay hardware is capable of color space conversions during
 * the overlay operation.
 */

const DDCAPS_OVERLAYFOURCC = 0x00002000;
/*
 * Indicates that stretching can be done by the overlay hardware.
 */

const DDCAPS_OVERLAYSTRETCH = 0x00004000;
/*
 * Indicates that unique DirectDrawPalettes can be created for DirectDrawSurfaces
 * other than the primary surface.
 */

const DDCAPS_PALETTE = 0x00008000;
/*
 * Indicates that palette changes can be syncd with the veritcal refresh.
 */

const DDCAPS_PALETTEVSYNC = 0x00010000;
/*
 * Display hardware can return the current scan line.
 */

const DDCAPS_READSCANLINE = 0x00020000;

/*
 * This flag used to bo DDCAPS_STEREOVIEW, which is now obsolete
 */

const DDCAPS_RESERVED1 = 0x00040000;
/*
 * Display hardware is capable of generating a vertical blank interrupt.
 */

const DDCAPS_VBI = 0x00080000;
/*
 * Supports the use of z buffers with blt operations.
 */

const DDCAPS_ZBLTS = 0x00100000;
/*
 * Supports Z Ordering of overlays.
 */

const DDCAPS_ZOVERLAYS = 0x00200000;
/*
 * Supports color key
 */

const DDCAPS_COLORKEY = 0x00400000;
/*
 * Supports alpha surfaces
 */

const DDCAPS_ALPHA = 0x00800000;
/*
 * colorkey is hardware assisted(DDCAPS_COLORKEY will also be set)
 */

const DDCAPS_COLORKEYHWASSIST = 0x01000000;
/*
 * no hardware support at all
 */

const DDCAPS_NOHARDWARE = 0x02000000;
/*
 * Display hardware is capable of color fill with bltter
 */

const DDCAPS_BLTCOLORFILL = 0x04000000;
/*
 * Display hardware is bank switched, and potentially very slow at
 * random access to VRAM.
 */

const DDCAPS_BANKSWITCHED = 0x08000000;
/*
 * Display hardware is capable of depth filling Z-buffers with bltter
 */

const DDCAPS_BLTDEPTHFILL = 0x10000000;
/*
 * Display hardware is capable of clipping while bltting.
 */

const DDCAPS_CANCLIP = 0x20000000;
/*
 * Display hardware is capable of clipping while stretch bltting.
 */

const DDCAPS_CANCLIPSTRETCHED = 0x40000000;
/*
 * Display hardware is capable of bltting to or from system memory
 */

const DDCAPS_CANBLTSYSMEM = 0x80000000;

 /****************************************************************************
 *
 * MORE DIRECTDRAW DRIVER CAPABILITY FLAGS (dwCaps2)
 *
 ****************************************************************************/

/*
 * Display hardware is certified
 */

const DDCAPS2_CERTIFIED = 0x00000001;
/*
 * Driver cannot interleave 2D operations (lock and blt) to surfaces with
 * Direct3D rendering operations between calls to BeginScene() and EndScene()
 */

const DDCAPS2_NO2DDURING3DSCENE = 0x00000002;
/*
 * Display hardware contains a video port
 */

const DDCAPS2_VIDEOPORT = 0x00000004;
/*
 * The overlay can be automatically flipped according to the video port
 * VSYNCs, providing automatic doubled buffered display of video port
 * data using an overlay
 */

const DDCAPS2_AUTOFLIPOVERLAY = 0x00000008;
/*
 * Overlay can display each field of interlaced data individually while
 * it is interleaved in memory without causing jittery artifacts.
 */

const DDCAPS2_CANBOBINTERLEAVED = 0x00000010;
/*
 * Overlay can display each field of interlaced data individually while
 * it is not interleaved in memory without causing jittery artifacts.
 */

const DDCAPS2_CANBOBNONINTERLEAVED = 0x00000020;
/*
 * The overlay surface contains color controls (brightness, sharpness, etc.)
 */

const DDCAPS2_COLORCONTROLOVERLAY = 0x00000040;
/*
 * The primary surface contains color controls (gamma, etc.)
 */

const DDCAPS2_COLORCONTROLPRIMARY = 0x00000080;
/*
 * RGBZ -> RGB supported for 16:16 RGB:Z
 */

const DDCAPS2_CANDROPZ16BIT = 0x00000100;
/*
 * Driver supports non-local video memory.
 */

const DDCAPS2_NONLOCALVIDMEM = 0x00000200;
/*
 * Dirver supports non-local video memory but has different capabilities for
 * non-local video memory surfaces. If this bit is set then so must
 * DDCAPS2_NONLOCALVIDMEM.
 */

const DDCAPS2_NONLOCALVIDMEMCAPS = 0x00000400;
/*
 * Driver neither requires nor prefers surfaces to be pagelocked when performing
 * blts involving system memory surfaces
 */

const DDCAPS2_NOPAGELOCKREQUIRED = 0x00000800;
/*
 * Driver can create surfaces which are wider than the primary surface
 */

const DDCAPS2_WIDESURFACES = 0x00001000;
/*
 * Driver supports bob without using a video port by handling the
 * DDFLIP_ODD and DDFLIP_EVEN flags specified in Flip.
 */

const DDCAPS2_CANFLIPODDEVEN = 0x00002000;
/*
 * Driver supports bob using hardware
 */

const DDCAPS2_CANBOBHARDWARE = 0x00004000;
/*
 * Driver supports bltting any FOURCC surface to another surface of the same FOURCC
 */

const DDCAPS2_COPYFOURCC = 0x00008000;

/*
 * Driver supports loadable gamma ramps for the primary surface
 */

const DDCAPS2_PRIMARYGAMMA = 0x00020000;
/*
 * Driver can render in windowed mode.
 */

const DDCAPS2_CANRENDERWINDOWED = 0x00080000;
/*
 * A calibrator is available to adjust the gamma ramp according to the
 * physical display properties so that the result will be identical on
 * all calibrated systems.
 */

const DDCAPS2_CANCALIBRATEGAMMA = 0x00100000;
/*
 * Indicates that the driver will respond to DDFLIP_INTERVALn flags
 */

const DDCAPS2_FLIPINTERVAL = 0x00200000;
/*
 * Indicates that the driver will respond to DDFLIP_NOVSYNC
 */

const DDCAPS2_FLIPNOVSYNC = 0x00400000;
/*
 * Driver supports management of video memory, if this flag is ON,
 * driver manages the texture if requested with DDSCAPS2_TEXTUREMANAGE on
 * DirectX manages the texture if this flag is OFF and surface has DDSCAPS2_TEXTUREMANAGE on
 */

const DDCAPS2_CANMANAGETEXTURE = 0x00800000;
/*
 * The Direct3D texture manager uses this cap to decide whether to put managed
 * surfaces in non-local video memory. If the cap is set, the texture manager will
 * put managed surfaces in non-local vidmem. Drivers that cannot texture from
 * local vidmem SHOULD NOT set this cap.
 */

const DDCAPS2_TEXMANINNONLOCALVIDMEM = 0x01000000;
/*
 * Indicates that the driver supports DX7 type of stereo in at least one mode (which may
 * not necessarily be the current mode). Applications should use IDirectDraw7 (or higher)
 * ::EnumDisplayModes and check the DDSURFACEDESC.ddsCaps.dwCaps2 field for the presence of
 * DDSCAPS2_STEREOSURFACELEFT to check if a particular mode supports stereo. The application
 * can also use IDirectDraw7(or higher)::GetDisplayMode to check the current mode.
 */

const DDCAPS2_STEREO = 0x02000000;
/*
 * This caps bit is intended for internal DirectDraw use.
 * -It is only valid if DDCAPS2_NONLOCALVIDMEMCAPS is set.
 * -If this bit is set, then DDCAPS_CANBLTSYSMEM MUST be set by the driver (and
 *  all the assoicated system memory blt caps must be correct).
 * -It implies that the system->video blt caps in DDCAPS also apply to system to
 *  nonlocal blts. I.e. the dwSVBCaps, dwSVBCKeyCaps, dwSVBFXCaps and dwSVBRops
 *  members of DDCAPS (DDCORECAPS) are filled in correctly.
 * -Any blt from system to nonlocal memory that matches these caps bits will
 *  be passed to the driver.
 *
 * NOTE: This is intended to enable the driver itself to do efficient reordering
 * of textures. This is NOT meant to imply that hardware can write into AGP memory.
 * This operation is not currently supported.
 */

const DDCAPS2_SYSTONONLOCAL_AS_SYSTOLOCAL = 0x04000000;
/*
 * was DDCAPS2_PUREHAL
 */

const DDCAPS2_RESERVED1 = 0x08000000;
/*
 * Driver supports management of video memory, if this flag is ON,
 * driver manages the resource if requested with DDSCAPS2_TEXTUREMANAGE on
 * DirectX manages the resource if this flag is OFF and surface has DDSCAPS2_TEXTUREMANAGE on
 */

const DDCAPS2_CANMANAGERESOURCE = 0x10000000;
/*
 * Driver supports dynamic textures. This will allow the application to set
 * D3DUSAGE_DYNAMIC (DDSCAPS2_HINTDYNAMIC for drivers) at texture create time.
 * Video memory dynamic textures WILL be lockable by applications. It is
 * expected that these locks will be very efficient (which implies that the
 * driver should always maintain a linear copy, a pointer to which can be
 * quickly handed out to the application).
 */

const DDCAPS2_DYNAMICTEXTURES = 0x20000000;
/*
 * Driver supports auto-generation of mipmaps.
 */

const DDCAPS2_CANAUTOGENMIPMAP = 0x40000000;

/****************************************************************************
 *
 * DIRECTDRAW FX ALPHA CAPABILITY FLAGS
 *
 ****************************************************************************/

/*
 * Supports alpha blending around the edge of a source color keyed surface.
 * For Blt.
 */

const DDFXALPHACAPS_BLTALPHAEDGEBLEND = 0x00000001;
/*
 * Supports alpha information in the pixel format.  The bit depth of alpha
 * information in the pixel format can be 1,2,4, or 8.  The alpha value becomes
 * more opaque as the alpha value increases.  (0 is transparent.)
 * For Blt.
 */

const DDFXALPHACAPS_BLTALPHAPIXELS = 0x00000002;
/*
 * Supports alpha information in the pixel format.  The bit depth of alpha
 * information in the pixel format can be 1,2,4, or 8.  The alpha value
 * becomes more transparent as the alpha value increases.  (0 is opaque.)
 * This flag can only be set if DDCAPS_ALPHA is set.
 * For Blt.
 */

const DDFXALPHACAPS_BLTALPHAPIXELSNEG = 0x00000004;
/*
 * Supports alpha only surfaces.  The bit depth of an alpha only surface can be
 * 1,2,4, or 8.  The alpha value becomes more opaque as the alpha value increases.
 * (0 is transparent.)
 * For Blt.
 */

const DDFXALPHACAPS_BLTALPHASURFACES = 0x00000008;
/*
 * The depth of the alpha channel data can range can be 1,2,4, or 8.
 * The NEG suffix indicates that this alpha channel becomes more transparent
 * as the alpha value increases. (0 is opaque.)  This flag can only be set if
 * DDCAPS_ALPHA is set.
 * For Blt.
 */

const DDFXALPHACAPS_BLTALPHASURFACESNEG = 0x00000010;
/*
 * Supports alpha blending around the edge of a source color keyed surface.
 * For Overlays.
 */

const DDFXALPHACAPS_OVERLAYALPHAEDGEBLEND = 0x00000020;
/*
 * Supports alpha information in the pixel format.  The bit depth of alpha
 * information in the pixel format can be 1,2,4, or 8.  The alpha value becomes
 * more opaque as the alpha value increases.  (0 is transparent.)
 * For Overlays.
 */

const DDFXALPHACAPS_OVERLAYALPHAPIXELS = 0x00000040;
/*
 * Supports alpha information in the pixel format.  The bit depth of alpha
 * information in the pixel format can be 1,2,4, or 8.  The alpha value
 * becomes more transparent as the alpha value increases.  (0 is opaque.)
 * This flag can only be set if DDCAPS_ALPHA is set.
 * For Overlays.
 */

const DDFXALPHACAPS_OVERLAYALPHAPIXELSNEG = 0x00000080;
/*
 * Supports alpha only surfaces.  The bit depth of an alpha only surface can be
 * 1,2,4, or 8.  The alpha value becomes more opaque as the alpha value increases.
 * (0 is transparent.)
 * For Overlays.
 */

const DDFXALPHACAPS_OVERLAYALPHASURFACES = 0x00000100;
/*
 * The depth of the alpha channel data can range can be 1,2,4, or 8.
 * The NEG suffix indicates that this alpha channel becomes more transparent
 * as the alpha value increases. (0 is opaque.)  This flag can only be set if
 * DDCAPS_ALPHA is set.
 * For Overlays.
 */

const DDFXALPHACAPS_OVERLAYALPHASURFACESNEG = 0x00000200;


/****************************************************************************
 *
 * DIRECTDRAW FX CAPABILITY FLAGS
 *
 ****************************************************************************/

/*
 * Uses arithmetic operations to stretch and shrink surfaces during blt
 * rather than pixel doubling techniques.  Along the Y axis.
 */

const DDFXCAPS_BLTARITHSTRETCHY = 0x00000020;
/*
 * Uses arithmetic operations to stretch during blt
 * rather than pixel doubling techniques.  Along the Y axis. Only
 * works for x1, x2, etc.
 */

const DDFXCAPS_BLTARITHSTRETCHYN = 0x00000010;
/*
 * Supports mirroring left to right in blt.
 */

const DDFXCAPS_BLTMIRRORLEFTRIGHT = 0x00000040;
/*
 * Supports mirroring top to bottom in blt.
 */

const DDFXCAPS_BLTMIRRORUPDOWN = 0x00000080;
/*
 * Supports arbitrary rotation for blts.
 */

const DDFXCAPS_BLTROTATION = 0x00000100;
/*
 * Supports 90 degree rotations for blts.
 */

const DDFXCAPS_BLTROTATION90 = 0x00000200;
/*
 * DirectDraw supports arbitrary shrinking of a surface along the
 * x axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSHRINKX = 0x00000400;
/*
 * DirectDraw supports integer shrinking (1x,2x,) of a surface
 * along the x axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSHRINKXN = 0x00000800;
/*
 * DirectDraw supports arbitrary shrinking of a surface along the
 * y axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSHRINKY = 0x00001000;
/*
 * DirectDraw supports integer shrinking (1x,2x,) of a surface
 * along the y axis (vertical direction) for blts.
 */

const DDFXCAPS_BLTSHRINKYN = 0x00002000;
/*
 * DirectDraw supports arbitrary stretching of a surface along the
 * x axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSTRETCHX = 0x00004000;
/*
 * DirectDraw supports integer stretching (1x,2x,) of a surface
 * along the x axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSTRETCHXN = 0x00008000;
/*
 * DirectDraw supports arbitrary stretching of a surface along the
 * y axis (horizontal direction) for blts.
 */

const DDFXCAPS_BLTSTRETCHY = 0x00010000;
/*
 * DirectDraw supports integer stretching (1x,2x,) of a surface
 * along the y axis (vertical direction) for blts.
 */

const DDFXCAPS_BLTSTRETCHYN = 0x00020000;
/*
 * Uses arithmetic operations to stretch and shrink surfaces during
 * overlay rather than pixel doubling techniques.  Along the Y axis
 * for overlays.
 */

const DDFXCAPS_OVERLAYARITHSTRETCHY = 0x00040000;
/*
 * Uses arithmetic operations to stretch surfaces during
 * overlay rather than pixel doubling techniques.  Along the Y axis
 * for overlays. Only works for x1, x2, etc.
 */

const DDFXCAPS_OVERLAYARITHSTRETCHYN = 0x00000008;
/*
 * DirectDraw supports arbitrary shrinking of a surface along the
 * x axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSHRINKX = 0x00080000;
/*
 * DirectDraw supports integer shrinking (1x,2x,) of a surface
 * along the x axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSHRINKXN = 0x00100000;
/*
 * DirectDraw supports arbitrary shrinking of a surface along the
 * y axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSHRINKY = 0x00200000;
/*
 * DirectDraw supports integer shrinking (1x,2x,) of a surface
 * along the y axis (vertical direction) for overlays.
 */

const DDFXCAPS_OVERLAYSHRINKYN = 0x00400000;
/*
 * DirectDraw supports arbitrary stretching of a surface along the
 * x axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSTRETCHX = 0x00800000;
/*
 * DirectDraw supports integer stretching (1x,2x,) of a surface
 * along the x axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSTRETCHXN = 0x01000000;
/*
 * DirectDraw supports arbitrary stretching of a surface along the
 * y axis (horizontal direction) for overlays.
 */

const DDFXCAPS_OVERLAYSTRETCHY = 0x02000000;
/*
 * DirectDraw supports integer stretching (1x,2x,) of a surface
 * along the y axis (vertical direction) for overlays.
 */

const DDFXCAPS_OVERLAYSTRETCHYN = 0x04000000;
/*
 * DirectDraw supports mirroring of overlays across the vertical axis
 */

const DDFXCAPS_OVERLAYMIRRORLEFTRIGHT = 0x08000000;
/*
 * DirectDraw supports mirroring of overlays across the horizontal axis
 */

const DDFXCAPS_OVERLAYMIRRORUPDOWN = 0x10000000;
/*
 * DirectDraw supports deinterlacing of overlay surfaces
 */

const DDFXCAPS_OVERLAYDEINTERLACE = 0x20000000;
/*
 * Driver can do alpha blending for blits.
 */

const DDFXCAPS_BLTALPHA = 0x00000001;

/*
 * Driver can do surface-reconstruction filtering for warped blits.
 */

alias DDFXCAPS_BLTARITHSTRETCHY DDFXCAPS_BLTFILTER;
/*
 * Driver can do alpha blending for overlays.
 */

const DDFXCAPS_OVERLAYALPHA = 0x00000004;

/*
 * Driver can do surface-reconstruction filtering for warped overlays.
 */

alias DDFXCAPS_OVERLAYARITHSTRETCHY DDFXCAPS_OVERLAYFILTER;
/****************************************************************************
 *
 * DIRECTDRAW STEREO VIEW CAPABILITIES
 *
 ****************************************************************************/

/*
 * This flag used to be DDSVCAPS_ENIGMA, which is now obsolete
 */


const DDSVCAPS_RESERVED1 = 0x00000001;
/*
 * This flag used to be DDSVCAPS_FLICKER, which is now obsolete
 */

const DDSVCAPS_RESERVED2 = 0x00000002;
/*
 * This flag used to be DDSVCAPS_REDBLUE, which is now obsolete
 */

const DDSVCAPS_RESERVED3 = 0x00000004;
/*
 * This flag used to be DDSVCAPS_SPLIT, which is now obsolete
 */

const DDSVCAPS_RESERVED4 = 0x00000008;
/*
 * The stereo view is accomplished with switching technology
 */


const DDSVCAPS_STEREOSEQUENTIAL = 0x00000010;


/****************************************************************************
 *
 * DIRECTDRAWPALETTE CAPABILITIES
 *
 ****************************************************************************/

/*
 * Index is 4 bits.  There are sixteen color entries in the palette table.
 */

const DDPCAPS_4BIT = 0x00000001;
/*
 * Index is onto a 8 bit color index.  This field is only valid with the
 * DDPCAPS_1BIT, DDPCAPS_2BIT or DDPCAPS_4BIT capability and the target
 * surface is in 8bpp. Each color entry is one byte long and is an index
 * into destination surface's 8bpp palette.
 */

const DDPCAPS_8BITENTRIES = 0x00000002;
/*
 * Index is 8 bits.  There are 256 color entries in the palette table.
 */

const DDPCAPS_8BIT = 0x00000004;
/*
 * Indicates that this DIRECTDRAWPALETTE should use the palette color array
 * passed into the lpDDColorArray parameter to initialize the DIRECTDRAWPALETTE
 * object.
 * This flag is obsolete. DirectDraw always initializes the color array from
 * the lpDDColorArray parameter. The definition remains for source-level
 * compatibility.
 */

const DDPCAPS_INITIALIZE = 0x00000000;
/*
 * This palette is the one attached to the primary surface.  Changing this
 * table has immediate effect on the display unless DDPSETPAL_VSYNC is specified
 * and supported.
 */

const DDPCAPS_PRIMARYSURFACE = 0x00000010;
/*
 * This palette is the one attached to the primary surface left.  Changing
 * this table has immediate effect on the display for the left eye unless
 * DDPSETPAL_VSYNC is specified and supported.
 */

const DDPCAPS_PRIMARYSURFACELEFT = 0x00000020;
/*
 * This palette can have all 256 entries defined
 */

const DDPCAPS_ALLOW256 = 0x00000040;
/*
 * This palette can have modifications to it synced with the monitors
 * refresh rate.
 */

const DDPCAPS_VSYNC = 0x00000080;
/*
 * Index is 1 bit.  There are two color entries in the palette table.
 */

const DDPCAPS_1BIT = 0x00000100;
/*
 * Index is 2 bit.  There are four color entries in the palette table.
 */

const DDPCAPS_2BIT = 0x00000200;
/*
 * The peFlags member of PALETTEENTRY denotes an 8 bit alpha value
 */

const DDPCAPS_ALPHA = 0x00000400;

/****************************************************************************
 *
 * DIRECTDRAWPALETTE SETENTRY CONSTANTS
 *
 ****************************************************************************/


/****************************************************************************
 *
 * DIRECTDRAWPALETTE GETENTRY CONSTANTS
 *
 ****************************************************************************/

/* 0 is the only legal value */

/****************************************************************************
 *
 * DIRECTDRAWSURFACE SETPRIVATEDATA CONSTANTS
 *
 ****************************************************************************/

/*
 * The passed pointer is an IUnknown ptr. The cbData argument to SetPrivateData
 * must be set to sizeof(IUnknown*). DirectDraw will call AddRef through this
 * pointer and Release when the private data is destroyed. This includes when
 * the surface or palette is destroyed before such priovate data is destroyed.
 */

const DDSPD_IUNKNOWNPOINTER = 0x00000001;
/*
 * Private data is only valid for the current state of the object,
 * as determined by the uniqueness value.
 */

const DDSPD_VOLATILE = 0x00000002;

/****************************************************************************
 *
 * DIRECTDRAWSURFACE SETPALETTE CONSTANTS
 *
 ****************************************************************************/


/****************************************************************************
 *
 * DIRECTDRAW BITDEPTH CONSTANTS
 *
 * NOTE:  These are only used to indicate supported bit depths.   These
 * are flags only, they are not to be used as an actual bit depth.   The
 * absolute numbers 1, 2, 4, 8, 16, 24 and 32 are used to indicate actual
 * bit depths in a surface or for changing the display mode.
 *
 ****************************************************************************/

/*
 * 1 bit per pixel.
 */

const DDBD_1 = 0x00004000;
/*
 * 2 bits per pixel.
 */

const DDBD_2 = 0x00002000;
/*
 * 4 bits per pixel.
 */

const DDBD_4 = 0x00001000;
/*
 * 8 bits per pixel.
 */

const DDBD_8 = 0x00000800;
/*
 * 16 bits per pixel.
 */

const DDBD_16 = 0x00000400;
/*
 * 24 bits per pixel.
 */

const DDBD_24 = 0X00000200;
/*
 * 32 bits per pixel.
 */

const DDBD_32 = 0x00000100;
/****************************************************************************
 *
 * DIRECTDRAWSURFACE SET/GET COLOR KEY FLAGS
 *
 ****************************************************************************/

/*
 * Set if the structure contains a color space.  Not set if the structure
 * contains a single color key.
 */

const DDCKEY_COLORSPACE = 0x00000001;
/*
 * Set if the structure specifies a color key or color space which is to be
 * used as a destination color key for blt operations.
 */

const DDCKEY_DESTBLT = 0x00000002;
/*
 * Set if the structure specifies a color key or color space which is to be
 * used as a destination color key for overlay operations.
 */

const DDCKEY_DESTOVERLAY = 0x00000004;
/*
 * Set if the structure specifies a color key or color space which is to be
 * used as a source color key for blt operations.
 */

const DDCKEY_SRCBLT = 0x00000008;
/*
 * Set if the structure specifies a color key or color space which is to be
 * used as a source color key for overlay operations.
 */

const DDCKEY_SRCOVERLAY = 0x00000010;

/****************************************************************************
 *
 * DIRECTDRAW COLOR KEY CAPABILITY FLAGS
 *
 ****************************************************************************/

/*
 * Supports transparent blting using a color key to identify the replaceable
 * bits of the destination surface for RGB colors.
 */

const DDCKEYCAPS_DESTBLT = 0x00000001;
/*
 * Supports transparent blting using a color space to identify the replaceable
 * bits of the destination surface for RGB colors.
 */

const DDCKEYCAPS_DESTBLTCLRSPACE = 0x00000002;
/*
 * Supports transparent blting using a color space to identify the replaceable
 * bits of the destination surface for YUV colors.
 */

const DDCKEYCAPS_DESTBLTCLRSPACEYUV = 0x00000004;
/*
 * Supports transparent blting using a color key to identify the replaceable
 * bits of the destination surface for YUV colors.
 */

const DDCKEYCAPS_DESTBLTYUV = 0x00000008;
/*
 * Supports overlaying using colorkeying of the replaceable bits of the surface
 * being overlayed for RGB colors.
 */

const DDCKEYCAPS_DESTOVERLAY = 0x00000010;
/*
 * Supports a color space as the color key for the destination for RGB colors.
 */

const DDCKEYCAPS_DESTOVERLAYCLRSPACE = 0x00000020;
/*
 * Supports a color space as the color key for the destination for YUV colors.
 */

const DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV = 0x00000040;
/*
 * Supports only one active destination color key value for visible overlay
 * surfaces.
 */

const DDCKEYCAPS_DESTOVERLAYONEACTIVE = 0x00000080;
/*
 * Supports overlaying using colorkeying of the replaceable bits of the
 * surface being overlayed for YUV colors.
 */

const DDCKEYCAPS_DESTOVERLAYYUV = 0x00000100;
/*
 * Supports transparent blting using the color key for the source with
 * this surface for RGB colors.
 */

const DDCKEYCAPS_SRCBLT = 0x00000200;
/*
 * Supports transparent blting using a color space for the source with
 * this surface for RGB colors.
 */

const DDCKEYCAPS_SRCBLTCLRSPACE = 0x00000400;
/*
 * Supports transparent blting using a color space for the source with
 * this surface for YUV colors.
 */

const DDCKEYCAPS_SRCBLTCLRSPACEYUV = 0x00000800;
/*
 * Supports transparent blting using the color key for the source with
 * this surface for YUV colors.
 */

const DDCKEYCAPS_SRCBLTYUV = 0x00001000;
/*
 * Supports overlays using the color key for the source with this
 * overlay surface for RGB colors.
 */

const DDCKEYCAPS_SRCOVERLAY = 0x00002000;
/*
 * Supports overlays using a color space as the source color key for
 * the overlay surface for RGB colors.
 */

const DDCKEYCAPS_SRCOVERLAYCLRSPACE = 0x00004000;
/*
 * Supports overlays using a color space as the source color key for
 * the overlay surface for YUV colors.
 */

const DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV = 0x00008000;
/*
 * Supports only one active source color key value for visible
 * overlay surfaces.
 */

const DDCKEYCAPS_SRCOVERLAYONEACTIVE = 0x00010000;
/*
 * Supports overlays using the color key for the source with this
 * overlay surface for YUV colors.
 */

const DDCKEYCAPS_SRCOVERLAYYUV = 0x00020000;
/*
 * there are no bandwidth trade-offs for using colorkey with an overlay
 */

const DDCKEYCAPS_NOCOSTOVERLAY = 0x00040000;

/****************************************************************************
 *
 * DIRECTDRAW PIXELFORMAT FLAGS
 *
 ****************************************************************************/

/*
 * The surface has alpha channel information in the pixel format.
 */

const DDPF_ALPHAPIXELS = 0x00000001;
/*
 * The pixel format contains alpha only information
 */

const DDPF_ALPHA = 0x00000002;
/*
 * The FourCC code is valid.
 */

const DDPF_FOURCC = 0x00000004;
/*
 * The surface is 4-bit color indexed.
 */

const DDPF_PALETTEINDEXED4 = 0x00000008;
/*
 * The surface is indexed into a palette which stores indices
 * into the destination surface's 8-bit palette.
 */

const DDPF_PALETTEINDEXEDTO8 = 0x00000010;
/*
 * The surface is 8-bit color indexed.
 */

const DDPF_PALETTEINDEXED8 = 0x00000020;
/*
 * The RGB data in the pixel format structure is valid.
 */

const DDPF_RGB = 0x00000040;
/*
 * The surface will accept pixel data in the format specified
 * and compress it during the write.
 */

const DDPF_COMPRESSED = 0x00000080;
/*
 * The surface will accept RGB data and translate it during
 * the write to YUV data.  The format of the data to be written
 * will be contained in the pixel format structure.  The DDPF_RGB
 * flag will be set.
 */

const DDPF_RGBTOYUV = 0x00000100;
/*
 * pixel format is YUV - YUV data in pixel format struct is valid
 */

const DDPF_YUV = 0x00000200;
/*
 * pixel format is a z buffer only surface
 */

const DDPF_ZBUFFER = 0x00000400;
/*
 * The surface is 1-bit color indexed.
 */

const DDPF_PALETTEINDEXED1 = 0x00000800;
/*
 * The surface is 2-bit color indexed.
 */

const DDPF_PALETTEINDEXED2 = 0x00001000;
/*
 * The surface contains Z information in the pixels
 */

const DDPF_ZPIXELS = 0x00002000;
/*
 * The surface contains stencil information along with Z
 */

const DDPF_STENCILBUFFER = 0x00004000;
/*
 * Premultiplied alpha format -- the color components have been
 * premultiplied by the alpha component.
 */

const DDPF_ALPHAPREMULT = 0x00008000;

/*
 * Luminance data in the pixel format is valid.
 * Use this flag for luminance-only or luminance+alpha surfaces,
 * the bit depth is then ddpf.dwLuminanceBitCount.
 */

const DDPF_LUMINANCE = 0x00020000;
/*
 * Luminance data in the pixel format is valid.
 * Use this flag when hanging luminance off bumpmap surfaces,
 * the bit mask for the luminance portion of the pixel is then
 * ddpf.dwBumpLuminanceBitMask
 */

const DDPF_BUMPLUMINANCE = 0x00040000;
/*
 * Bump map dUdV data in the pixel format is valid.
 */

const DDPF_BUMPDUDV = 0x00080000;

/*===========================================================================
 *
 *
 * DIRECTDRAW CALLBACK FLAGS
 *
 *
 *==========================================================================*/

/****************************************************************************
 *
 * DIRECTDRAW ENUMSURFACES FLAGS
 *
 ****************************************************************************/

/*
 * Enumerate all of the surfaces that meet the search criterion.
 */

const DDENUMSURFACES_ALL = 0x00000001;
/*
 * A search hit is a surface that matches the surface description.
 */

const DDENUMSURFACES_MATCH = 0x00000002;
/*
 * A search hit is a surface that does not match the surface description.
 */

const DDENUMSURFACES_NOMATCH = 0x00000004;
/*
 * Enumerate the first surface that can be created which meets the search criterion.
 */

const DDENUMSURFACES_CANBECREATED = 0x00000008;
/*
 * Enumerate the surfaces that already exist that meet the search criterion.
 */

const DDENUMSURFACES_DOESEXIST = 0x00000010;

/****************************************************************************
 *
 * DIRECTDRAW SETDISPLAYMODE FLAGS
 *
 ****************************************************************************/

/*
 * The desired mode is a standard VGA mode
 */

const DDSDM_STANDARDVGAMODE = 0x00000001;

/****************************************************************************
 *
 * DIRECTDRAW ENUMDISPLAYMODES FLAGS
 *
 ****************************************************************************/

/*
 * Enumerate Modes with different refresh rates.  EnumDisplayModes guarantees
 * that a particular mode will be enumerated only once.  This flag specifies whether
 * the refresh rate is taken into account when determining if a mode is unique.
 */

const DDEDM_REFRESHRATES = 0x00000001;
/*
 * Enumerate VGA modes. Specify this flag if you wish to enumerate supported VGA
 * modes such as mode 0x13 in addition to the usual ModeX modes (which are always
 * enumerated if the application has previously called SetCooperativeLevel with the
 * DDSCL_ALLOWMODEX flag set).
 */

const DDEDM_STANDARDVGAMODES = 0x00000002;

/****************************************************************************
 *
 * DIRECTDRAW SETCOOPERATIVELEVEL FLAGS
 *
 ****************************************************************************/

/*
 * Exclusive mode owner will be responsible for the entire primary surface.
 * GDI can be ignored. used with DD
 */

const DDSCL_FULLSCREEN = 0x00000001;
/*
 * allow CTRL_ALT_DEL to work while in fullscreen exclusive mode
 */

const DDSCL_ALLOWREBOOT = 0x00000002;
/*
 * prevents DDRAW from modifying the application window.
 * prevents DDRAW from minimize/restore the application window on activation.
 */

const DDSCL_NOWINDOWCHANGES = 0x00000004;
/*
 * app wants to work as a regular Windows application
 */

const DDSCL_NORMAL = 0x00000008;
/*
 * app wants exclusive access
 */

const DDSCL_EXCLUSIVE = 0x00000010;

/*
 * app can deal with non-windows display modes
 */

const DDSCL_ALLOWMODEX = 0x00000040;
/*
 * this window will receive the focus messages
 */

const DDSCL_SETFOCUSWINDOW = 0x00000080;
/*
 * this window is associated with the DDRAW object and will
 * cover the screen in fullscreen mode
 */

const DDSCL_SETDEVICEWINDOW = 0x00000100;
/*
 * app wants DDRAW to create a window to be associated with the
 * DDRAW object
 */

const DDSCL_CREATEDEVICEWINDOW = 0x00000200;
/*
 * App explicitly asks DDRAW/D3D to be multithread safe. This makes D3D
 * take the global crtisec more frequently.
 */

const DDSCL_MULTITHREADED = 0x00000400;
/*
 * App specifies that it would like to keep the FPU set up for optimal Direct3D
 * performance (single precision and exceptions disabled) so Direct3D
 * does not need to explicitly set the FPU each time. This is assumed by
 * default in DirectX 7. See also DDSCL_FPUPRESERVE
 */

const DDSCL_FPUSETUP = 0x00000800;
/*
 * App specifies that it needs either double precision FPU or FPU exceptions
 * enabled. This makes Direct3D explicitly set the FPU state eah time it is
 * called. Setting the flag will reduce Direct3D performance. The flag is
 * assumed by default in DirectX 6 and earlier. See also DDSCL_FPUSETUP
 */

const DDSCL_FPUPRESERVE = 0x00001000;

/****************************************************************************
 *
 * DIRECTDRAW BLT FLAGS
 *
 ****************************************************************************/

/*
 * Use the alpha information in the pixel format or the alpha channel surface
 * attached to the destination surface as the alpha channel for this blt.
 */

const DDBLT_ALPHADEST = 0x00000001;
/*
 * Use the dwConstAlphaDest field in the DDBLTFX structure as the alpha channel
 * for the destination surface for this blt.
 */

const DDBLT_ALPHADESTCONSTOVERRIDE = 0x00000002;
/*
 * The NEG suffix indicates that the destination surface becomes more
 * transparent as the alpha value increases. (0 is opaque)
 */

const DDBLT_ALPHADESTNEG = 0x00000004;
/*
 * Use the lpDDSAlphaDest field in the DDBLTFX structure as the alpha
 * channel for the destination for this blt.
 */

const DDBLT_ALPHADESTSURFACEOVERRIDE = 0x00000008;
/*
 * Use the dwAlphaEdgeBlend field in the DDBLTFX structure as the alpha channel
 * for the edges of the image that border the color key colors.
 */

const DDBLT_ALPHAEDGEBLEND = 0x00000010;
/*
 * Use the alpha information in the pixel format or the alpha channel surface
 * attached to the source surface as the alpha channel for this blt.
 */

const DDBLT_ALPHASRC = 0x00000020;
/*
 * Use the dwConstAlphaSrc field in the DDBLTFX structure as the alpha channel
 * for the source for this blt.
 */

const DDBLT_ALPHASRCCONSTOVERRIDE = 0x00000040;
/*
 * The NEG suffix indicates that the source surface becomes more transparent
 * as the alpha value increases. (0 is opaque)
 */

const DDBLT_ALPHASRCNEG = 0x00000080;
/*
 * Use the lpDDSAlphaSrc field in the DDBLTFX structure as the alpha channel
 * for the source for this blt.
 */

const DDBLT_ALPHASRCSURFACEOVERRIDE = 0x00000100;
/*
 * Do this blt asynchronously through the FIFO in the order received.  If
 * there is no room in the hardware FIFO fail the call.
 */

const DDBLT_ASYNC = 0x00000200;
/*
 * Uses the dwFillColor field in the DDBLTFX structure as the RGB color
 * to fill the destination rectangle on the destination surface with.
 */

const DDBLT_COLORFILL = 0x00000400;
/*
 * Uses the dwDDFX field in the DDBLTFX structure to specify the effects
 * to use for the blt.
 */

const DDBLT_DDFX = 0x00000800;
/*
 * Uses the dwDDROPS field in the DDBLTFX structure to specify the ROPS
 * that are not part of the Win32 API.
 */

const DDBLT_DDROPS = 0x00001000;
/*
 * Use the color key associated with the destination surface.
 */

const DDBLT_KEYDEST = 0x00002000;
/*
 * Use the dckDestColorkey field in the DDBLTFX structure as the color key
 * for the destination surface.
 */

const DDBLT_KEYDESTOVERRIDE = 0x00004000;
/*
 * Use the color key associated with the source surface.
 */

const DDBLT_KEYSRC = 0x00008000;
/*
 * Use the dckSrcColorkey field in the DDBLTFX structure as the color key
 * for the source surface.
 */

const DDBLT_KEYSRCOVERRIDE = 0x00010000;
/*
 * Use the dwROP field in the DDBLTFX structure for the raster operation
 * for this blt.  These ROPs are the same as the ones defined in the Win32 API.
 */

const DDBLT_ROP = 0x00020000;
/*
 * Use the dwRotationAngle field in the DDBLTFX structure as the angle
 * (specified in 1/100th of a degree) to rotate the surface.
 */

const DDBLT_ROTATIONANGLE = 0x00040000;
/*
 * Z-buffered blt using the z-buffers attached to the source and destination
 * surfaces and the dwZBufferOpCode field in the DDBLTFX structure as the
 * z-buffer opcode.
 */

const DDBLT_ZBUFFER = 0x00080000;
/*
 * Z-buffered blt using the dwConstDest Zfield and the dwZBufferOpCode field
 * in the DDBLTFX structure as the z-buffer and z-buffer opcode respectively
 * for the destination.
 */

const DDBLT_ZBUFFERDESTCONSTOVERRIDE = 0x00100000;
/*
 * Z-buffered blt using the lpDDSDestZBuffer field and the dwZBufferOpCode
 * field in the DDBLTFX structure as the z-buffer and z-buffer opcode
 * respectively for the destination.
 */

const DDBLT_ZBUFFERDESTOVERRIDE = 0x00200000;
/*
 * Z-buffered blt using the dwConstSrcZ field and the dwZBufferOpCode field
 * in the DDBLTFX structure as the z-buffer and z-buffer opcode respectively
 * for the source.
 */

const DDBLT_ZBUFFERSRCCONSTOVERRIDE = 0x00400000;
/*
 * Z-buffered blt using the lpDDSSrcZBuffer field and the dwZBufferOpCode
 * field in the DDBLTFX structure as the z-buffer and z-buffer opcode
 * respectively for the source.
 */

const DDBLT_ZBUFFERSRCOVERRIDE = 0x00800000;
/*
 * wait until the device is ready to handle the blt
 * this will cause blt to not return DDERR_WASSTILLDRAWING
 */

const DDBLT_WAIT = 0x01000000;
/*
 * Uses the dwFillDepth field in the DDBLTFX structure as the depth value
 * to fill the destination rectangle on the destination Z-buffer surface
 * with.
 */

const DDBLT_DEPTHFILL = 0x02000000;

/*
 * Return immediately (with DDERR_WASSTILLDRAWING) if the device is not
 * ready to schedule the blt at the time Blt() is called.
 */

const DDBLT_DONOTWAIT = 0x08000000;
/*
 * These flags indicate a presentation blt (i.e. a blt
 * that moves surface contents from an offscreen back buffer to the primary
 * surface). The driver is not allowed to "queue"  more than three such blts.
 * The "end" of the presentation blt is indicated, since the
 * blt may be clipped, in which case the runtime will call the driver with 
 * several blts. All blts (even if not clipped) are tagged with DDBLT_PRESENTATION
 * and the last (even if not clipped) additionally with DDBLT_LAST_PRESENTATION.
 * Thus the true rule is that the driver must not schedule a DDBLT_PRESENTATION
 * blt if there are 3 or more DDBLT_PRESENTLAST blts in the hardware pipe.
 * If there are such blts in the pipe, the driver should return DDERR_WASSTILLDRAWING
 * until the oldest queued DDBLT_LAST_PRESENTATION blts has been retired (i.e. the
 * pixels have been actually written to the primary surface). Once the oldest blt
 * has been retired, the driver is free to schedule the current blt.
 * The goal is to provide a mechanism whereby the device's hardware queue never
 * gets more than 3 frames ahead of the frames being generated by the application.
 * When excessive queueing occurs, applications become unusable because the application
 * visibly lags user input, and such problems make windowed interactive applications impossible.
 * Some drivers may not have sufficient knowledge of their hardware's FIFO to know
 * when a certain blt has been retired. Such drivers should code cautiously, and 
 * simply not allow any frames to be queued at all. DDBLT_LAST_PRESENTATION should cause
 * such drivers to return DDERR_WASSTILLDRAWING until the accelerator is completely
 * finished- exactly as if the application had called Lock on the source surface
 * before calling Blt. 
 * In other words, the driver is allowed and encouraged to 
 * generate as much latency as it can, but never more than 3 frames worth.
 * Implementation detail: Drivers should count blts against the SOURCE surface, not
 * against the primary surface. This enables multiple parallel windowed application
 * to function more optimally.
 * This flag is passed only to DX8 or higher drivers.
 *
 * APPLICATIONS DO NOT SET THESE FLAGS. THEY ARE SET BY THE DIRECTDRAW RUNTIME.
 * 
 */
const DDBLT_PRESENTATION = 0x10000000;

const DDBLT_LAST_PRESENTATION = 0x20000000;
/*
 * If DDBLT_EXTENDED_FLAGS is set, then the driver should re-interpret
 * other flags according to the definitions that follow.
 * For example, bit 0 (0x00000001L) means DDBLT_ALPHADEST, unless
 * DDBLT_EXTENDED_FLAGS is also set, in which case bit 0 means
 * DDBLT_EXTENDED_LINEAR_CONTENT.
 * Only DirectX9 and higher drivers will be given extended blt flags.
 * Only flags explicitly mentioned here should be re-interpreted.
 * All other flags retain their original meanings.
 *
 * List of re-interpreted flags:
 *
 * Bit Hex value   New meaning								  old meaning
 * ---------------------------------------------------------------
 *  2  0x00000004  DDBLT_EXTENDED_LINEAR_CONTENT				DDBLT_ALPHADESTNEG
 *  4  0x00000010  DDBLT_EXTENDED_PRESENTATION_STRETCHFACTOR	DDBLT_ALPHAEDGEBLEND
 *
 *
 * NOTE: APPLICATIONS SHOULD NOT SET THIS FLAG. THIS FLAG IS INTENDED
 * FOR USE BY THE DIRECT3D RUNTIME.
 */

const DDBLT_EXTENDED_FLAGS = 0x40000000;
/*
 * EXTENDED FLAG. SEE DEFINITION OF DDBLT_EXTENDED_FLAGS.
 * This flag indidcates that the source surface contains content in a
 * linear color space. The driver may perform gamma correction to the
 * desktop color space (i.e. sRGB, gamma 2.2) as part of this blt.
 * If the device can perform such a conversion as part of the copy,
 * the driver should also set D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION
 *
 * NOTE: APPLICATIONS SHOULD NOT SET THIS FLAG. THIS FLAG IS INTENDED
 * FOR USE BY THE DIRECT3D RUNTIME. Use IDirect3DSwapChain9::Present
 * and specify D3DPRESENT_LINEAR_CONTENT in order to use this functionality.
 */
 

const DDBLT_EXTENDED_LINEAR_CONTENT = 0x00000004;

/****************************************************************************
 *
 * BLTFAST FLAGS
 *
 ****************************************************************************/

const DDBLTFAST_NOCOLORKEY = 0x00000000;
const DDBLTFAST_SRCCOLORKEY = 0x00000001;
const DDBLTFAST_DESTCOLORKEY = 0x00000002;
const DDBLTFAST_WAIT = 0x00000010;

const DDBLTFAST_DONOTWAIT = 0x00000020;
/****************************************************************************
 *
 * FLIP FLAGS
 *
 ****************************************************************************/


const DDFLIP_WAIT = 0x00000001;
/*
 * Indicates that the target surface contains the even field of video data.
 * This flag is only valid with an overlay surface.
 */

const DDFLIP_EVEN = 0x00000002;
/*
 * Indicates that the target surface contains the odd field of video data.
 * This flag is only valid with an overlay surface.
 */

const DDFLIP_ODD = 0x00000004;
/*
 * Causes DirectDraw to perform the physical flip immediately and return
 * to the application. Typically, what was the front buffer but is now the back
 * buffer will still be visible (depending on timing) until the next vertical
 * retrace. Subsequent operations involving the two flipped surfaces will
 * not check to see if the physical flip has finished (i.e. will not return
 * DDERR_WASSTILLDRAWING for that reason (but may for other reasons)).
 * This allows an application to perform Flips at a higher frequency than the
 * monitor refresh rate, but may introduce visible artifacts.
 * Only effective if DDCAPS2_FLIPNOVSYNC is set. If that bit is not set,
 * DDFLIP_NOVSYNC has no effect.
 */

const DDFLIP_NOVSYNC = 0x00000008;

/*
 * Flip Interval Flags. These flags indicate how many vertical retraces to wait between
 * each flip. The default is one. DirectDraw will return DDERR_WASSTILLDRAWING for each
 * surface involved in the flip until the specified number of vertical retraces has
 * ocurred. Only effective if DDCAPS2_FLIPINTERVAL is set. If that bit is not set,
 * DDFLIP_INTERVALn has no effect.
 */

/*
 * DirectDraw will flip on every other vertical sync
 */

const DDFLIP_INTERVAL2 = 0x02000000;

/*
 * DirectDraw will flip on every third vertical sync
 */

const DDFLIP_INTERVAL3 = 0x03000000;

/*
 * DirectDraw will flip on every fourth vertical sync
 */

const DDFLIP_INTERVAL4 = 0x04000000;
/*
 * DirectDraw will flip and display a main stereo surface
 */

const DDFLIP_STEREO = 0x00000010;
/*
 * On IDirectDrawSurface7 and higher interfaces, the default is DDFLIP_WAIT. If you wish
 * to override the default and use time when the accelerator is busy (as denoted by
 * the DDERR_WASSTILLDRAWING return code) then use DDFLIP_DONOTWAIT.
 */

const DDFLIP_DONOTWAIT = 0x00000020;

/****************************************************************************
 *
 * DIRECTDRAW SURFACE OVERLAY FLAGS
 *
 ****************************************************************************/

/*
 * Use the alpha information in the pixel format or the alpha channel surface
 * attached to the destination surface as the alpha channel for the
 * destination overlay.
 */

const DDOVER_ALPHADEST = 0x00000001;
/*
 * Use the dwConstAlphaDest field in the DDOVERLAYFX structure as the
 * destination alpha channel for this overlay.
 */

const DDOVER_ALPHADESTCONSTOVERRIDE = 0x00000002;
/*
 * The NEG suffix indicates that the destination surface becomes more
 * transparent as the alpha value increases.
 */

const DDOVER_ALPHADESTNEG = 0x00000004;
/*
 * Use the lpDDSAlphaDest field in the DDOVERLAYFX structure as the alpha
 * channel destination for this overlay.
 */

const DDOVER_ALPHADESTSURFACEOVERRIDE = 0x00000008;
/*
 * Use the dwAlphaEdgeBlend field in the DDOVERLAYFX structure as the alpha
 * channel for the edges of the image that border the color key colors.
 */

const DDOVER_ALPHAEDGEBLEND = 0x00000010;
/*
 * Use the alpha information in the pixel format or the alpha channel surface
 * attached to the source surface as the source alpha channel for this overlay.
 */

const DDOVER_ALPHASRC = 0x00000020;
/*
 * Use the dwConstAlphaSrc field in the DDOVERLAYFX structure as the source
 * alpha channel for this overlay.
 */

const DDOVER_ALPHASRCCONSTOVERRIDE = 0x00000040;
/*
 * The NEG suffix indicates that the source surface becomes more transparent
 * as the alpha value increases.
 */

const DDOVER_ALPHASRCNEG = 0x00000080;
/*
 * Use the lpDDSAlphaSrc field in the DDOVERLAYFX structure as the alpha channel
 * source for this overlay.
 */

const DDOVER_ALPHASRCSURFACEOVERRIDE = 0x00000100;
/*
 * Turn this overlay off.
 */

const DDOVER_HIDE = 0x00000200;
/*
 * Use the color key associated with the destination surface.
 */

const DDOVER_KEYDEST = 0x00000400;
/*
 * Use the dckDestColorkey field in the DDOVERLAYFX structure as the color key
 * for the destination surface
 */

const DDOVER_KEYDESTOVERRIDE = 0x00000800;
/*
 * Use the color key associated with the source surface.
 */

const DDOVER_KEYSRC = 0x00001000;
/*
 * Use the dckSrcColorkey field in the DDOVERLAYFX structure as the color key
 * for the source surface.
 */

const DDOVER_KEYSRCOVERRIDE = 0x00002000;
/*
 * Turn this overlay on.
 */

const DDOVER_SHOW = 0x00004000;
/*
 * Add a dirty rect to an emulated overlayed surface.
 */

const DDOVER_ADDDIRTYRECT = 0x00008000;
/*
 * Redraw all dirty rects on an emulated overlayed surface.
 */

const DDOVER_REFRESHDIRTYRECTS = 0x00010000;
/*
 * Redraw the entire surface on an emulated overlayed surface.
 */

const DDOVER_REFRESHALL = 0x00020000;

/*
 * Use the overlay FX flags to define special overlay FX
 */

const DDOVER_DDFX = 0x00080000;
/*
 * Autoflip the overlay when ever the video port autoflips
 */

const DDOVER_AUTOFLIP = 0x00100000;
/*
 * Display each field of video port data individually without
 * causing any jittery artifacts
 */

const DDOVER_BOB = 0x00200000;
/*
 * Indicates that bob/weave decisions should not be overridden by other
 * interfaces.
 */

const DDOVER_OVERRIDEBOBWEAVE = 0x00400000;
/*
 * Indicates that the surface memory is composed of interleaved fields.
 */

const DDOVER_INTERLEAVED = 0x00800000;
/*
 * Indicates that bob will be performed using hardware rather than
 * software or emulated.
 */

const DDOVER_BOBHARDWARE = 0x01000000;
/*
 * Indicates that overlay FX structure contains valid ARGB scaling factors.
 */

const DDOVER_ARGBSCALEFACTORS = 0x02000000;
/*
 * Indicates that ARGB scaling factors can be degraded to fit driver capabilities.
 */

const DDOVER_DEGRADEARGBSCALING = 0x04000000;

/****************************************************************************
 *
 * DIRECTDRAWSURFACE LOCK FLAGS
 *
 ****************************************************************************/

/*
 * The default.  Set to indicate that Lock should return a valid memory pointer
 * to the top of the specified rectangle.  If no rectangle is specified then a
 * pointer to the top of the surface is returned.
 */

const DDLOCK_SURFACEMEMORYPTR = 0x00000000;
/*
 * Set to indicate that Lock should wait until it can obtain a valid memory
 * pointer before returning.  If this bit is set, Lock will never return
 * DDERR_WASSTILLDRAWING.
 */

const DDLOCK_WAIT = 0x00000001;
/*
 * Set if an event handle is being passed to Lock.  Lock will trigger the event
 * when it can return the surface memory pointer requested.
 */

const DDLOCK_EVENT = 0x00000002;
/*
 * Indicates that the surface being locked will only be read from.
 */

const DDLOCK_READONLY = 0x00000010;
/*
 * Indicates that the surface being locked will only be written to
 */

const DDLOCK_WRITEONLY = 0x00000020;

/*
 * Indicates that a system wide lock should not be taken when this surface
 * is locked. This has several advantages (cursor responsiveness, ability
 * to call more Windows functions, easier debugging) when locking video
 * memory surfaces. However, an application specifying this flag must
 * comply with a number of conditions documented in the help file.
 * Furthermore, this flag cannot be specified when locking the primary.
 */

const DDLOCK_NOSYSLOCK = 0x00000800;
/*
 * Used only with Direct3D Vertex Buffer Locks. Indicates that no vertices
 * that were referred to in Draw*PrimtiveVB calls since the start of the
 * frame (or the last lock without this flag) will be modified during the
 * lock. This can be useful when one is only appending data to the vertex
 * buffer
 */

const DDLOCK_NOOVERWRITE = 0x00001000;
/*
 * Indicates that no assumptions will be made about the contents of the
 * surface or vertex buffer during this lock.
 * This enables two things:
 * -	Direct3D or the driver may provide an alternative memory
 *	  area as the vertex buffer. This is useful when one plans to clear the
 *	  contents of the vertex buffer and fill in new data.
 * -	Drivers sometimes store surface data in a re-ordered format.
 *	  When the application locks the surface, the driver is forced to un-re-order
 *	  the surface data before allowing the application to see the surface contents.
 *	  This flag is a hint to the driver that it can skip the un-re-ordering process
 *	  since the application plans to overwrite every single pixel in the surface
 *	  or locked rectangle (and so erase any un-re-ordered pixels anyway).
 *	  Applications should always set this flag when they intend to overwrite the entire
 *	  surface or locked rectangle.
 */
 /*
const DDLOCK_DISCARDCONTENTS = 0x00002000;
  * DDLOCK_OKTOSWAP is an older, less informative name for DDLOCK_DISCARDCONTENTS
  */

const DDLOCK_OKTOSWAP = 0x00002000;
/*
 * On IDirectDrawSurface7 and higher interfaces, the default is DDLOCK_WAIT. If you wish
 * to override the default and use time when the accelerator is busy (as denoted by
 * the DDERR_WASSTILLDRAWING return code) then use DDLOCK_DONOTWAIT.
 */

const DDLOCK_DONOTWAIT = 0x00004000;
/*
 * This indicates volume texture lock with front and back specified.
 */

const DDLOCK_HASVOLUMETEXTUREBOXRECT = 0x00008000;
/*
 * This indicates that the driver should not update dirty rect information for this lock.
 */

const DDLOCK_NODIRTYUPDATE = 0x00010000;

/****************************************************************************
 *
 * DIRECTDRAWSURFACE PAGELOCK FLAGS
 *
 ****************************************************************************/

/*
 * No flags defined at present
 */


/****************************************************************************
 *
 * DIRECTDRAWSURFACE PAGEUNLOCK FLAGS
 *
 ****************************************************************************/

/*
 * No flags defined at present
 */


/****************************************************************************
 *
 * DIRECTDRAWSURFACE BLT FX FLAGS
 *
 ****************************************************************************/

/*
 * If stretching, use arithmetic stretching along the Y axis for this blt.
 */

const DDBLTFX_ARITHSTRETCHY = 0x00000001;
/*
 * Do this blt mirroring the surface left to right.  Spin the
 * surface around its y-axis.
 */

const DDBLTFX_MIRRORLEFTRIGHT = 0x00000002;
/*
 * Do this blt mirroring the surface up and down.  Spin the surface
 * around its x-axis.
 */

const DDBLTFX_MIRRORUPDOWN = 0x00000004;
/*
 * Schedule this blt to avoid tearing.
 */

const DDBLTFX_NOTEARING = 0x00000008;
/*
 * Do this blt rotating the surface one hundred and eighty degrees.
 */

const DDBLTFX_ROTATE180 = 0x00000010;
/*
 * Do this blt rotating the surface two hundred and seventy degrees.
 */

const DDBLTFX_ROTATE270 = 0x00000020;
/*
 * Do this blt rotating the surface ninety degrees.
 */

const DDBLTFX_ROTATE90 = 0x00000040;
/*
 * Do this z blt using dwZBufferLow and dwZBufferHigh as  range values
 * specified to limit the bits copied from the source surface.
 */

const DDBLTFX_ZBUFFERRANGE = 0x00000080;
/*
 * Do this z blt adding the dwZBufferBaseDest to each of the sources z values
 * before comparing it with the desting z values.
 */

const DDBLTFX_ZBUFFERBASEDEST = 0x00000100;
/****************************************************************************
 *
 * DIRECTDRAWSURFACE OVERLAY FX FLAGS
 *
 ****************************************************************************/

/*
 * If stretching, use arithmetic stretching along the Y axis for this overlay.
 */

const DDOVERFX_ARITHSTRETCHY = 0x00000001;
/*
 * Mirror the overlay across the vertical axis
 */

const DDOVERFX_MIRRORLEFTRIGHT = 0x00000002;
/*
 * Mirror the overlay across the horizontal axis
 */

const DDOVERFX_MIRRORUPDOWN = 0x00000004;
/*
 * Deinterlace the overlay, if possible
 */

const DDOVERFX_DEINTERLACE = 0x00000008;

/****************************************************************************
 *
 * DIRECTDRAW WAITFORVERTICALBLANK FLAGS
 *
 ****************************************************************************/

/*
 * return when the vertical blank interval begins
 */

const DDWAITVB_BLOCKBEGIN = 0x00000001;
/*
 * set up an event to trigger when the vertical blank begins
 */

const DDWAITVB_BLOCKBEGINEVENT = 0x00000002;
/*
 * return when the vertical blank interval ends and display begins
 */

const DDWAITVB_BLOCKEND = 0x00000004;
/****************************************************************************
 *
 * DIRECTDRAW GETFLIPSTATUS FLAGS
 *
 ****************************************************************************/

/*
 * is it OK to flip now?
 */

const DDGFS_CANFLIP = 0x00000001;
/*
 * is the last flip finished?
 */

const DDGFS_ISFLIPDONE = 0x00000002;
/****************************************************************************
 *
 * DIRECTDRAW GETBLTSTATUS FLAGS
 *
 ****************************************************************************/

/*
 * is it OK to blt now?
 */

const DDGBS_CANBLT = 0x00000001;
/*
 * is the blt to the surface finished?
 */

const DDGBS_ISBLTDONE = 0x00000002;

/****************************************************************************
 *
 * DIRECTDRAW ENUMOVERLAYZORDER FLAGS
 *
 ****************************************************************************/

/*
 * Enumerate overlays back to front.
 */

const DDENUMOVERLAYZ_BACKTOFRONT = 0x00000000;
/*
 * Enumerate overlays front to back
 */

const DDENUMOVERLAYZ_FRONTTOBACK = 0x00000001;
/****************************************************************************
 *
 * DIRECTDRAW UPDATEOVERLAYZORDER FLAGS
 *
 ****************************************************************************/

/*
 * Send overlay to front
 */

const DDOVERZ_SENDTOFRONT = 0x00000000;
/*
 * Send overlay to back
 */

const DDOVERZ_SENDTOBACK = 0x00000001;
/*
 * Move Overlay forward
 */

const DDOVERZ_MOVEFORWARD = 0x00000002;
/*
 * Move Overlay backward
 */

const DDOVERZ_MOVEBACKWARD = 0x00000003;
/*
 * Move Overlay in front of relative surface
 */

const DDOVERZ_INSERTINFRONTOF = 0x00000004;
/*
 * Move Overlay in back of relative surface
 */

const DDOVERZ_INSERTINBACKOF = 0x00000005;

/****************************************************************************
 *
 * DIRECTDRAW SETGAMMARAMP FLAGS
 *
 ****************************************************************************/

/*
 * Request calibrator to adjust the gamma ramp according to the physical
 * properties of the display so that the result should appear identical
 * on all systems.
 */

const DDSGR_CALIBRATE = 0x00000001;

/****************************************************************************
 *
 * DIRECTDRAW STARTMODETEST FLAGS
 *
 ****************************************************************************/

/*
 * Indicates that the mode being tested has passed
 */

const DDSMT_ISTESTREQUIRED = 0x00000001;

/****************************************************************************
 *
 * DIRECTDRAW EVALUATEMODE FLAGS
 *
 ****************************************************************************/

/*
 * Indicates that the mode being tested has passed
 */

const DDEM_MODEPASSED = 0x00000001;
/*
 * Indicates that the mode being tested has failed
 */

const DDEM_MODEFAILED = 0x00000002;


/*===========================================================================
*
*
* DIRECTDRAW RETURN CODES
*
* The return values from DirectDraw Commands and Surface that return an HRESULT
* are codes from DirectDraw concerning the results of the action
* requested by DirectDraw.
*
*==========================================================================*/

enum _FACDD = 0x876;
pure HRESULT MAKE_DDHRESULT(uint code)
{
	return MAKE_HRESULT( 1, _FACDD, code );
}

/// Create an HRESULT value from component pieces
pure HRESULT MAKE_HRESULT(uint sev, uint fac, uint code)
{
	return (sev << 31) | (fac << 16) | (code);
}


/****************************************************************************
*
* DIRECTDRAW ENUMCALLBACK RETURN VALUES
*
* EnumCallback returns are used to control the flow of the DIRECTDRAW and
* DIRECTDRAWSURFACE object enumerations.   They can only be returned by
* enumeration callback routines.
*
****************************************************************************/

/*
* stop the enumeration
*/
enum DDENUMRET_CANCEL = 0;

/*
* continue the enumeration
*/
enum DDENUMRET_OK = 1;

mixin(bringToCurrentScope!DDRESULT);

/****************************************************************************
*
* DIRECTDRAW ERRORS
*
* Errors are represented by negative values and cannot be combined.
*
****************************************************************************/
enum DDRESULT : HRESULT
{
	/*
	 * Status is OK
	 *
	 * Issued by: DirectDraw Commands and all callbacks
	 */
	DD_OK = S_OK,
	DD_FALSE = S_FALSE,

/*
 * This object is already initialized
 */
	DDERR_ALREADYINITIALIZED = MAKE_DDHRESULT(5),

/*
 * This surface can not be attached to the requested surface.
 */
	DDERR_CANNOTATTACHSURFACE = MAKE_DDHRESULT(10),

/*
 * This surface can not be detached from the requested surface.
 */
	DDERR_CANNOTDETACHSURFACE = MAKE_DDHRESULT(20),

/*
 * Support is currently not available.
 */
	DDERR_CURRENTLYNOTAVAIL = MAKE_DDHRESULT(40),

/*
 * An exception was encountered while performing the requested operation
 */
	DDERR_EXCEPTION = MAKE_DDHRESULT(55),

/*
 * Generic failure.
 */
	DDERR_GENERIC = E_FAIL,

/*
 * Height of rectangle provided is not a multiple of reqd alignment
 */
	DDERR_HEIGHTALIGN = MAKE_DDHRESULT(90),

/*
 * Unable to match primary surface creation request with existing
 * primary surface.
 */
	DDERR_INCOMPATIBLEPRIMARY = MAKE_DDHRESULT(95),

/*
 * One or more of the caps bits passed to the callback are incorrect.
 */
	DDERR_INVALIDCAPS = MAKE_DDHRESULT(100),

/*
 * DirectDraw does not support provided Cliplist.
 */
	DDERR_INVALIDCLIPLIST = MAKE_DDHRESULT(110),

/*
 * DirectDraw does not support the requested mode
 */
	DDERR_INVALIDMODE = MAKE_DDHRESULT(120),

/*
 * DirectDraw received a pointer that was an invalid DIRECTDRAW object.
 */
	DDERR_INVALIDOBJECT = MAKE_DDHRESULT(130),

/*
 * One or more of the parameters passed to the callback function are
 * incorrect.
 */
	DDERR_INVALIDPARAMS = E_INVALIDARG,

/*
 * pixel format was invalid as specified
 */
	DDERR_INVALIDPIXELFORMAT = MAKE_DDHRESULT(145),

/*
 * Rectangle provided was invalid.
 */
	DDERR_INVALIDRECT = MAKE_DDHRESULT(150),

/*
 * Operation could not be carried out because one or more surfaces are locked
 */
	DDERR_LOCKEDSURFACES = MAKE_DDHRESULT(160),

/*
 * There is no 3D present.
 */
	DDERR_NO3D = MAKE_DDHRESULT(170),

/*
 * Operation could not be carried out because there is no alpha accleration
 * hardware present or available.
 */
	DDERR_NOALPHAHW = MAKE_DDHRESULT(180),

/*
 * Operation could not be carried out because there is no stereo
 * hardware present or available.
 */
	DDERR_NOSTEREOHARDWARE = MAKE_DDHRESULT(181),

/*
 * Operation could not be carried out because there is no hardware
 * present which supports stereo surfaces
 */
	DDERR_NOSURFACELEFT = MAKE_DDHRESULT(182),



/*
 * no clip list available
 */
	DDERR_NOCLIPLIST = MAKE_DDHRESULT(205),

/*
 * Operation could not be carried out because there is no color conversion
 * hardware present or available.
 */
	DDERR_NOCOLORCONVHW = MAKE_DDHRESULT(210),

/*
 * Create function called without DirectDraw object method SetCooperativeLevel
 * being called.
 */
	DDERR_NOCOOPERATIVELEVELSET = MAKE_DDHRESULT(212),

/*
 * Surface doesn't currently have a color key
 */
	DDERR_NOCOLORKEY = MAKE_DDHRESULT(215),

/*
 * Operation could not be carried out because there is no hardware support
 * of the dest color key.
 */
	DDERR_NOCOLORKEYHW = MAKE_DDHRESULT(220),

/*
 * No DirectDraw support possible with current display driver
 */
	DDERR_NODIRECTDRAWSUPPORT = MAKE_DDHRESULT(222),

/*
 * Operation requires the application to have exclusive mode but the
 * application does not have exclusive mode.
 */
	DDERR_NOEXCLUSIVEMODE = MAKE_DDHRESULT(225),

/*
 * Flipping visible surfaces is not supported.
 */
	DDERR_NOFLIPHW = MAKE_DDHRESULT(230),

/*
 * There is no GDI present.
 */
	DDERR_NOGDI = MAKE_DDHRESULT(240),

/*
 * Operation could not be carried out because there is no hardware present
 * or available.
 */
	DDERR_NOMIRRORHW = MAKE_DDHRESULT(250),

/*
 * Requested item was not found
 */
	DDERR_NOTFOUND = MAKE_DDHRESULT(255),

/*
 * Operation could not be carried out because there is no overlay hardware
 * present or available.
 */
	DDERR_NOOVERLAYHW = MAKE_DDHRESULT(260),

/*
 * Operation could not be carried out because the source and destination
 * rectangles are on the same surface and overlap each other.
 */
	DDERR_OVERLAPPINGRECTS = MAKE_DDHRESULT(270),

/*
 * Operation could not be carried out because there is no appropriate raster
 * op hardware present or available.
 */
	DDERR_NORASTEROPHW = MAKE_DDHRESULT(280),

/*
 * Operation could not be carried out because there is no rotation hardware
 * present or available.
 */
	DDERR_NOROTATIONHW = MAKE_DDHRESULT(290),

/*
 * Operation could not be carried out because there is no hardware support
 * for stretching
 */
	DDERR_NOSTRETCHHW = MAKE_DDHRESULT(310),

/*
 * DirectDrawSurface is not in 4 bit color palette and the requested operation
 * requires 4 bit color palette.
 */
	DDERR_NOT4BITCOLOR = MAKE_DDHRESULT(316),

/*
 * DirectDrawSurface is not in 4 bit color index palette and the requested
 * operation requires 4 bit color index palette.
 */
	DDERR_NOT4BITCOLORINDEX = MAKE_DDHRESULT(317),

/*
 * DirectDraw Surface is not in 8 bit color mode and the requested operation
 * requires 8 bit color.
 */
	DDERR_NOT8BITCOLOR = MAKE_DDHRESULT(320),

/*
 * Operation could not be carried out because there is no texture mapping
 * hardware present or available.
 */
	DDERR_NOTEXTUREHW = MAKE_DDHRESULT(330),

/*
 * Operation could not be carried out because there is no hardware support
 * for vertical blank synchronized operations.
 */
	DDERR_NOVSYNCHW = MAKE_DDHRESULT(335),

/*
 * Operation could not be carried out because there is no hardware support
 * for zbuffer blting.
 */
	DDERR_NOZBUFFERHW = MAKE_DDHRESULT(340),

/*
 * Overlay surfaces could not be z layered based on their BltOrder because
 * the hardware does not support z layering of overlays.
 */
	DDERR_NOZOVERLAYHW = MAKE_DDHRESULT(350),

/*
 * The hardware needed for the requested operation has already been
 * allocated.
 */
	DDERR_OUTOFCAPS = MAKE_DDHRESULT(360),

/*
 * DirectDraw does not have enough memory to perform the operation.
 */
	DDERR_OUTOFMEMORY = E_OUTOFMEMORY,

/*
 * DirectDraw does not have enough memory to perform the operation.
 */
	DDERR_OUTOFVIDEOMEMORY = MAKE_DDHRESULT(380),

/*
 * hardware does not support clipped overlays
 */
	DDERR_OVERLAYCANTCLIP = MAKE_DDHRESULT(382),

/*
 * Can only have ony color key active at one time for overlays
 */
	DDERR_OVERLAYCOLORKEYONLYONEACTIVE = MAKE_DDHRESULT(384),

/*
 * Access to this palette is being refused because the palette is already
 * locked by another thread.
 */
	DDERR_PALETTEBUSY = MAKE_DDHRESULT(387),

/*
 * No src color key specified for this operation.
 */
	DDERR_COLORKEYNOTSET = MAKE_DDHRESULT(400),

/*
 * This surface is already attached to the surface it is being attached to.
 */
	DDERR_SURFACEALREADYATTACHED = MAKE_DDHRESULT(410),

/*
 * This surface is already a dependency of the surface it is being made a
 * dependency of.
 */
	DDERR_SURFACEALREADYDEPENDENT = MAKE_DDHRESULT(420),

/*
 * Access to this surface is being refused because the surface is already
 * locked by another thread.
 */
	DDERR_SURFACEBUSY = MAKE_DDHRESULT(430),

/*
 * Access to this surface is being refused because no driver exists
 * which can supply a pointer to the surface.
 * This is most likely to happen when attempting to lock the primary
 * surface when no DCI provider is present.
 * Will also happen on attempts to lock an optimized surface.
 */
	DDERR_CANTLOCKSURFACE = MAKE_DDHRESULT(435),

/*
 * Access to Surface refused because Surface is obscured.
 */
	DDERR_SURFACEISOBSCURED = MAKE_DDHRESULT(440),

/*
 * Access to this surface is being refused because the surface is gone.
 * The DIRECTDRAWSURFACE object representing this surface should
 * have Restore called on it.
 */
	DDERR_SURFACELOST = MAKE_DDHRESULT(450),

/*
 * The requested surface is not attached.
 */
	DDERR_SURFACENOTATTACHED = MAKE_DDHRESULT(460),

/*
 * Height requested by DirectDraw is too large.
 */
	DDERR_TOOBIGHEIGHT = MAKE_DDHRESULT(470),

/*
 * Size requested by DirectDraw is too large --  The individual height and
 * width are OK.
 */
	DDERR_TOOBIGSIZE = MAKE_DDHRESULT(480),

/*
 * Width requested by DirectDraw is too large.
 */
	DDERR_TOOBIGWIDTH = MAKE_DDHRESULT(490),

/*
 * Action not supported.
 */
	DDERR_UNSUPPORTED = E_NOTIMPL,

/*
 * Pixel format requested is unsupported by DirectDraw
 */
	DDERR_UNSUPPORTEDFORMAT = MAKE_DDHRESULT(510),

/*
 * Bitmask in the pixel format requested is unsupported by DirectDraw
 */
	DDERR_UNSUPPORTEDMASK = MAKE_DDHRESULT(520),

/*
 * The specified stream contains invalid data
 */
	DDERR_INVALIDSTREAM = MAKE_DDHRESULT(521),

/*
 * vertical blank is in progress
 */
	DDERR_VERTICALBLANKINPROGRESS = MAKE_DDHRESULT(537),

/*
 * Informs DirectDraw that the previous Blt which is transfering information
 * to or from this Surface is incomplete.
 */
	DDERR_WASSTILLDRAWING = MAKE_DDHRESULT(540),


/*
 * The specified surface type requires specification of the COMPLEX flag
 */
	DDERR_DDSCAPSCOMPLEXREQUIRED = MAKE_DDHRESULT(542),


/*
 * Rectangle provided was not horizontally aligned on reqd. boundary
 */
	DDERR_XALIGN = MAKE_DDHRESULT(560),

/*
 * The GUID passed to DirectDrawCreate is not a valid DirectDraw driver
 * identifier.
 */
	DDERR_INVALIDDIRECTDRAWGUID = MAKE_DDHRESULT(561),

/*
 * A DirectDraw object representing this driver has already been created
 * for this process.
 */
	DDERR_DIRECTDRAWALREADYCREATED = MAKE_DDHRESULT(562),

/*
 * A hardware only DirectDraw object creation was attempted but the driver
 * did not support any hardware.
 */
	DDERR_NODIRECTDRAWHW = MAKE_DDHRESULT(563),

/*
 * this process already has created a primary surface
 */
	DDERR_PRIMARYSURFACEALREADYEXISTS = MAKE_DDHRESULT(564),

/*
 * software emulation not available.
 */
	DDERR_NOEMULATION = MAKE_DDHRESULT(565),

/*
 * region passed to Clipper::GetClipList is too small.
 */
	DDERR_REGIONTOOSMALL = MAKE_DDHRESULT(566),

/*
 * an attempt was made to set a clip list for a clipper objec that
 * is already monitoring an hwnd.
 */
	DDERR_CLIPPERISUSINGHWND = MAKE_DDHRESULT(567),

/*
 * No clipper object attached to surface object
 */
	DDERR_NOCLIPPERATTACHED = MAKE_DDHRESULT(568),

/*
 * Clipper notification requires an HWND or
 * no HWND has previously been set as the CooperativeLevel HWND.
 */
	DDERR_NOHWND = MAKE_DDHRESULT(569),

/*
 * HWND used by DirectDraw CooperativeLevel has been subclassed,
 * this prevents DirectDraw from restoring state.
 */
	DDERR_HWNDSUBCLASSED = MAKE_DDHRESULT(570),

/*
 * The CooperativeLevel HWND has already been set.
 * It can not be reset while the process has surfaces or palettes created.
 */
	DDERR_HWNDALREADYSET = MAKE_DDHRESULT(571),

/*
 * No palette object attached to this surface.
 */
	DDERR_NOPALETTEATTACHED = MAKE_DDHRESULT(572),

/*
 * No hardware support for 16 or 256 color palettes.
 */
	DDERR_NOPALETTEHW = MAKE_DDHRESULT(573),

/*
 * If a clipper object is attached to the source surface passed into a
 * BltFast call.
 */
	DDERR_BLTFASTCANTCLIP = MAKE_DDHRESULT(574),

/*
 * No blter.
 */
	DDERR_NOBLTHW = MAKE_DDHRESULT(575),

/*
 * No DirectDraw ROP hardware.
 */
	DDERR_NODDROPSHW = MAKE_DDHRESULT(576),

/*
 * returned when GetOverlayPosition is called on a hidden overlay
 */
	DDERR_OVERLAYNOTVISIBLE = MAKE_DDHRESULT(577),

/*
 * returned when GetOverlayPosition is called on a overlay that UpdateOverlay
 * has never been called on to establish a destionation.
 */
	DDERR_NOOVERLAYDEST = MAKE_DDHRESULT(578),

/*
 * returned when the position of the overlay on the destionation is no longer
 * legal for that destionation.
 */
	DDERR_INVALIDPOSITION = MAKE_DDHRESULT(579),

/*
 * returned when an overlay member is called for a non-overlay surface
 */
	DDERR_NOTAOVERLAYSURFACE = MAKE_DDHRESULT(580),

/*
 * An attempt was made to set the cooperative level when it was already
 * set to exclusive.
 */
	DDERR_EXCLUSIVEMODEALREADYSET = MAKE_DDHRESULT(581),

/*
 * An attempt has been made to flip a surface that is not flippable.
 */
	DDERR_NOTFLIPPABLE = MAKE_DDHRESULT(582),

/*
 * Can't duplicate primary & 3D surfaces, or surfaces that are implicitly
 * created.
 */
	DDERR_CANTDUPLICATE = MAKE_DDHRESULT(583),

/*
 * Surface was not locked.  An attempt to unlock a surface that was not
 * locked at all, or by this process, has been attempted.
 */
	DDERR_NOTLOCKED = MAKE_DDHRESULT(584),

/*
 * Windows can not create any more DCs, or a DC was requested for a paltte-indexed
 * surface when the surface had no palette AND the display mode was not palette-indexed
 * (in this case DirectDraw cannot select a proper palette into the DC)
 */
	DDERR_CANTCREATEDC = MAKE_DDHRESULT(585),

/*
 * No DC was ever created for this surface.
 */
	DDERR_NODC = MAKE_DDHRESULT(586),

/*
 * This surface can not be restored because it was created in a different
 * mode.
 */
	DDERR_WRONGMODE = MAKE_DDHRESULT(587),

/*
 * This surface can not be restored because it is an implicitly created
 * surface.
 */
	DDERR_IMPLICITLYCREATED = MAKE_DDHRESULT(588),

/*
 * The surface being used is not a palette-based surface
 */
	DDERR_NOTPALETTIZED = MAKE_DDHRESULT(589),


/*
 * The display is currently in an unsupported mode
 */
	DDERR_UNSUPPORTEDMODE = MAKE_DDHRESULT(590),

/*
 * Operation could not be carried out because there is no mip-map
 * texture mapping hardware present or available.
 */
	DDERR_NOMIPMAPHW = MAKE_DDHRESULT(591),

/*
 * The requested action could not be performed because the surface was of
 * the wrong type.
 */
	DDERR_INVALIDSURFACETYPE = MAKE_DDHRESULT(592),


/*
 * Device does not support optimized surfaces, therefore no video memory optimized surfaces
 */
	DDERR_NOOPTIMIZEHW = MAKE_DDHRESULT(600),

/*
 * Surface is an optimized surface, but has not yet been allocated any memory
 */
	DDERR_NOTLOADED = MAKE_DDHRESULT(601),

/*
 * Attempt was made to create or set a device window without first setting
 * the focus window
 */
	DDERR_NOFOCUSWINDOW = MAKE_DDHRESULT(602),

/*
 * Attempt was made to set a palette on a mipmap sublevel
 */
	DDERR_NOTONMIPMAPSUBLEVEL = MAKE_DDHRESULT(603),

/*
 * A DC has already been returned for this surface. Only one DC can be
 * retrieved per surface.
 */
	DDERR_DCALREADYCREATED = MAKE_DDHRESULT(620),

/*
 * An attempt was made to allocate non-local video memory from a device
 * that does not support non-local video memory.
 */
	DDERR_NONONLOCALVIDMEM = MAKE_DDHRESULT(630),

/*
 * The attempt to page lock a surface failed.
 */
	DDERR_CANTPAGELOCK = MAKE_DDHRESULT(640),


/*
 * The attempt to page unlock a surface failed.
 */
	DDERR_CANTPAGEUNLOCK = MAKE_DDHRESULT(660),

/*
 * An attempt was made to page unlock a surface with no outstanding page locks.
 */
	DDERR_NOTPAGELOCKED = MAKE_DDHRESULT(680),

/*
 * There is more data available than the specified buffer size could hold
 */
	DDERR_MOREDATA = MAKE_DDHRESULT(690),

/*
 * The data has expired and is therefore no longer valid.
 */
	DDERR_EXPIRED = MAKE_DDHRESULT(691),

/*
 * The mode test has finished executing.
 */
	DDERR_TESTFINISHED = MAKE_DDHRESULT(692),

/*
 * The mode test has switched to a new mode.
 */
	DDERR_NEWMODE = MAKE_DDHRESULT(693),

/*
 * D3D has not yet been initialized.
 */
	DDERR_D3DNOTINITIALIZED = MAKE_DDHRESULT(694),

/*
 * The video port is not active
 */
	DDERR_VIDEONOTACTIVE = MAKE_DDHRESULT(695),

/*
 * The monitor does not have EDID data.
 */
	DDERR_NOMONITORINFORMATION = MAKE_DDHRESULT(696),

/*
 * The driver does not enumerate display mode refresh rates.
 */
	DDERR_NODRIVERSUPPORT = MAKE_DDHRESULT(697),

/*
 * Surfaces created by one direct draw device cannot be used directly by
 * another direct draw device.
 */
	DDERR_DEVICEDOESNTOWNSURFACE = MAKE_DDHRESULT(699),



/*
 * An attempt was made to invoke an interface member of a DirectDraw object
 * created by CoCreateInstance() before it was initialized.
 */
	DDERR_NOTINITIALIZED = CO_E_NOTINITIALIZED
}