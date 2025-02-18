@echo off
cd /d C:\Users\username\my-jekyll-site
call bundle exec jekyll build
if %errorlevel% neq 0 (
    echo Jekyll build hata verdi, konsol kapanmıyor.
    pause
    exit /b %errorlevel%
)
git pull origin main
if %errorlevel% neq 0 (
    echo Git pull hata verdi, konsol kapanmıyor.
    pause
    exit /b %errorlevel%
)
git add .
if %errorlevel% neq 0 (
    echo Git add hata verdi, konsol kapanmıyor.
    pause
    exit /b %errorlevel%
)
git commit -m "srdru.github.io"
if %errorlevel% neq 0 (
    echo Git commit hata verdi, konsol kapanmıyor.
    pause
    exit /b %errorlevel%
)
git push origin main
if %errorlevel% neq 0 (
    echo Git push hata verdi, konsol kapanmıyor.
    pause
    exit /b %errorlevel%
)
pause

