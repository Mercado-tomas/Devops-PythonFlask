#!/bin/bash

## actualizamos el sistema

sudo apt -y update && sudo apt -y upgrade

## buscamos versiones de python
if [ dpkg -l | grep -q  python3  ] ; 
then
	echo "Está instalado pip"
else
	echo "Instalando pip.."
	sudo apt install -y python3-dev build-essential libssl-dev libffi-dev python3-setuptools
fi

if [ dpkg -l | grep -q  python3-pip ] ;
then
	echo "Pip está instalado en su sistema."
else
	echo "Instalando pip.."
	sudo apt install -y python3-pip
fi

# instalamos un entorno virtual
if [ dpkg -l | grep -q  python3-venv ] ;
then
	echo "Está instalado el entorno virtual de python."
else
	echo "Instalando entorno virtual de python.."
	sudo apt install -y python3-venv
fi

# buscamos carpeta, sino la creamos y levantamos el entorno en la misma
CARPETA="/home/tomas-ubuntu/Escritorio/app-Python-Flask"
if [ -d "$CARPETA" ] ;
then
	echo "La carpeta existe, por lo que el entorno virtual debería estar."
else
	echo "Creando carpeta e iniciando el entorno virtual en la misma"
	mkdir -p "$CARPETA"
fi
# nos paramos sobre el directorio
cd "$CARPETA" || exit
if [ -d "appFlask-Pythonvenv" ] ;
then
	echo "El entorno está creado"
else	
	echo "Creando el entorno virtual.."
	python3 -m venv appFlask-Pythonvenv
fi	

echo "Activando el entorno python.."
source appFlask-Pythonvenv/bin/activate


echo "Instalando Flask y Wheel para el servicio.."
pip install --upgrade pip
pip install Flask
pip install wheel

# Crear archivo app.py y agregar el contenido
echo "Creando archivo app.py"
sudo touch app.py
## crea el archivo y lo sobreescribe
sudo cat > app.py <<EOL
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello Bootcampers RoxsOps!</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')

EOL

echo "Ejecución completada con +exito!"
echo "Podes ejecutar 'python app.py' dentro del entorno virtual."
echo "Podes ver la aplicación desde: localhost:5000"




