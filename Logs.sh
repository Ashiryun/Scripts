#!/bin/bash

# Script que maneja logs del Sistema Operativo

# Directorio de logs
LOG_DIR="/var/log"

# Función para listar logs disponibles
function listar_logs() {
    ls $LOG_DIR
}

# Función para ver un log específico
function ver_log() {
    if [ -f "$LOG_DIR/$1" ]; then
        less $LOG_DIR/$1
    else
        echo "El archivo de log '$1' no existe."
    fi
}

# Función para buscar eventos en un log
function buscar_en_log() {
    if [ -f "$LOG_DIR/$1" ]; then
        grep -i "$2" $LOG_DIR/$1
    else
        echo "El archivo de log '$1' no existe."
    fi
}

# Función para realizar una copia de seguridad de un log
function copia_de_seguridad() {
    if [ -f "$LOG_DIR/$1" ]; then
        cp $LOG_DIR/$1 "$LOG_DIR/${1}_backup_$(date +"%Y%m%d%H%M%S")"
        echo "Copia de seguridad de '$1' creada exitosamente."
    else
        echo "El archivo de log '$1' no existe."
    fi
}

function eliminar_log() {
    if [ -f "$LOG_DIR/$1" ]; then
        rm $LOG_DIR/$1
        echo "El archivo de log '$1' ha sido eliminado."
    else
        echo "El archivo de log '$1' no existe."
    fi
}

function ultima_linea_log() {
    if [ -f "$LOG_DIR/$1" ]; then
        tail -n 1 $LOG_DIR/$1
    else
        echo "El archivo de log '$1' no existe."
    fi
}

function contar_lineas_log() {
    if [ -f "$LOG_DIR/$1" ]; then
        num_lineas=$(wc -l < "$LOG_DIR/$1")
        echo "El archivo de log '$1' contiene $num_lineas líneas."
    else
        echo "El archivo de log '$1' no existe."
    fi
}

function buscar_por_fecha() {
    echo -n "Ingrese el nombre del log: "
    read nombre_log
    echo -n "Ingrese la fecha de inicio (YYYY-MM-DD): "
    read fecha_inicio
    echo -n "Ingrese la fecha de fin (YYYY-MM-DD): "
    read fecha_fin
   
    if [ -f "$LOG_DIR/$nombre_log" ]; then
        grep -i -E "($fecha_inicio|$fecha_fin)" $LOG_DIR/$nombre_log
    else
        echo "El archivo de log '$nombre_log' no existe."
    fi
}

function espacio_en_disco() {
    df -h
}

function estado_del_sistema() {
    top -n 1
}

function info_de_hardware() {
    lshw
}

function usuarios_conectados() {
    who
}

function info_del_sistema() {
    uname -a
}

function historial() {
#Normalmente se usa History, pero en mi caso se almacena en otro lado.
cat 10000
}

function reiniciar_sistema() {
    echo "Reiniciando el sistema..."
    sudo reboot
}

function apagar_sistema() {
    echo "Apagando el sistema..."
    sudo shutdown -h now
}

# Función para el submenú
function submenu() {
while true; do
    echo ""
    echo "=== Submenú ==="
    echo "¿Qué acción desea realizar?"
    echo "14. Listar logs"
    echo "15. Ver un log específico"
    echo "16. Buscar eventos en un log"
    echo "17. Realizar copia de seguridad de un log"
    echo "18. Mostrar la última línea de un log"
    echo "19. Contar la cantidad de líneas en un log"
    echo "20. Eliminar un log"
    echo "21. Volver al menú principal"

    echo ""
    echo -n "Escribe aquí: "
    read opcion_submenu

    case $opcion_submenu in
        14)
            listar_logs
            ;;
        15)
            echo -n "Ingrese el nombre del log que desea ver: "
            read nombre_log
            ver_log $nombre_log
            ;;
        16)
            echo -n "Ingrese el nombre del log: "
            read nombre_log
            echo -n "Ingrese el texto a buscar: "
            read texto_buscar
            buscar_en_log $nombre_log "$texto_buscar"
            ;;
        17)
            echo -n "Ingrese el nombre del log para hacer una copia de seguridad: "
            read nombre_log
            copia_de_seguridad $nombre_log
            ;;
        18)
            echo -n "Ingrese el nombre del log para ver la última línea: "
            read nombre_log
            ultima_linea_log $nombre_log
            ;;
        19)
            echo -n "Ingrese el nombre del log para contar las líneas: "
            read nombre_log
            contar_lineas_log $nombre_log
            ;;
        20)
            echo -n "Ingrese el nombre del log que desea eliminar: "
            read nombre_log
            eliminar_log $nombre_log
            ;;
        21)
            return
            ;;
        *)
            echo "Opción no válida. Por favor, ingrese un número del 14 al 21."
            ;;
    esac
  done
}

# Uso del script
while true; do
    echo ""
    echo "=== Menú Principal ==="
    echo "¿Qué acción desea realizar?"
    echo "1. Ver los usuarios conectados"
    echo "2. Inicios de sesión fallidos"
    echo "3. Ver último inicio de sesión de usuario"
    echo "4. SSH en determinada fecha"
    echo "5. Eventos de cron en determinada fecha"
    echo "6. Ver espacio en disco"
    echo "7. Información de hardware"
    echo "8. Mostrar información del sistema"
    echo "9. Ver el historial de comandos"
    echo "10. Reiniciar el sistema"
    echo "11. Apagar el sistema"
    echo "12. Acceder al Submenú"
    echo "00. Salir"
    echo ""
    echo -n "Escribe aquí: "
    read opcion

    case $opcion in
        1)
            usuarios_conectados
            ;;

    2) journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password"
   ;;

    3) journalctl_UID=$(id -u) | grep "session opened for user" | tail -n 1    ;;

4) read -p "Introduce la fecha en formato 'YYYY-MM-DD': " fecha
journalctl -u sshd --since="$fecha 00:00:00" --until="$fecha 23:59:59"
  ;;

    5) read -p "Introduce la fecha en formato 'YYYY-MM-DD': " fecha
      journalctl -u cron --since="$fecha 00:00:00" --until="$fecha 23:59:59"
           ;;      
   
    6)
            espacio_en_disco
            ;;
        7)
            info_de_hardware
            ;;
        8)
            info_del_sistema
            ;;
        9)
            historial
            ;;
        10)
            reiniciar_sistema
            ;;
        11)
            apagar_sistema
            ;;
        12)
            submenu
            ;;
        00)
            echo "Saliendo del script."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, ingrese un número del 1 al 13."
            ;;
    esac
done

