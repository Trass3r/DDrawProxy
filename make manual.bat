dmd main.d main.def -ofddraw.dll -od.objs -op ddraw.d myiddraw.d myiddrawsurface.d logger.d tools.d -debug -g -version=WOW64DLL
cv2pdb -D2 ddraw.dll