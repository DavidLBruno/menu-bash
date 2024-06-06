#!/bin/bash

CONFIG_FILE="$1/config/.configOpenForti"

if [ ! -f "$CONFIG_FILE" ]
then
    touch "$CONFIG_FILE"
fi

while true; do
    if sudo openfortivpn -c "$CONFIG_FILE"; then
        echo "Conexión VPN exitosa."
        break
    else
        echo "La conexión VPN falló. Reintentando en 3 segundos..."
        sleep 3
    fi
done