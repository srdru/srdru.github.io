@echo off
call bundle exec jekyll build
git pull origin main
git add .
git commit -m "srdru.github.io"
git push origin main
pause

