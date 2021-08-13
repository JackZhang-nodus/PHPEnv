@echo off
set console_home=C:\env
set php_home=C:\env\php\php-7.2.9-nts-Win32-VC15-x64
set nginx_home=C:\env\nginx\nginx-1.16.1
set mysql_home=C:\env\mysql\mysql-5.7.35-winx64

REM set PHP_FCGI_CHILDREN=5
set PHP_FCGI_MAX_REQUESTS=1000

echo Starting nginx .......................
"%console_home%/RunHiddenConsole.exe" "%nginx_home%/nginx.exe" -p "%nginx_home%"
echo Start nginx success

echo Starting PHP .......................
"%console_home%/RunHiddenConsole.exe" "%php_home%\php-cgi.exe" -b 127.0.0.1:9000 -c "%php_home%\php.ini"
"%console_home%/RunHiddenConsole.exe" "%php_home%\php-cgi.exe" -b 127.0.0.1:9001 -c "%php_home%\php.ini"
"%console_home%/RunHiddenConsole.exe" "%php_home%\php-cgi.exe" -b 127.0.0.1:9002 -c "%php_home%\php.ini"
"%console_home%/RunHiddenConsole.exe" "%php_home%\php-cgi.exe" -b 127.0.0.1:9003 -c "%php_home%\php.ini"
echo Start php-cgi success

echo Starting mysql .......................
"%console_home%/RunHiddenConsole.exe" "%mysql_home%\bin\mysqld.exe"
echo Start mysql success

pause
Exit