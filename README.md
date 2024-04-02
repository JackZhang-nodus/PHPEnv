# Test pull request after reviewing
## 1. Download Software: sample software version     
nginx-1.16.1+php-7.2.9+mysql-5.7.35
- PHP：   https://windows.php.net/download/
- Nginx: http://nginx.org/en/download.html
- Mysql: https://downloads.mysql.com/archives/community/

## 2. Unzip the software to the directory
- PHP：   C:\env\php\php-7.2.9-nts-Win32-VC15-x64
- Nginx： C:\env\nginx\nginx-1.16.1
- Mysql： C:\env\mysql\mysql-5.7.35-winx64

## 3. Configure php.ini and nginx.conf
php.ini:
```
extension_dir="./ext"
error_log=C:/env/php/php-7.2.9-nts-Win32-VC15-x64.log
```
nginx.conf:
```
upstream fastcgi_backend {
	server 127.0.0.1:9000;
	server 127.0.0.1:9001;
        server 127.0.0.1:9002;
        server 127.0.0.1:9003;
}

server {
        listen        80;
        server_name  localhost;
        root   "C:/sites";
        location / {
            index index.php index.html;
        }
        location ~ \.php(.*)$ {
            fastcgi_pass   fastcgi_backend;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
        }
}
```
## 4. Create start.bat to start services
```
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
```
## 5. Create stop.bat to stop services             
```
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
```
