@echo off
REM Script to download drawings from a Scribble.rs server (Windows)
REM Usage: download_drawings.bat [room_id] [destination_folder]

set ROOM_ID=%1
set DEST_FOLDER=%2

if "%ROOM_ID%"=="" set ROOM_ID=all
if "%DEST_FOLDER%"=="" set DEST_FOLDER=downloaded_drawings

echo Downloading drawings...
echo Room ID: %ROOM_ID%
echo Destination: %DEST_FOLDER%

REM Create destination folder
if not exist "%DEST_FOLDER%" mkdir "%DEST_FOLDER%"

if "%ROOM_ID%"=="all" (
    echo Downloading all room drawings...
    if exist "drawings" (
        xcopy "drawings\*" "%DEST_FOLDER%\" /E /I /Y
        echo All drawings downloaded to %DEST_FOLDER%
    ) else (
        echo No drawings folder found. Make sure the server has saved some drawings.
    )
) else (
    echo Downloading drawings for room: %ROOM_ID%
    if exist "drawings\%ROOM_ID%" (
        xcopy "drawings\%ROOM_ID%\*" "%DEST_FOLDER%\%ROOM_ID%\" /E /I /Y
        echo Room %ROOM_ID% drawings downloaded to %DEST_FOLDER%\%ROOM_ID%
    ) else (
        echo No drawings found for room %ROOM_ID%
    )
)

echo.
echo Downloaded files:
dir "%DEST_FOLDER%\*.png" /S /B 2>nul | findstr /R ".*" && echo Total files found || echo No PNG files found
pause