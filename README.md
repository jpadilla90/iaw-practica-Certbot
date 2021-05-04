# iaw-practica-Certbot
HTTPS con Let’s Encrypt y Certbot

> IES Celia Viñas (Almería) - Curso 2020/2021
Módulo: IAW - Implantación de Aplicaciones Web
Ciclo: CFGS Administración de Sistemas Informáticos en Red

**Introducción**
------------
En esta práctica vamos a habilitar el protocolo HTTPS en un sitio web WordPress que se estará ejecutando en una instancia EC2 de Amazon Web Services (AWS).

**Tareas a realizar**
------------

### Paso1 
Crear una instancia en EC2

Cuando esté creando la instancia deberá configurar los puertos que estarán abiertos para poder conectarnos por SSH y para poder acceder por HTTP/HTTPS.

    SSH (22/TCP)
    HTTP (80/TCP)
    HTTPS (443/TCP)

### Paso2
Obtener la dirección IP pública de su instancia EC2 en AWS.

### Paso3
Realizar la instalación y configuración de un sitio web. Para esta tarea puede hacer uso de los scripts que ha realizado en las prácticas anteriores.

### Paso4
Registrar un nombre de dominio en algún proveedor de nombres de dominio gratuito. Por ejemplo, puede hacer uso de Freenom.

### Paso5
Configurar los registros DNS del proveedor de nombres de dominio para que el nombre de dominio de ha registrado pueda resolver hacia la dirección IP pública de su instancia EC2 de AWS.

Si utiliza el proveedor de nombres de dominio Freenom tendrá que acceder desde el panel de control, a la sección de sus dominios contratados y una vez allí seleccionar Manage Freenom DNS.

Tendrá que añadir dos registros DNS de tipo A con la dirección IP pública de su instancia EC2 de AWS. Un registro estará en blanco para que pueda resolver el nombre de dominio sin las www y el otro registro estará con las www.

**Ejemplo:** En la siguiente imagen se muestra cómo sería la configuración de los registros DNS para resolver hacia la dirección IP 54.236.57.173.

**Nota:** Tenga en cuenta que una vez que ha realizado los cambios en el DNS habrá que esperar hasta que los cambios se progaguen. Puede hacer uso de la utilidad dnschecker.org para comprobar el estado de propagación de las DNS.

## Paso6
Instalar y configurar el cliente ACME Certbot en su instacia EC2 de AWS, siguiendo los pasos de la documentación oficial.

Se recomienda visitar la página web oficial de Certobot y utilizar el formulario para indicar el software que vamos a utilizar (Apache, Ngingx, HAProxy, etc.) y el sistema operativo. Una vez que hemos realizado la selección nos aparecerán las instrucciones que tenemos que tenemos que seguir.

**Ejemplo:** A continuación se muestran los pasos que se han llevado a cabo para realizar la instalación y configuración de Certbot en una máquina con el servidor web Apache y el sistema operativo Ubuntu 20.04.

1. Realizamos la instalación y actualización de snapd.

`sudo snap install core; sudo snap refresh core`

2. Eliminamos si existiese alguna instalación previa de certbot con apt.

`sudo apt-get remove certbot`

3. Instalamos el cliente de Certbot con snapd.

`sudo snap install --classic certbot`

4. Creamos una alias para el comando certbot.

`sudo ln -s /snap/bin/certbot /usr/bin/certbot`

5. Obtenemos el certificado y configuramos el servidor web Apache.

`sudo certbot --apache`

Durante la ejecución del comando anterior tendremos que contestar algunas preguntas:

- Habrá que introducir una dirección de correo electrónico. (Ejemplo: demo@demo.es)
- Aceptar los términos de uso. (Ejemplo: y)
- Nos preguntará si queremos compartir nuestra dirección de correo electrónico con la Electronic Frontier Foundation. (Ejemplo: n)
- Y finalmente nos preguntará el nombre del dominio, si no lo encuentra en los archivos de configuración del servidor web. (Ejemplo: practicahttps.ml)

A continuación se muestra un ejemplo de cómo es la interacción durante la ejecución del comando sudo certbot --apache.

```bash
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator apache, Installer apache
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): demo@demo.es

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: n
Account registered.
No names were found in your configuration files. Please enter in your domain
name(s) (comma and/or space separated)  (Enter 'c' to cancel): practicahttps.ml
Requesting a certificate for practicahttps.ml
Performing the following challenges:
http-01 challenge for practicahttps.ml
Enabled Apache rewrite module
Waiting for verification...
Cleaning up challenges
Created an SSL vhost at /etc/apache2/sites-available/000-default-le-ssl.conf
Enabled Apache socache_shmcb module
Enabled Apache ssl module
Deploying Certificate to VirtualHost /etc/apache2/sites-available/000-default-le-ssl.conf
Enabling available site: /etc/apache2/sites-available/000-default-le-ssl.conf
Enabled Apache rewrite module
Redirecting vhost in /etc/apache2/sites-enabled/000-default.conf to ssl vhost in /etc/apache2/sites-available/000-default-le-ssl.conf

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabled https://practicahttps.ml
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Subscribe to the EFF mailing list (email: demo@demo.es).

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/practicahttps.ml/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/practicahttps.ml/privkey.pem
   Your certificate will expire on 2021-05-01. To obtain a new or
   tweaked version of this certificate in the future, simply run
   certbot again with the "certonly" option. To non-interactively
   renew *all* of your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

Una vez llegado hasta este punto tendríamos nuestro sitio web con HTTPS habilidado y todo configurado para que el certificado se vaya renovando automáticamente.

**Nota:**

También es posible especificar como argumentos las respuestas que nos hará certbot durante el proceso de instalación. Por ejemplo, las mismas respuestas que hemos dado durante la instalación manual se podrían haber indicado con los siguientes parámetros.

- Dirección de correo: `-m demo@demo.es`
- Aceptamos los términos de uso: `--agree-tos`
- No queremos compartir nuestro email con la Electronic Frontier Foundation: `--no-eff-email`
- Dominio: `-d practicahttps.ml`

`sudo certbot --apache -m demo@demo.es --agree-tos --no-eff-email -d practicahttps.ml`

Con el siguiente comando podemos comprobar que hay un temporizador en el sistema encargado de realizar la renovación de los certificados de manera automática.

`systemctl list-timers`

Se recomienda revisar los archivos de configuración del servidor web para ver cuáles han sido las cambios que ha realizado el cliente Certbot.

#### Entrega


- URL del repositorio de GitHub donde se ha alojado el documento técnico escrito en Markdown.

- Scripts de bash utilizados para realizar el aprovisionamiento de las máquinas virtuales y para la instalación y configuración del cliente Certbot.

- El contenido de cada uno de los scripts deberá ser incluido en el documento y deberá describir qué acciones se han ido realizando en cada uno de ellos.

- URL del sitio web con HTTPS habilitado.


**Archivos en el repositorio**
------------
2. **ª**

**Referencias**
------------
- Guía original para la práctica.
https://josejuansanchez.org/iaw/practica-https/index.html
- 

**Editor Markdown**
------------
- Markdown editor. Alternativamente, investigar atajos de teclado como Ctrl+B= bold (negrita) 
https://markdown-editor.github.io/

