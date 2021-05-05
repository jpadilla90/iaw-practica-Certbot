# Instalación y actualización de snapd
snap install core
snap refresh core

# Eliminamos si existiese alguna instalación previa de certbot con apt.
apt-get remove certbot

# Instalamos el cliente de Certbot con snapd.
sudo snap install --classic certbot

# Creamos una alias para el comando certbot.
ln -s /snap/bin/certbot /usr/bin/certbot

# Obtenemos el certificado y configuramos el servidor web Apache.
sudo certbot --apache -m demo@demo.es --agree-tos --no-eff-email -d jpadilla.sytes.net

# Con el siguiente comando podemos comprobar que hay un temporizador en el sistema encargado de realizar la renovación de los certificados de manera automática.
# systemctl list-timers