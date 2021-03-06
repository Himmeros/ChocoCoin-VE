    # Proyectos Himmeros
    # sistemas_que_funcionan_
    # 012022
    # Versión 0.5

    # Ya debes tener git instalado para efectuar la clonación a lo
    # Resident Evil ><

    # 1° Instalo git
sudo apt -y install git

    # 2° Descargo Chococoin desde su repositorio y accedo al directorio
git clone https://github.com/Himmeros/ChocoCoin-VE/ && cd ChocoCoin-VE

    # 3° Scripts de librerías necesarias para compilar ChocoCoin
sudo apt-get -y install build-essential libboost-all-dev

    # 4° Resuelve un error con OpenSSL ya que necesita una versión vieja

sudo apt-get -y remove libssl-dev
sudo apt -y install libssl1.0-dev

    # 5° Agrego libdb

sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get -y update && sudo apt -y upgrade
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install -y libminiupnpc-dev

    # 6° Vamos a necesitar memoria, así­ que ampliamos la memoria virtual o swap file
    # 6.a # Apago y elimino la memoria virtual

sudo swapoff /swapfile && sudo rm /swapfile

    # 7° Creo una memoria virtual más grande

sudo dd if=/dev/zero of=/swapfile bs=1024 count=4194304
sudo chmod 600 /swapfile
sudo mkswap /swapfile && sudo swapon /swapfile

    # 8° Corrige un posible error de permisos

chmod 755 src/leveldb/build_detect_platform

    # 9° Y limpio, para que no de errores

cd src/leveldb 
make clean
cd ../..

    # 10° En este punto podemos compilar a Satanás
cd src
make -f makefile.unix

    # Compilación Qt4
    # Instalo las librerías necesarias para la compilación del monedero Qt

    # 1° Librerías Qt4
sudo apt-get install -y qt4-qmake libqt4-dev

    # 2° Compilamos desde ChocoChoin-VE
qmake && make

# --------------------------------------------------------------------------------- #

    # Anexo errores

    # Errores de compilaciÃ³n

    # /home/gabriel/ChocoCoin-1/src/leveldb.cpp:76: referencia a `leveldb::Status::ToString[abi:cxx11]() const' sin definir
    # collect2: error: ld returned 1 exit status
    # makefile.unix:182: fallo en las instrucciones para el objetivo 'chococoind'
    # make: *** [chococoind] Error 1

    # Se debe ejecutar ::

    # cd src/leveldb 
    # make clean
    # cd ../..

# --------------------------------------------------------------------------------- #

    # g++: error: /home/gabriel/ChocoCoin/src/leveldb/libleveldb.a: No existe el archivo o el directorio
    # g++: error: /home/gabriel/ChocoCoin/src/leveldb/libmemenv.a: No existe el archivo o el directorio
    # Makefile:310: fallo en las instrucciones para el objetivo 'chococoin-qt'
    # make: *** [chococoin-qt] Error 1

    # Se debe ejecutar de nuevo ::

    # cd src
    # make -f makefile.unix

# --------------------------------------------------------------------------------- #

    # Si muestra estos errores cuando se compila Qt ::

    # /usr/bin/ld: no se puede encontrar -lboost_system-mgw46-mt-sd-1_53
    # /usr/bin/ld: no se puede encontrar -lboost_filesystem-mgw46-mt-sd-1_53
    # /usr/bin/ld: no se puede encontrar -lboost_program_options-mgw46-mt-sd-1_53
    # /usr/bin/ld: no se puede encontrar -lboost_thread-mgw46-mt-sd-1_53
    # collect2: error: ld returned 1 exit status
    # Makefile:310: fallo en las instrucciones para el objetivo 'chococoin-qt'
    # make: *** [chococoin-qt] Error 1

    # Modificar lo siguiente en chococoin-pro ::

    # There is a little error in the chococoin-qt.pro file which forces make to use a very specific version of boost. Open ~/src/Memecoin/memecoin-qt.pro and change the line that says
    # LIBS += -lboost_system-mgw46-mt-sd-1_53 -lboost_filesystem-mgw46-mt-sd-1_53 -lboost_program_options-mgw46-mt-sd-1_53 -lboost_thread-mgw46-mt-sd-1_53
    # into
    # LIBS += -lboost_system -lboost_filesystem -lboost_program_options -lboost_thread

    # BOOST_LIB_SUFFIX=-mgw46-mt-sd-1_53
    # should become
    # BOOST_LIB_SUFFIX=

    # and deleting the following lines

    # isEmpty(BOOST_LIB_SUFFIX) {
    # macx:BOOST_LIB_SUFFIX = -mt
    # windows:BOOST_LIB_SUFFIX = -mgw44-mt-s-1_53
    # }