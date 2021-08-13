@echo off
echo Stopping nginx...
taskkill /fi "imagename eq nginx.exe" /f> nul
echo Stop nginx success
 
echo Stopping PHP FastCGI...
taskkill /fi "imagename eq php-cgi.exe" /f> nul
echo Stop php-cgi success
 
echo Stopping mysql...
taskkill /fi "imagename eq mysqld.exe" /f> nul
echo Stop mysql success

pause

exit