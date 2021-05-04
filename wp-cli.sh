#!/bin/bash

###-------------------------------------------------------###
### Script para montar Wordpress sobre pila LAMP          ###
###-------------------------------------------------------###

## Variables ##

# IP pública.
IP_PUBLICA=         #<<<<<<<Cambiar con cada uso !!!
# Contraseña aleatoria para el parámetro blowfish_secret
BLOWFISH=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 64`
# Directorio de usuario
HTTPASSWD_DIR=/home/ubuntu
HTTPASSWD_USER=usuario
HTTPASSWD_PASSWD=usuario
# MySQL
DB_ROOT_PASSWD=root
DB_NAME=wp_db
DB_USER=wp_user
DB_PASSWORD=wp_pass

# ------------------------------------------------------------------------------ Instalación y configuración de Apache, MySQL y PHP------------------------------------------------------------------------------ 

# Habilitamos el modo de shell para mostrar los comandos que se ejecutan
set -x
# Actualizamos y actualizamos la lista de paquetes
apt update  
# apt upgrade -y si queremos actualizar. Deshabilitado para demostraciones.

# Instalamos Apache
apt install apache2 -y

# Instalamos el sistema gestor de base de datos
apt install mysql-server -y

# Instalamos los módulos PHP necesarios para Apache
apt install php libapache2-mod-php php-mysql -y

# Reiniciamos el servicio Apache 
systemctl restart apache2

## Configuramos base de datos para Wordpress. wp_db, wp_user, wp_pass

# Por seguridad, hacemos un borrado preventivo de la base de datos wordpress_db
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
# Creamos la base de datos wordpress_db
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
# Nos aseguramos que no existe el usuario automatizado
mysql -u root <<< "DROP USER IF EXISTS $DB_USER@localhost;"
# Creamos el usuario 'wordpress_user' para Wordpress
mysql -u root <<< "CREATE USER $DB_USER@localhost IDENTIFIED BY '$DB_PASSWORD';"
# Concedemos privilegios al usuario que acabamos de crear
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@localhost;"
# Aplicamos cambios con un comando flush. Esto evita tener que reiniciar mysql.
mysql -u root <<< "FLUSH PRIVILEGES;"

# ------------------------------------------------------------------------------ WP - CLI------------------------------------------------------------------------------ 

## Instalación de WP-CLI en el servidor LAMP

#Comenzamos ubicándonos en el directorio de Apache
cd /var/www/html

# Descargamos y guardamos el contenido de wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Le asignamos permisos de EJECUCION (x) al archivo
chmod +x wp-cli.phar

# Movemos el archivo y cambiamos el nombre  a wp. A partir de aquí, la terminal debería ayudarnos usando 'wp'
mv wp-cli.phar /usr/local/bin/wp

# Eliminamos index.html
rm -rf index.html

# Descargamos el código fuente de Wordpress en Español y le damos permiso de root
wp core download --path=/var/www/html --locale=es_ES --allow-root

# Permisos necesarios sobre la carpeta de wordpress
chown -R www-data:www-data /var/www/html

# Creamos el archivo de configuración de Wordpress. Podemos revisarlo luego con el comando 'wp config get'
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

# Instalamos Wordpress con la configuración. Recordatorio de actualizar la IP en la lista de variables.
wp core install --url=$IP_PUBLICA --title="IAW Jose Padilla" --admin_user=admin --admin_password=admin_password --admin_email=@gmail.com --allow-root

# Reiniciamos el servicio Apache 
systemctl restart apache2

# Nos dirigimos a la instalación de wp para poder ejecutar la herramienta cli sin problemas
cd /var/www/html
