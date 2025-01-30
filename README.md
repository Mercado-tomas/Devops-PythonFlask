# Proyecto de Despliegue Automático en Python con Flask y Bash

Este proyecto se realiza desde un **script en Bash desde vim** para la automatización del despliegue de una aplicación en Python utilizando **Flask**. El objetivo es configurar un entorno virtual de Python y asegurar que las dependencias estén correctamente instaladas, además de hacer un deploy fácil y rápido para facilitar el desarrollo y la implementación en cualquier servidor.
Todo el proyecto es generado y automatizado desde un simple pero potente script en bash desde vim.
## Descripción

El script está diseñado para automatizar la instalación de **Python**, **pip**, crear un entorno virtual, y desplegar una aplicación básica en **Flask**. Está pensado para mejorar la eficiencia de los desarrolladores y reducir la probabilidad de errores en la configuración manual del entorno.

### Características
- Verificación de versiones de **Python** y **pip**.
- Instalación automática de Python y pip si no están presentes.
- Creación de un **entorno virtual** con `python3 -m venv`.
- Instalación de dependencias del proyecto como **Flask**.
- Creación de una **aplicación básica en Flask** con un endpoint de "Hola Mundo".
- Escalado automático de permisos en caso de errores de acceso.

## Requisitos

Antes de ejecutar el script, asegúrate de tener:

- **Linux** o cualquier sistema compatible con Bash.
- **Python 3.x** instalado (el script verificará y lo instalará si es necesario).
- **pip** para gestionar las dependencias.
  
## Pasos del Script

### 1. **Verificación de versiones**
El script comienza verificando si **Python** y **pip** están instalados. Si no están presentes, el script se encarga de instalarlos automáticamente. 

- Si **Python** no está instalado, se instala utilizando el gestor de paquetes del sistema (`apt-get` en el caso de Ubuntu).
- Si **pip** no está presente, el script lo instala utilizando el comando `get-pip.py`.

### 2. **Escalado de permisos**
En caso de que se detecten problemas de permisos durante la instalación de dependencias o la creación de archivos, el script incluye comandos para otorgar permisos de escritura a los directorios necesarios. Esto se realiza con el comando `chmod` para garantizar que no se presenten errores de "Permiso Denegado".

### 3. **Creación del entorno virtual**
El script verifica si un entorno virtual ya existe. Si no, crea un entorno virtual en el directorio especificado utilizando el comando `python3 -m venv`.

El entorno virtual permite aislar las dependencias del proyecto y evitar conflictos con otras aplicaciones o proyectos en el mismo sistema.

### 4. **Activación del entorno virtual**
Una vez creado, el entorno virtual se activa con el comando `source /path/to/venv/bin/activate`, asegurando que todas las dependencias se instalen de manera aislada.

### 5. **Instalación de dependencias**
El script procede a instalar las dependencias necesarias, en este caso **Flask**. Si alguna de las dependencias no está instalada, se instalará automáticamente utilizando `pip`.

### 6. **Creación del archivo `app.py`**
El script genera un archivo básico de aplicación Flask llamado `app.py`, el cual contiene un sencillo endpoint que retorna "Hola Mundo" al acceder a la URL principal (`localhost:5000`).

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hola Mundo'

if __name__ == '__main__':
    app.run(debug=True)
