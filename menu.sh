#!/bin/bash

while true
do
    echo "Menú interactivo"
    echo "1 Abrir OpenForti"
    echo "2. Conectar SSH"
    echo "3. Salir"
    echo -n "Por favor, selecciona una opción: "
    read opcion

    case $opcion in
        1) echo "Has seleccionado la opción 1, ejecutando bloque de código..."
            CONFIG_FILE=".configOpenForti"
            while true; do
               if sudo openfortivpn -c "$CONFIG_FILE"; then
                  echo "Conexión VPN exitosa."
                  break
               else
                  echo "La conexión VPN falló. Reintentando en 3 segundos..."
                  sleep 3
               fi
            done
            ;;
        2) echo "Has seleccionado la opción 2, ejecutando bloque de código..."
            if [ ! -f credenciales-ssh.txt ]; then
               echo -e "USERNAME=\nPASSWORD=\nHOST=" > credenciales-ssh.txt
            fi

            while IFS= read -r line
            do
               if [[ $line == USERNAME=* ]]; then
                  USERNAME=${line#*=}
               elif [[ $line == PASSWORD=* ]]; then
                  PASSWORD=${line#*=}
               elif [[ $line == HOST=* ]]; then
                  HOST=${line#*=}
               elif [[ $line == PORT=* ]]; then
                  PORT=${line#*=}
               fi
            done < credenciales-ssh.txt

            if [ -z "$USERNAME" ]; then
               echo "Por favor, introduce tu nombre de usuario:"
               read USERNAME
               echo "USERNAME=$USERNAME" > credenciales-ssh.txt
            fi

            if [ -z "$PASSWORD" ]; then
               echo "Por favor, introduce tu contraseña:"
               read -s PASSWORD
               echo "PASSWORD=$PASSWORD" >> credenciales-ssh.txt
            fi

            if [ -z "$HOST" ]; then
               echo "Por favor, introduce tu url:"
               read -s HOST
               echo "HOST=$HOST" >> credenciales-ssh.txt
            fi

            if [ -z "$PORT" ]; then
               echo "Por favor, introduce el puerto:"
               read -s PORT
               echo "HOST=$PORT" >> credenciales-ssh.txt
            fi

            sshpass -p $PASSWORD ssh -p$PORT $USERNAME@$HOST
            ;;
        3) echo "Saliendo..."
            break
            ;;
        *) echo "$opcion no es una opción válida, por favor intenta de nuevo."
            ;;
    esac
done