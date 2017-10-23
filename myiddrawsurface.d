/**
 *	
 */
module myiddrawsurface;

import ddraw;
import logger;

alias GUID* REFGUID; 

alias MyIDirectDrawSurfaceB!(1) MyIDirectDrawSurface; ///
//alias MyIDirectDrawSurfaceB!(2) MyIDirectDrawSurface2; ///
//alias MyIDirectDrawSurfaceB!(3) MyIDirectDrawSurface3; ///
alias MyIDirectDrawSurfaceB!(4) MyIDirectDrawSurface4; ///
alias MyIDirectDrawSurfaceB!(7) MyIDirectDrawSurface7; ///

class MyIDirectDrawSurfaceB(uint ver) : IDirectDrawSurfaceB!(ver)
{
private:
	alias BaseInterface = IDirectDrawSurfaceB!(ver);
	BaseInterface _lpDDSurface;
/*
	alias LPProperDDSCaps = BaseInterface.LPProperDDSCaps;
	alias LPProperDDSurfaceDesc = BaseInterface.LPProperDDSurfaceDesc;
	alias LPProperDDEnumSurfacesCallback = BaseInterface.LPProperDDEnumSurfacesCallback;
*/
public:
	this(BaseInterface* lplpDD)
	{
		_lpDDSurface = *lplpDD; // save the interface as a member
		*lplpDD = this; // alter the given pointer to this class instance
		// it's crucial to cast to the base interface here
	}
	
	~this()
	{
		Logger.addEntry("surface destructed");
	}

extern(Windows):

	/// 
	override HRESULT QueryInterface(REFIID riid, void** ppvObj)
	{
		Logger.addEntry("MyIDirectDrawSurface.QueryInterface(", riid, ")");

		/+
		DDRESULT hResult;

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
	override DDRESULT AddAttachedSurface(BaseInterface lpDDSAttachedSurface)
	{		auto res = _lpDDSurface.AddAttachedSurface(lpDDSAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.AddAttachedSurface() = ", res);
		return res;
	}

	/// 
	override DDRESULT AddOverlayDirtyRect(LPRECT lpRect)
	{		auto res = _lpDDSurface.AddOverlayDirtyRect(lpRect);
		Logger.addEntry("MyIDirectDrawSurface.AddOverlayDirtyRect(", lpRect, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT Blt(LPRECT lpDestRect, BaseInterface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwFlags, LPDDBLTFX lpDDBltFx)
	{		auto res = _lpDDSurface.Blt(lpDestRect, lpDDSrcSurface, lpSrcRect, dwFlags, lpDDBltFx);
		Logger.addEntry("MyIDirectDrawSurface.Blt(", lpDestRect, lpDDSrcSurface, lpSrcRect, dwFlags, lpDDBltFx, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT BltBatch(LPDDBLTBATCH lpDDBltBatch, DWORD dwCount, DWORD dwFlags)
	{		auto res = _lpDDSurface.BltBatch(lpDDBltBatch, dwCount, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.BltBatch(", lpDDBltBatch, dwCount, dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT BltFast(DWORD dwX, DWORD dwY, BaseInterface lpDDSrcSurface, LPRECT lpSrcRect, DWORD dwTrans)
	{		auto res = _lpDDSurface.BltFast(dwX, dwY, lpDDSrcSurface, lpSrcRect, dwTrans);
		Logger.addEntry("MyIDirectDrawSurface.BltFast(", dwX, dwY, lpDDSrcSurface, lpSrcRect, dwTrans, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT DeleteAttachedSurface(DWORD dwFlags, BaseInterface lpDDSAttachedSurface)
	{		auto res = _lpDDSurface.DeleteAttachedSurface(dwFlags, lpDDSAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.DeleteAttachedSurface(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT EnumAttachedSurfaces(LPVOID lpContext, LPProperDDEnumSurfacesCallback lpEnumSurfacesCallback)
	{		auto res = _lpDDSurface.EnumAttachedSurfaces(lpContext, lpEnumSurfacesCallback);
		Logger.addEntry("MyIDirectDrawSurface.EnumAttachedSurfaces() = ", res);
		return res;
	}

	/// 
	override DDRESULT EnumOverlayZOrders(DWORD dwFlags, LPVOID lpContext, LPProperDDEnumSurfacesCallback lpfnCallback)
	{		auto res = _lpDDSurface.EnumOverlayZOrders(dwFlags, lpContext, lpfnCallback);
		Logger.addEntry("MyIDirectDrawSurface.EnumOverlayZOrders(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT Flip(BaseInterface lpDDSurfaceTargetOverride, DWORD dwFlags)
	{		auto res = _lpDDSurface.Flip(lpDDSurfaceTargetOverride, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.Flip(", lpDDSurfaceTargetOverride, dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetAttachedSurface(LPProperDDSCaps lpDDSCaps, BaseInterface* lplpDDAttachedSurface)
	{		auto res = _lpDDSurface.GetAttachedSurface(lpDDSCaps, lplpDDAttachedSurface);
		Logger.addEntry("MyIDirectDrawSurface.GetAttachedSurface() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetBltStatus(DWORD dwFlags)
	{		auto res = _lpDDSurface.GetBltStatus(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.GetBltStatus() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetCaps(LPProperDDSCaps lpDDSCaps)
	{		auto res = _lpDDSurface.GetCaps(lpDDSCaps);
		Logger.addEntry("MyIDirectDrawSurface.GetCaps() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetClipper(LPDIRECTDRAWCLIPPER* lplpDDClipper)
	{		auto res = _lpDDSurface.GetClipper(lplpDDClipper);
		Logger.addEntry("MyIDirectDrawSurface.GetClipper() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{		auto res = _lpDDSurface.GetColorKey(dwFlags, lpDDColorKey);
		Logger.addEntry("MyIDirectDrawSurface.GetColorKey(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetDC(HDC* lphDC)
	{		auto res = _lpDDSurface.GetDC(lphDC);
		Logger.addEntry("MyIDirectDrawSurface.GetDC() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetFlipStatus(DWORD dwFlags)
	{		auto res = _lpDDSurface.GetFlipStatus(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.GetFlipStatus(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetOverlayPosition(LPLONG lplX, LPLONG lplY)
	{		auto res = _lpDDSurface.GetOverlayPosition(lplX, lplY);
		Logger.addEntry("MyIDirectDrawSurface.GetOverlayPosition(", lplX, lplY, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetPalette(LPDIRECTDRAWPALETTE* lplpDDPalette)
	{		auto res = _lpDDSurface.GetPalette(lplpDDPalette);
		Logger.addEntry("MyIDirectDrawSurface.GetPalette() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetPixelFormat(LPDDPIXELFORMAT lpDDPixelFormat)
	{		auto res = _lpDDSurface.GetPixelFormat(lpDDPixelFormat);
		Logger.addEntry("MyIDirectDrawSurface.GetPixelFormat(", lpDDPixelFormat, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT GetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{		auto res = _lpDDSurface.GetSurfaceDesc(lpDDSurfaceDesc);
		Logger.addEntry("MyIDirectDrawSurface.GetSurfaceDesc(", lpDDSurfaceDesc, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT Initialize(LPDIRECTDRAW lpDD, LPProperDDSurfaceDesc lpDDSurfaceDesc)
	{		auto res = _lpDDSurface.Initialize(lpDD, lpDDSurfaceDesc);
		Logger.addEntry("MyIDirectDrawSurface.Initialize() = ", res);
		return res;
	}

	/// 
	override DDRESULT IsLost()
	{		auto res = _lpDDSurface.IsLost();
		Logger.addEntry("MyIDirectDrawSurface.IsLost() = ", res);
		return res;
	}

	/// 
	override DDRESULT Lock(LPRECT lpDestRect, LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags, HANDLE hEvent)
	{		auto res = _lpDDSurface.Lock(lpDestRect, lpDDSurfaceDesc, dwFlags, hEvent);
		Logger.addEntry("MyIDirectDrawSurface.Lock(", lpDestRect, lpDDSurfaceDesc, dwFlags, hEvent, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT ReleaseDC(HDC hDC)
	{		auto res = _lpDDSurface.ReleaseDC(hDC);
		Logger.addEntry("MyIDirectDrawSurface.ReleaseDC() = ", res);
		return res;
	}

	/// 
	override DDRESULT Restore()
	{		auto res = _lpDDSurface.Restore();
		Logger.addEntry("MyIDirectDrawSurface.Restore() = ", res);
		return res;
	}

	/// 
	override DDRESULT SetClipper(LPDIRECTDRAWCLIPPER lpDDClipper)
	{		auto res = _lpDDSurface.SetClipper(lpDDClipper);
		Logger.addEntry("MyIDirectDrawSurface.SetClipper(", lpDDClipper, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT SetColorKey(DWORD dwFlags, LPDDCOLORKEY lpDDColorKey)
	{		auto res = _lpDDSurface.SetColorKey(dwFlags, lpDDColorKey);
		Logger.addEntry("MyIDirectDrawSurface.SetColorKey(", dwFlags, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT SetOverlayPosition(LONG lX, LONG lY)
	{		auto res = _lpDDSurface.SetOverlayPosition(lX, lY);
		Logger.addEntry("MyIDirectDrawSurface.SetOverlayPosition(", lX, lY, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT SetPalette(LPDIRECTDRAWPALETTE lpDDPalette)
	{		auto res = _lpDDSurface.SetPalette(lpDDPalette);
		Logger.addEntry("MyIDirectDrawSurface.SetPalette(", lpDDPalette, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT Unlock(LPRECT lpRect)
	{		auto res = _lpDDSurface.Unlock(lpRect);
		Logger.addEntry("MyIDirectDrawSurface.Unlock(", lpRect, ") = ", res);
		return res;
	}

	/// 
	override DDRESULT UpdateOverlay(LPRECT lpSrcRect, BaseInterface lpDDDestSurface, LPRECT lpDestRect, DWORD dwFlags, LPDDOVERLAYFX lpDDOverlayFx)
	{		auto res = _lpDDSurface.UpdateOverlay(lpSrcRect, lpDDDestSurface, lpDestRect, dwFlags, lpDDOverlayFx);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlay() = ", res);
		return res;
	}

	/// 
	override DDRESULT UpdateOverlayDisplay(DWORD dwFlags)
	{		auto res = _lpDDSurface.UpdateOverlayDisplay(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayDisplay() = ", res);
		return res;
	}

	/// 
	override DDRESULT UpdateOverlayZOrder(DWORD dwFlags, BaseInterface lpDDSReference)
	{		auto res = _lpDDSurface.UpdateOverlayZOrder(dwFlags, lpDDSReference);
		Logger.addEntry("MyIDirectDrawSurface.UpdateOverlayZOrder() = ", res);
		return res;
	}

static if (ver >= 2)	// Added in the v2 interface
{
	/// 
	override DDRESULT GetDDInterface(LPVOID* lplpDD)
	{		auto res = _lpDDSurface.GetDDInterface(lplpDD);
		Logger.addEntry("MyIDirectDrawSurface.GetDDInterface() = ", res);
		return res;
	}

	/// 
	override DDRESULT PageLock(DWORD dwFlags)
	{		auto res = _lpDDSurface.PageLock(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.PageLock() = ", res);
		return res;
	}

	/// 
	override DDRESULT PageUnlock(DWORD dwFlags)
	{		auto res = _lpDDSurface.PageUnlock(dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.PageUnlock() = ", res);
		return res;
	}
}

static if (ver >= 3) // Added in the v3 interface
{
	/// 
	override DDRESULT SetSurfaceDesc(LPProperDDSurfaceDesc lpDDSurfaceDesc, DWORD dwFlags)
	{		auto res = _lpDDSurface.SetSurfaceDesc(lpDDSurfaceDesc, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.SetSurfaceDesc() = ", res);
		return res;
	}
}

static if (ver >= 4) // Added in the v4 interface
{
	/// 
	override DDRESULT SetPrivateData(REFGUID guidTag, LPVOID lpData, DWORD cbSize, DWORD dwFlags)
	{		auto res = _lpDDSurface.SetPrivateData(guidTag, lpData, cbSize, dwFlags);
		Logger.addEntry("MyIDirectDrawSurface.SetPrivateData() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetPrivateData(REFGUID guidTag, LPVOID lpBuffer, LPDWORD lpcbBufferSize)
	{		auto res = _lpDDSurface.GetPrivateData(guidTag, lpBuffer, lpcbBufferSize);
		Logger.addEntry("MyIDirectDrawSurface.GetPrivateData() = ", res);
		return res;
	}

	/// 
	override DDRESULT FreePrivateData(REFGUID guidTag)
	{		auto res = _lpDDSurface.FreePrivateData(guidTag);
		Logger.addEntry("MyIDirectDrawSurface.FreePrivateData() = ", res);
		return res;
	}

	/// 
	override DDRESULT GetUniquenessValue(LPDWORD lpValue)
	{		auto res = _lpDDSurface.GetUniquenessValue(lpValue);
		Logger.addEntry("MyIDirectDrawSurface.GetUniquenessValue() = ", res);
		return res;
	}

	/// 
	override DDRESULT ChangeUniquenessValue()
	{		auto res = _lpDDSurface.ChangeUniquenessValue();
		Logger.addEntry("MyIDirectDrawSurface.ChangeUniquenessValue() = ", res);
		return res;
	}
}

static if (ver >= 7)
{
	/// 
	override DDRESULT SetPriority(DWORD dwPriority)
	{		auto res = _lpDDSurface.SetPriority(dwPriority);
		Logger.addEntry("MyIDirectDrawSurface.SetPriority() = ", res);
		return res;
	}
	/// 
	override DDRESULT GetPriority(LPDWORD dwPriority)
	{		auto res = _lpDDSurface.GetPriority(dwPriority);
		Logger.addEntry("MyIDirectDrawSurface.GetPriority() = ", res);
		return res;
	}
	/// 
	override DDRESULT SetLOD(DWORD dwLOD)
	{		auto res = _lpDDSurface.SetLOD(dwLOD);
		Logger.addEntry("MyIDirectDrawSurface.SetLOD() = ", res);
		return res;
	}
	/// 
	override DDRESULT GetLOD(LPDWORD dwLOD)
	{		auto res = _lpDDSurface.GetLOD(dwLOD);
		Logger.addEntry("MyIDirectDrawSurface.GetLOD() = ", res);
		return res;
	}
}
} // of class MyIDirectDrawSurface