@echo off
setlocal

echo.
echo ================================
echo   Dart Build Runner Watch Mode
echo ================================
echo Started at: %DATE% %TIME%
echo.

REM Check if Dart is installed
where dart >nul 2>&1
if errorlevel 1 (
    echo Dart SDK not found. Ensure it is in your PATH.
    exit /b 1
)

REM Start watching changes
echo Watching for file changes with build_runner...
dart run build_runner watch -d
if errorlevel 1 (
    echo ❌ build_runner watch encountered an error.
    exit /b %ERRORLEVEL%
)

endlocal
