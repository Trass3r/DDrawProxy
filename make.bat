rdmd --build-only --chatty -ofddraw.dll -debug -g -version=WOW64DLL -version=NoSurfaceHooking main.def main.d
REM -version=forceWindowed
cv2pdb -D2 ddraw.dll

copy /Y ddraw.dll "G:\Spiele\Beasts and Bumpkins"

del *.map /Q
