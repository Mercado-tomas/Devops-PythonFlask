#!/bin/bash

# actualizamos
echo "Actualizamos el sistema"
sudo apt-get -q update -y && sudo apt -q upgrade -y

# revisamo si se encuentra instalado
if [ java -version &> /dev/null ] ;
then
	echo "JDK se encuentra instalado en el sistema"
else
	echo "Instalando JDK"
	sudo apt install -y fontconfig openjdk-17-jre
fi	

if [ systemctl list-units --type=service | grep "jenkins.service" ] ;
then
	echo "Jenkins se encuentra instalado!"
else
	echo "Instalando Jenkins.."
	# Agregar la clave y repositorio oficial de Jenkins
        sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
        https://pkg.jenkins.io/debian/jenkins.io-2023.key
        echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
        https://pkg.jenkins.io/debian binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
        
        # Actualizar repositorios e instalar Jenkins
        sudo apt install -y jenkins	
fi

echo "Iniciando el servicio de Jenkins.."
sudo systemctl start jenkins

echo "Status de Jenkins.."
sudo systemctl status jenkins

echo "Ingresar desde localhost:8080"
echo "Ingresar con el usuario: admin"
echo "Buscaremos credenciales en sistema.."

if [ -f /var/jenkins/secrets/initialAdminPassword ] ; then
	echo "La clave/key de acceso inicial es: "
	sudo cat /var/lib/jenkins/secrets/initialAdminPassword
else	
	echo "Jenkins se encuentra previamente configurado."
	echo "Debe de ingresar con credenciales configuradas previamente."
fi	
