@echo off
call bundle exec jekyll build
if %errorlevel% neq 0 (
    echo Jekyll build hata verdi.
    pause
    exit /b %errorlevel%
)
git pull origin main
if %errorlevel% neq 0 (
    echo Git pull hata verdi.
    pause
    exit /b %errorlevel%
)
git add .
if %errorlevel% neq 0 (
    echo Git add hata verdi.
    pause
    exit /b %errorlevel%
)
git commit -m "srdru.github.io"
if %errorlevel% neq 0 (
    echo Git commit hata verdi.
    pause
    exit /b %errorlevel%
)
git push origin main
if %errorlevel% neq 0 (
    echo Git push hata verdi.
    pause
    exit /b %errorlevel%
)
pause

