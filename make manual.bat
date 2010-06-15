dmd main.d main.def -ofddraw.dll -od.objs -op ddraw.d myiddraw.d myiddrawsurface.d myipalette.d logger.d tools.d -debug -g -version=WOW64DLL

rem cv2pdb -D2 ddraw.dll

pause