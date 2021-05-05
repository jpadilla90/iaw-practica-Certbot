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

![](https://i.imgur.com/BKrJ73G.png)
Grupo de seguridad y lista de puertos.    

### Paso2
Obtener la dirección IP pública de su instancia EC2 en AWS.

34.229.0.223

### Paso3
Realizar la instalación y configuración de un sitio web. Para esta tarea puede hacer uso de los scripts que ha realizado en las prácticas anteriores.

Usamos la instalación mediante WP-CLI de anteriores prácticas.
wp-cli.sh y comandos.md adjuntos.

![](https://imgur.com/eP3fZtq)

### Paso4
Registrar un nombre de dominio en algún proveedor de nombres de dominio gratuito. Por ejemplo, puede hacer uso de Freenom.

Dominio conseguido con www.noip.com

### Paso5
Configurar los registros DNS del proveedor de nombres de dominio para que el nombre de dominio de ha registrado pueda resolver hacia la dirección IP pública de su instancia EC2 de AWS.

Si utiliza el proveedor de nombres de dominio Freenom tendrá que acceder desde el panel de control, a la sección de sus dominios contratados y una vez allí seleccionar Manage Freenom DNS.

Tendrá que añadir dos registros DNS de tipo A con la dirección IP pública de su instancia EC2 de AWS. Un registro estará en blanco para que pueda resolver el nombre de dominio sin las www y el otro registro estará con las www.

![](https://i.imgur.com/LTVMHO1.png)
Dominio conseguido

![](https://imgur.com/Ih3ULBS)
Conseguir un reapuntado con www no ha sido posible con no-ip.

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

![](https://imgur.com/Z1ThEnk)
En esta imagen hemos especificado argumentos para aligerar el proceso de instalación.

Las mismas respuestas que hemos dado durante la instalación manual se podrían haber indicado con los siguientes parámetros.

- Dirección de correo: `-m demo@demo.es`
- Aceptamos los términos de uso: `--agree-tos`
- No queremos compartir nuestro email con la Electronic Frontier Foundation: `--no-eff-email`
- Dominio: `-d practicahttps.ml`

`sudo certbot --apache -m demo@demo.es --agree-tos --no-eff-email -d practicahttps.ml`

Con el siguiente comando podemos comprobar que hay un temporizador en el sistema encargado de realizar la renovación de los certificados de manera automática.

`systemctl list-timers`
![](https://i.imgur.com/whtRbHX.png)
Podemos ver en la segunda entrada el timer renovación automática.

Se recomienda revisar los archivos de configuración del servidor web para ver cuáles han sido las cambios que ha realizado el cliente Certbot.

#### Entrega


- URL del repositorio de GitHub donde se ha alojado el documento técnico escrito en Markdown.

- Scripts de bash utilizados para realizar el aprovisionamiento de las máquinas virtuales y para la instalación y configuración del cliente Certbot.

- El contenido de cada uno de los scripts deberá ser incluido en el documento y deberá describir qué acciones se han ido realizando en cada uno de ellos.

- URL del sitio web con HTTPS habilitado.


**Archivos en el repositorio**
------------
1. **README**           Documentación.
2. **wp-cli.sh**        Script de instalación WP con línea de comandos.
3. **comandos.md**      Hoja de referencia de comandos para wp-cli
4. **ACME.sh**          Instalador de Certbot.

**Referencias**
------------
- Guía original para la práctica.
https://josejuansanchez.org/iaw/practica-https/index.html
- 

**Editor Markdown**
------------
- Markdown editor. Alternativamente, investigar atajos de teclado como Ctrl+B= bold (negrita) 
https://markdown-editor.github.io/

