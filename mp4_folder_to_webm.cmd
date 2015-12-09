:: CONFIG
set ffmpeg=D:\ffmpeg-20150606-git-f073764-win64-static\bin\ffmpeg.exe
set MOVIEFOLDER=R:\to_encode\
set OUTPUTDIR=D:\
set CRF=4
set scalex=1280
set scaley=720
set FRAMERATE=30
:: CONFIG END


@echo off
mode 160,1000
COLOR 0A
cls
echo "********************************************************************************"
echo "**************---------------- encoding videos-----------------------------**********"
echo "********************************************************************************"
echo

for %%f in (%MOVIEFOLDER%*.mp4) do (
            %ffmpeg% -i "%%f" -framerate %FRAMERATE% -c:v libvpx -qmin 0 -qmax 60 -crf %CRF% -b:v 2M -vf scale=%scalex%:%scaley% "%OUTPUTDIR%\%%~nf.720_crf%CRF%.webm"
)
COLOR 07
pause
