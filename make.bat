del .deps
del .objs /Q
del *.rsp

xfbuild +v +xstd +xcore +oddraw.dll main.d main.def -debug -g -version=WOW64DLL
REM -version=forceWindowed
cv2pdb -D2 ddraw.dll

copy /Y ddraw.dll "G:\Spiele\Beasts and Bumpkins"

del *.map /Q