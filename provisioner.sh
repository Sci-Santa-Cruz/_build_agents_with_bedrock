#!/bin/bash

# ----------------------------------------------
# Provisioner para Amazon Linux 2
# Instalación de dependencias de Python
# y ejecución de requirements.txt
# ----------------------------------------------

# Salir si hay un error
set -e

echo "==> Actualizando el sistema..."
sudo yum update -y

echo "==> Instalando herramientas de desarrollo..."
sudo yum groupinstall "Development Tools" -y
sudo yum install -y gcc gcc-c++ make


echo "==> Actualizando pip..."
sudo python3 -m pip install --upgrade pip

# Verifica que exista requirements.txt
if [ ! -f requirements.txt ]; then
    echo "ERROR: No se encontró el archivo requirements.txt en el directorio actual."
    exit 1
fi

echo "==> Instalando paquetes de requirements.txt con actualización forzada..."
pip3 install -U --no-cache-dir -q -r requirements.txt

echo "✅ Provisioning completo."
