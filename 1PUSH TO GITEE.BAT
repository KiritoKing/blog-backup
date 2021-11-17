@ECHO OFF
echo Push to Github start...
git add .
git commit -m "blog text sync"
git push gitee master
echo Push finished
pause