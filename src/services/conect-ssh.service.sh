#!/bin/bash

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