#!/bin/bash

link="/menu"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/index.sh"
SERVICES='./services/';

if [ ! -L "$link" ]
then
    echo "El enlace simbólico no existe. Creando el enlace simbólico..."
    ln -s "$script" "$DIR"
fi

while true
do
    echo "1. Abrir OpenForti"
    echo "2. Conectar por ssh"
    echo "3. Opcion 3"
    echo "4. Salir"
    echo -n "Por favor, elige una opción: "
    read opcion

    case $opcion in
        1) bash ${SERVICES}'openforti.service.sh'
           ;;
        2) bash ${SERVICES}'conect-ssh.service.sh'
           ;;
        3) echo 'Proxima opcion'
           ;;
        4) echo "¡Hasta luego!"
           exit
           ;;
        *) echo "$opcion no es una opción válida."
           ;;
    esac
done

exit 1
