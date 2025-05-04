#!/bin/bash

# ----------------------------------------------
# Provisioner para Amazon Linux 2
# Instalación de dependencias de Python, OpenBLAS y FAISS-CPU
# y ejecución de requirements.txt
# ----------------------------------------------

# Salir si hay un error
set -e

echo "==> Actualizando el sistema..."
sudo yum update -y

# Instalando herramientas de desarrollo
echo "==> Instalando herramientas de desarrollo..."
sudo yum groupinstall "Development Tools" -y
sudo yum install -y gcc gcc-c++ make git

# Instalación de OpenBLAS
echo "==> Instalando OpenBLAS..."

# Clonar el repositorio de OpenBLAS desde GitHub
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS

# Compilación de OpenBLAS
make

# Instalación de OpenBLAS
sudo make install

# Verificar la instalación de OpenBLAS
ls /opt/OpenBLAS/lib

# Configuración de las variables de entorno para OpenBLAS
echo "==> Configurando las variables de entorno para OpenBLAS..."
echo 'export LD_LIBRARY_PATH=/opt/OpenBLAS/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export CPATH=/opt/OpenBLAS/include:$CPATH' >> ~/.bashrc

# Recargar el archivo de configuración
source ~/.bashrc

echo "✅ OpenBLAS ha sido instalado y configurado correctamente."

# Instalación de FAISS-CPU
echo "==> Instalando FAISS-CPU..."






# Instalación de kernel de Jupyter
echo "==> Instalando kernel de Jupyter..."
python -m ipykernel install --user --name=mi_entorno_311 --display-name "Python (mi_entorno_311)"

# Inicialización de Conda
echo "==> Inicializando Conda..."
conda init
source ~/.bashrc

# Activación del entorno Conda
echo "==> Activando el entorno Conda..."
conda activate mi_entorno_311

# Instalación de otros paquetes de Python
echo "==> Instalando otros paquetes de Python..."
# Instalación de los paquetes de requirements.txt con actualización forzada
echo "==> Instalando paquetes de requirements.txt con actualización forzada..."
# Verificar si existe requirements.txt
if [ ! -f requirements.txt ]; then
    echo "ERROR: No se encontró el archivo requirements.txt en el directorio actual."
    exit 1
fi
# Actualización de pip
echo "==> Actualizando pip..."
sudo python3 -m pip install --upgrade pip

# Instalar FAISS-CPU utilizando pip
pip3 install faiss-cpu

echo "✅ FAISS-CPU ha sido instalado correctamente."


pip3 install -U --no-cache-dir -q -r requirements.txt

conda deactivate

echo "✅ Provisioning completo."


#!/bin/bash

# Asegúrate de activar tu entorno
echo "==> Activando entorno mi_entorno_311"
source ~/anaconda3/bin/activate mi_entorno_311

# Navegar al directorio donde quieres trabajar
echo "==> Navegando a directorio de trabajo"
cd ~

# Clonar el repositorio de FAISS
echo "==> Clonando FAISS desde GitHub"
git clone https://github.com/facebookresearch/faiss.git

# Entrar al directorio clonado
cd faiss

# Cambiar a una versión específica (opcional, puedes cambiar la versión si lo deseas)
echo "==> Cambiando a la versión 1.7.4"
git checkout v1.7.4

# Crear un directorio de compilación
echo "==> Creando directorio de compilación"
mkdir build
cd build

# Configurar la compilación para CPU (sin CUDA)
echo "==> Configurando la compilación para solo CPU"
cmake .. -DFAISS_ENABLE_PYTHON=ON -DFAISS_ENABLE_GPU=OFF -DFAISS_ENABLE_CPU=ON -DBLA_VENDOR=OpenBLAS

# Compilar FAISS
echo "==> Compilando FAISS"
make -j$(nproc)

# Instalar FAISS
echo "==> Instalando FAISS"
sudo make install

# Instalar los bindings de Python (si no se instaló automáticamente)
cd ../python
echo "==> Instalando bindings de Python"
pip install .

# Volver al directorio principal
cd ..

# Verificar que FAISS está instalado correctamente
echo "==> Verificando instalación de FAISS"
python3 -c "import faiss; print(faiss.__version__)"

# Fin
echo "==> FAISS instalado correctamente para CPU"

# Elimina el SWIG roto si lo hay
conda remove swig -y

# Reinstala desde conda-forge
conda install -c conda-forge swig -y


pip install --no-cache-dir --only-binary=:all: faiss-cpu