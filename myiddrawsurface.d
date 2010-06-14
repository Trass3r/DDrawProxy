/**
 *	
 */
module myiddrawsurface;

import ddraw;
import logger;

alias GUID* REFGUID; 

alias MyIDirectDrawSurfaceB!(1) MyIDirectDrawSurface; ///
alias MyIDirectDrawSurfaceB!(2) MyIDirectDrawSurface2; ///
alias MyIDirectDrawSurfaceB!(3) MyIDirectDrawSurface3; ///
alias MyIDirectDrawSurfaceB!(4) MyIDirectDrawSurface4; ///
alias MyIDirectDrawSurfaceB!(7) MyIDirectDrawSurface7; ///

class MyIDirectDrawSurfaceB(uint ver) : IDirectDrawSurfaceB!(ver)
{
private:
	static if (ver >= 4)
		alias LPDDSCAPS2 LPProperDDSCaps;
	else
		alias LPDDSCAPS LPProperDDSCaps;
	
	static if (ver >= 4)
		alias LPDDSURFACEDESC2 LPProperDDSurfaceDesc;
	else
		alias LPDDSURFACEDESC LPProperDDSurfaceDesc;

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

	
	alias IDirectDrawSurfaceB!(ver) BaseInterface;
	BaseInterface _lpDDSurface;

public:
	this(LPProperDirectDrawSurface* lplpDD)
	{
		_lpDDSurface = cast(BaseInterface) *lplpDD; // save the interface as a member
		*lplpDD = cast(LPProperDirectDrawSurface) cast(BaseInterface) this; // alter the given pointer to this class instance
		// it's crucial to cast to the base interface here
	}
	
	~this()
	{
		Logger.addEntry("surface destructed");
	}
extern(Windows):
	
	/// 
	override HRESULT QueryInterface(REFIID riid, LPVOID* ppvObj)
	{
		Logger.addEntry("MyIDirectDrawSurface.QueryInterface(", riid, ")");

		/+
		HRESULT hResult;

		if((hResult = _lpDD.QueryInterface(riid, ppvObj)) == S_OK)
		{
			if(*riid == IID_IDirectDrawSurface4)
			{
				MyIDirectDrawSurface4 lpDD = new MyIDirectDrawSurface4(cast(void**) ppvObj);
				ppvObj = cast(LPVOID*) lpDD;
			}
		}

		return hResult;
		+/
		auto res = _lpDDSurface.QueryInterface(riid, ppvObj);
		return res;
	}

	/// 
	override ULONG AddRef()
	{
		auto res = _lpDDSurface.AddRef();
		Logger.addEntry("MyIDirectDrawSurface.AddRef() = ", res);
		return res;
	}
	
	/// 
	override ULONG Release()
	{
		auto res = _lpDDSurface.Release();
		Logger.addEntry("MyIDirectDrawSurface.Release() = ", res);
		return res;
	}

	// IDirectDrawSurface methods

	/// 
	override HRESULT AddAttachedSurface(LPProperDirectDrawSurface lpDDSAttachedSurface)
	{
		Logger.addEntry("MyIDirectDrawSurface.AddAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT AddOverlayDirtyRect(LPRECT lpRect)
	{
		Logger.addEntry("MyIDirectDrawSurface.AddOverlayDirtyRect() = ", res);
		return res;
	}

	/// 
	override HRESULT Blt(LPRECT lpDestRect, LPProperDirectDrawSurface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwFlags, LPDDBLTFX lpDDBltFx)
	{
		Logger.addEntry("MyIDirectDrawSurface.Blt() = ", res);
		return res;
	}

	/// 
	override HRESULT BltBatch(LPDDBLTBATCH lpDDBltBatch, DWORD dwCount, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.BltBatch() = ", res);
		return res;
	}

	/// 
	override HRESULT BltFast(DWORD dwX, DWORD dwY, LPProperDirectDrawSurface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwTrans)
	{
		Logger.addEntry("MyIDirectDrawSurface.BltFast() = ", res);
		return res;
	}

	/// 
	override HRESULT DeleteAttachedSurface(DWORD dwFlags, LPProperDirectDrawSurface lpDDSAttachedSurface)
	{
		Logger.addEntry("MyIDirectDrawSurface.DeleteAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT EnumAttachedSurfaces(LPVOID lpContext, LPProperDDEnumSurfacesCallback lpEnumSurfacesCallback)
	{
		Logger.addEntry("MyIDirectDrawSurface.EnumAttachedSurfaces() = ", res);
		return res;
	}

	/// 
	override HRESULT EnumOverlayZOrders(DWORD dwFlags, LPVOID lpContext, LPProperDDEnumSurfacesCallback lpfnCallback)
	{
		Logger.addEntry("MyIDirectDrawSurface.EnumOverlayZOrders() = ", res);
		return res;
	}

	/// 
	override HRESULT Flip(LPProperDirectDrawSurface lpDDSurfaceTargetOverride, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.Flip() = ", res);
		return res;
	}

	/// 
	override HRESULT GetAttachedSurface(LPProperDDSCaps lpDDSCaps, LPProperDirectDrawSurface* lplpDDAttachedSurface)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT GetBltStatus(DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetBltStatus() = ", res);
		return res;
	}

	/// 
	override HRESULT GetCaps(LPProperDDSCaps lpDDSCaps)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetCaps() = ", res);
		return res;
	}

	/// 
	override HRESULT GetClipper(LPDIRECTDRAWCLIPPER* lplpDDClipper)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetClipper() = ", res);
		return res;
	}

	/// 
	override HRESULT GetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetColorKey() = ", res);
		return res;
	}

	/// 
	override HRESULT GetDC(HDC* lphDC)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetDC() = ", res);
		return res;
	}

	/// 
	override HRESULT GetFlipStatus(DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetFlipStatus() = ", res);
		return res;
	}

	/// 
	override HRESULT GetOverlayPosition(LPLONG lplX, LPLONG lplY)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetOverlayPosition() = ", res);
		return res;
	}

	/// 
	override HRESULT GetPalette(LPDIRECTDRAWPALETTE* lplpDDPalette)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetPalette() = ", res);
		return res;
	}

	/// 
	override HRESULT GetPixelFormat(LPDDPIXELFORMAT lpDDPixelFormat)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetPixelFormat() = ", res);
		return res;
	}

	/// 
	override HRESULT GetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetSurfaceDesc() = ", res);
		return res;
	}

	/// 
	override HRESULT Initialize(LPDIRECTDRAW lpDD, LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{
		Logger.addEntry("MyIDirectDrawSurface.Initialize() = ", res);
		return res;
	}

	/// 
	override HRESULT IsLost()
	{
		Logger.addEntry("MyIDirectDrawSurface.IsLost() = ", res);
		return res;
	}

	/// 
	override HRESULT Lock(LPRECT lpDestRect, LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags, HANDLE hEvent)
	{
		Logger.addEntry("MyIDirectDrawSurface.Lock() = ", res);
		return res;
	}

	/// 
	override HRESULT ReleaseDC(HDC hDC)
	{
		Logger.addEntry("MyIDirectDrawSurface.ReleaseDC() = ", res);
		return res;
	}

	/// 
	override HRESULT Restore()
	{
		Logger.addEntry("MyIDirectDrawSurface.Restore() = ", res);
		return res;
	}

	/// 
	override HRESULT SetClipper(LPDIRECTDRAWCLIPPER lpDDClipper)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetClipper() = ", res);
		return res;
	}

	/// 
	override HRESULT SetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetColorKey() = ", res);
		return res;
	}

	/// 
	override HRESULT SetOverlayPosition(LONG lX, LONG lY)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetOverlayPosition() = ", res);
		return res;
	}

	/// 
	override HRESULT SetPalette(LPDIRECTDRAWPALETTE lpDDPalette)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetPalette(", ") = ", res);
		return res;
	}

	/// 
	override HRESULT Unlock(LPRECT lpRect)
	{
		Logger.addEntry("MyIDirectDrawSurface.Unlock() = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlay(LPRECT lpSrcRect, LPProperDirectDrawSurface lpDDDestSurface, LPRECT lpDestRect, DWORD dwFlags, LPDDOVERLAYFX lpDDOverlayFx)
	{
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlay() = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlayDisplay(DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayDisplay() = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlayZOrder(DWORD dwFlags, LPProperDirectDrawSurface lpDDSReference)
	{
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayZOrder() = ", res);
		return res;
	}

static if (ver >= 2)	// Added in the v2 interface
{
	/// 
	override HRESULT GetDDInterface(LPVOID* lplpDD)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetDDInterface() = ", res);
		return res;
	}

	/// 
	override HRESULT PageLock(DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.PageLock() = ", res);
		return res;
	}

	/// 
	override HRESULT PageUnlock(DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.PageUnlock() = ", res);
		return res;
	}
}

static if (ver >= 3) // Added in the v3 interface
{
	/// 
	override HRESULT SetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetSurfaceDesc() = ", res);
		return res;
	}
}

static if (ver >= 4) // Added in the v4 interface
{
	/// 
	override HRESULT SetPrivateData(REFGUID guidTag, LPVOID lpData, DWORD cbSize, DWORD dwFlags)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetPrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT GetPrivateData(REFGUID guidTag, LPVOID lpBuffer, LPDWORD lpcbBufferSize)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetPrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT FreePrivateData(REFGUID guidTag)
	{
		Logger.addEntry("MyIDirectDrawSurface.FreePrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT GetUniquenessValue(LPDWORD lpValue)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetUniquenessValue() = ", res);
		return res;
	}

	/// 
	override HRESULT ChangeUniquenessValue()
	{
		Logger.addEntry("MyIDirectDrawSurface.ChangeUniquenessValue() = ", res);
		return res;
	}
}

static if (ver >= 7)
{
	/// 
	override HRESULT  SetPriority(DWORD dwPriority)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetPriority() = ", res);
		return res;
	}
	/// 
	override HRESULT  GetPriority(LPDWORD dwPriority)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetPriority() = ", res);
		return res;
	}
	/// 
	override HRESULT  SetLOD(DWORD dwLOD)
	{
		Logger.addEntry("MyIDirectDrawSurface.SetLOD() = ", res);
		return res;
	}
	/// 
	override HRESULT  GetLOD(LPDWORD dwLOD)
	{
		Logger.addEntry("MyIDirectDrawSurface.GetLOD() = ", res);
		return res;
	}
}
} // of class MyIDirectDrawSurface