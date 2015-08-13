:: CONFIG
set ffmpeg=E:\devel\ffmpeg-20140719-win64-static\bin\ffmpeg.exe
set MOVIEFOLDER=E:\encoded_movies\
set CRF=4
set scalex=720
set scaley=480
set FRAMERATE=30
:: CONFIG END

@echo off
mode 160,1000
COLOR 0A
cls
echo "Start encoding.."

:: crawl for them mp4!
for %%f in (%MOVIEFOLDER%*.mp4) do (
    %ffmpeg% -i "%%f" -framerate %FRAMERATE% -c:v libvpx -qmin 0 -qmax 40 -crf %CRF% -b:v 2M -vf scale=%scalex%:%scaley% "%%~nf.720_crf%CRF%.webm"
)
COLOR 07
pause

