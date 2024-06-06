#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/index.sh"
link="$HOME/menu"
ROUTE="$( cd "$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )" &> /dev/null && pwd )"

if [ ! -L "$link" ]
then
    echo "El enlace simbólico no existe. Creando el enlace simbólico..."
    sudo ln -sf "$DIR" "$link"
fi

while true
do
    echo "1. Abrir OpenForti"
    echo "2. Conectar por ssh"
    echo "3. Actualizar paquetes"
    echo "4. Salir"
    echo -n "Por favor, elige una opción: "
    read opcion

    case $opcion in
        1) bash ${ROUTE}/services/openforti.service.sh $ROUTE
           ;;
        2) bash ${ROUTE}/services/conect-ssh.service.sh $ROUTE
           ;;
        3) bash ${ROUTE}/services/update-ubuntu.service.sh $ROUTE
           ;;
        4) echo "¡Hasta luego!"
           exit
           ;;
        *) echo "$opcion no es una opción válida."
           ;;
    esac
done

exit 1
