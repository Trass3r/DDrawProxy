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
	{		auto res = _lpDDSurface.AddAttachedSurface(lpDDSAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.AddAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT AddOverlayDirtyRect(LPRECT lpRect)
	{		auto res = _lpDDSurface.AddOverlayDirtyRect(lpRect);
		Logger.addEntry("MyIDirectDrawSurface.AddOverlayDirtyRect() = ", res);
		return res;
	}

	/// 
	override HRESULT Blt(LPRECT lpDestRect, LPProperDirectDrawSurface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwFlags, LPDDBLTFX lpDDBltFx)
	{		auto res = _lpDDSurface.Blt(lpDestRect, lpDDSrcSurface, lpSrcRect, dwFlags, lpDDBltFx);
		Logger.addEntry("MyIDirectDrawSurface.Blt() = ", res);
		return res;
	}

	/// 
	override HRESULT BltBatch(LPDDBLTBATCH lpDDBltBatch, DWORD dwCount, DWORD dwFlags)
	{		auto res = _lpDDSurface.BltBatch(lpDDBltBatch, dwCount, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.BltBatch() = ", res);
		return res;
	}

	/// 
	override HRESULT BltFast(DWORD dwX, DWORD dwY, LPProperDirectDrawSurface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwTrans)
	{		auto res = _lpDDSurface.BltFast(dwX, dwY, lpDDSrcSurface, lpSrcRect, dwTrans);
		Logger.addEntry("MyIDirectDrawSurface.BltFast() = ", res);
		return res;
	}

	/// 
	override HRESULT DeleteAttachedSurface(DWORD dwFlags, LPProperDirectDrawSurface lpDDSAttachedSurface)
	{		auto res = _lpDDSurface.DeleteAttachedSurface(dwFlags, lpDDSAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.DeleteAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT EnumAttachedSurfaces(LPVOID lpContext, LPProperDDEnumSurfacesCallback lpEnumSurfacesCallback)
	{		auto res = _lpDDSurface.EnumAttachedSurfaces(lpContext, lpEnumSurfacesCallback);
		Logger.addEntry("MyIDirectDrawSurface.EnumAttachedSurfaces() = ", res);
		return res;
	}

	/// 
	override HRESULT EnumOverlayZOrders(DWORD dwFlags, LPVOID lpContext, LPProperDDEnumSurfacesCallback lpfnCallback)
	{		auto res = _lpDDSurface.EnumOverlayZOrders(dwFlags, lpContext, lpfnCallback);
		Logger.addEntry("MyIDirectDrawSurface.EnumOverlayZOrders() = ", res);
		return res;
	}

	/// 
	override HRESULT Flip(LPProperDirectDrawSurface lpDDSurfaceTargetOverride, DWORD dwFlags)
	{		auto res = _lpDDSurface.Flip(lpDDSurfaceTargetOverride, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.Flip() = ", res);
		return res;
	}

	/// 
	override HRESULT GetAttachedSurface(LPProperDDSCaps lpDDSCaps, LPProperDirectDrawSurface* lplpDDAttachedSurface)
	{		auto res = _lpDDSurface.GetAttachedSurface(lpDDSCaps, lplpDDAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.GetAttachedSurface() = ", res);
		return res;
	}

	/// 
	override HRESULT GetBltStatus(DWORD dwFlags)
	{		auto res = _lpDDSurface.GetBltStatus(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.GetBltStatus() = ", res);
		return res;
	}

	/// 
	override HRESULT GetCaps(LPProperDDSCaps lpDDSCaps)
	{		auto res = _lpDDSurface.GetCaps(lpDDSCaps);
		Logger.addEntry("MyIDirectDrawSurface.GetCaps() = ", res);
		return res;
	}

	/// 
	override HRESULT GetClipper(LPDIRECTDRAWCLIPPER* lplpDDClipper)
	{		auto res = _lpDDSurface.GetClipper(lplpDDClipper);
		Logger.addEntry("MyIDirectDrawSurface.GetClipper() = ", res);
		return res;
	}

	/// 
	override HRESULT GetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{		auto res = _lpDDSurface.GetColorKey(dwFlags, lpDDColorKey);
		Logger.addEntry("MyIDirectDrawSurface.GetColorKey(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override HRESULT GetDC(HDC* lphDC)
	{		auto res = _lpDDSurface.GetDC(lphDC);
		Logger.addEntry("MyIDirectDrawSurface.GetDC() = ", res);
		return res;
	}

	/// 
	override HRESULT GetFlipStatus(DWORD dwFlags)
	{		auto res = _lpDDSurface.GetFlipStatus(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.GetFlipStatus(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override HRESULT GetOverlayPosition(LPLONG lplX, LPLONG lplY)
	{		auto res = _lpDDSurface.GetOverlayPosition(lplX, lplY);
		Logger.addEntry("MyIDirectDrawSurface.GetOverlayPosition(", lplX, lplY, ") = ", res);
		return res;
	}

	/// 
	override HRESULT GetPalette(LPDIRECTDRAWPALETTE* lplpDDPalette)
	{		auto res = _lpDDSurface.GetPalette(lplpDDPalette);
		Logger.addEntry("MyIDirectDrawSurface.GetPalette() = ", res);
		return res;
	}

	/// 
	override HRESULT GetPixelFormat(LPDDPIXELFORMAT lpDDPixelFormat)
	{		auto res = _lpDDSurface.GetPixelFormat(lpDDPixelFormat);
		Logger.addEntry("MyIDirectDrawSurface.GetPixelFormat(", lpDDPixelFormat, ") = ", res);
		return res;
	}

	/// 
	override HRESULT GetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{		auto res = _lpDDSurface.GetSurfaceDesc(lpDDSurfaceDesc);
		Logger.addEntry("MyIDirectDrawSurface.GetSurfaceDesc(", lpDDSurfaceDesc, ") = ", res);
		return res;
	}

	/// 
	override HRESULT Initialize(LPDIRECTDRAW lpDD, LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{		auto res = _lpDDSurface.Initialize(lpDD, lpDDSurfaceDesc);
		Logger.addEntry("MyIDirectDrawSurface.Initialize() = ", res);
		return res;
	}

	/// 
	override HRESULT IsLost()
	{		auto res = _lpDDSurface.IsLost();
		Logger.addEntry("MyIDirectDrawSurface.IsLost() = ", res);
		return res;
	}

	/// 
	override HRESULT Lock(LPRECT lpDestRect, LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags, HANDLE hEvent)
	{		auto res = _lpDDSurface.Lock(lpDestRect, lpDDSurfaceDesc, dwFlags, hEvent);
		Logger.addEntry("MyIDirectDrawSurface.Lock(", lpDestRect, lpDDSurfaceDesc, dwFlags, hEvent, ") = ", res);
		return res;
	}

	/// 
	override HRESULT ReleaseDC(HDC hDC)
	{		auto res = _lpDDSurface.ReleaseDC(hDC);
		Logger.addEntry("MyIDirectDrawSurface.ReleaseDC() = ", res);
		return res;
	}

	/// 
	override HRESULT Restore()
	{		auto res = _lpDDSurface.Restore();
		Logger.addEntry("MyIDirectDrawSurface.Restore() = ", res);
		return res;
	}

	/// 
	override HRESULT SetClipper(LPDIRECTDRAWCLIPPER lpDDClipper)
	{		auto res = _lpDDSurface.SetClipper(lpDDClipper);
		Logger.addEntry("MyIDirectDrawSurface.SetClipper(", lpDDClipper, ") = ", res);
		return res;
	}

	/// 
	override HRESULT SetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{		auto res = _lpDDSurface.SetColorKey(dwFlags, lpDDColorKey);
		Logger.addEntry("MyIDirectDrawSurface.SetColorKey(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override HRESULT SetOverlayPosition(LONG lX, LONG lY)
	{		auto res = _lpDDSurface.SetOverlayPosition(lX, lY);
		Logger.addEntry("MyIDirectDrawSurface.SetOverlayPosition(", lX, lY, ") = ", res);
		return res;
	}

	/// 
	override HRESULT SetPalette(LPDIRECTDRAWPALETTE lpDDPalette)
	{		auto res = _lpDDSurface.SetPalette(lpDDPalette);
		Logger.addEntry("MyIDirectDrawSurface.SetPalette(", lpDDPalette, ") = ", res);
		return res;
	}

	/// 
	override HRESULT Unlock(LPRECT lpRect)
	{		auto res = _lpDDSurface.Unlock(lpRect);
		Logger.addEntry("MyIDirectDrawSurface.Unlock(", lpRect, ") = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlay(LPRECT lpSrcRect, LPProperDirectDrawSurface lpDDDestSurface, LPRECT lpDestRect, DWORD dwFlags, LPDDOVERLAYFX lpDDOverlayFx)
	{		auto res = _lpDDSurface.UpdateOverlay(lpSrcRect, lpDDDestSurface, lpDestRect, dwFlags, lpDDOverlayFx);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlay() = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlayDisplay(DWORD dwFlags)
	{		auto res = _lpDDSurface.UpdateOverlayDisplay(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayDisplay() = ", res);
		return res;
	}

	/// 
	override HRESULT UpdateOverlayZOrder(DWORD dwFlags, LPProperDirectDrawSurface lpDDSReference)
	{		auto res = _lpDDSurface.UpdateOverlayZOrder(dwFlags, lpDDSReference);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayZOrder() = ", res);
		return res;
	}

static if (ver >= 2)	// Added in the v2 interface
{
	/// 
	override HRESULT GetDDInterface(LPVOID* lplpDD)
	{		auto res = _lpDDSurface.GetDDInterface(lplpDD);
		Logger.addEntry("MyIDirectDrawSurface.GetDDInterface() = ", res);
		return res;
	}

	/// 
	override HRESULT PageLock(DWORD dwFlags)
	{		auto res = _lpDDSurface.PageLock(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.PageLock() = ", res);
		return res;
	}

	/// 
	override HRESULT PageUnlock(DWORD dwFlags)
	{		auto res = _lpDDSurface.PageUnlock(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.PageUnlock() = ", res);
		return res;
	}
}

static if (ver >= 3) // Added in the v3 interface
{
	/// 
	override HRESULT SetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags)
	{		auto res = _lpDDSurface.SetSurfaceDesc(lpDDSurfaceDesc, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.SetSurfaceDesc() = ", res);
		return res;
	}
}

static if (ver >= 4) // Added in the v4 interface
{
	/// 
	override HRESULT SetPrivateData(REFGUID guidTag, LPVOID lpData, DWORD cbSize, DWORD dwFlags)
	{		auto res = _lpDDSurface.SetPrivateData(guidTag, lpData, cbSize, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.SetPrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT GetPrivateData(REFGUID guidTag, LPVOID lpBuffer, LPDWORD lpcbBufferSize)
	{		auto res = _lpDDSurface.GetPrivateData(guidTag, lpBuffer, lpcbBufferSize);
		Logger.addEntry("MyIDirectDrawSurface.GetPrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT FreePrivateData(REFGUID guidTag)
	{		auto res = _lpDDSurface.FreePrivateData(guidTag);
		Logger.addEntry("MyIDirectDrawSurface.FreePrivateData() = ", res);
		return res;
	}

	/// 
	override HRESULT GetUniquenessValue(LPDWORD lpValue)
	{		auto res = _lpDDSurface.GetUniquenessValue(lpValue);
		Logger.addEntry("MyIDirectDrawSurface.GetUniquenessValue() = ", res);
		return res;
	}

	/// 
	override HRESULT ChangeUniquenessValue()
	{		auto res = _lpDDSurface.ChangeUniquenessValue();
		Logger.addEntry("MyIDirectDrawSurface.ChangeUniquenessValue() = ", res);
		return res;
	}
}

static if (ver >= 7)
{
	/// 
	override HRESULT  SetPriority(DWORD dwPriority)
	{		auto res = _lpDDSurface.SetPriority(dwPriority);
		Logger.addEntry("MyIDirectDrawSurface.SetPriority() = ", res);
		return res;
	}
	/// 
	override HRESULT  GetPriority(LPDWORD dwPriority)
	{		auto res = _lpDDSurface.GetPriority(dwPriority);
		Logger.addEntry("MyIDirectDrawSurface.GetPriority() = ", res);
		return res;
	}
	/// 
	override HRESULT  SetLOD(DWORD dwLOD)
	{		auto res = _lpDDSurface.SetLOD(dwLOD);
		Logger.addEntry("MyIDirectDrawSurface.SetLOD() = ", res);
		return res;
	}
	/// 
	override HRESULT  GetLOD(LPDWORD dwLOD)
	{		auto res = _lpDDSurface.GetLOD(dwLOD);
		Logger.addEntry("MyIDirectDrawSurface.GetLOD() = ", res);
		return res;
	}
}
} // of class MyIDirectDrawSurface