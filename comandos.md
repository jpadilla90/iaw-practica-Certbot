**Comandos útiles de WP-CLI:Exposición**

# Ya que estos comandos no están en script, pueden requerir del uso de 'sudo'

## PLUGIN
# Listar plugin instalados
wp plugin list

# Actualizar todos los plugin (No actualizarlos es fallo de seguridad)
wp plugin update --all --path=/var/www/html/ --allow-root

# Instalar un plugin específico
wp plugin install --path=/var/www/html/ [plugin] --activate --allow-root

# Desactivar un plugin
wp plugin deactivate [plugin]

# Eliminar un plugin
wp plugin delete [plugin]

## TEMAS (Repetimos list/update/install/deactivate/delete)
# Listar temas instalados
wp theme list

# Actualizar todos los temas
wp theme update --all --path=/var/www/html/ --allow-root

# Instalar un tema específico
wp theme install --path=/var/www/html/ [tema] --activate --allow-root

# Actualizar todos los temas
wp theme update --all --path=/var/www/html/ --allow-root

## RUBY Y WPSCAN
# Instalar Ruby
apt install ruby -y

# Instalamos dependencias de Ruby
apt install build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev  libgmp-dev zlib1g-dev -y

# Instalar herramienta de auditoria wpscan
gem install wpscan

# Actualizar wpscan
wpscan --update

# Enumerar usuarios vía wp-scan
wpscan --url [URL] --enumerate u