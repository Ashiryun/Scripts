# Submenú para Gestión de Usuarios

submenu_usuarios() {

    while true; do

        clear

        echo "### Submenú de Gestión de Usuarios ###"

        echo "1. Crear Usuario"

        echo "2. Eliminar Usuario"

        echo "3. Cambiar Contraseña de Usuario"

        echo "4. Mostrar Información de Usuario"      

        echo "5. Listar Usuarios"

        echo "6. Añadir Usuario a Grupo"      

        echo "7. Ir a Gestión de Grupos"

        echo "0. Regresar al Menú Principal"

 

        read -p "Ingrese el número de opción: " opcion

 

        case $opcion in

            1)

                echo "Ingrese el nombre de usuario a crear: "

                read username

                useradd "$username"

                echo "Usuario $username creado exitosamente."

                ;;

            2)

                echo "Ingrese el nombre de usuario a eliminar: "

                read username

                userdel "$username"

                echo "Usuario $username eliminado exitosamente."

                ;;

            3)

                echo "Ingrese el nombre de usuario para cambiar la contraseña: "

                read username

                passwd "$username"

                ;;

            4)

                echo "Ingrese el nombre de usuario para mostrar información: "

                read username

                id "$username"

                ;;

         

5)

                echo "### Lista de Usuarios ###"

                cut -d: -f1 /etc/passwd

                ;;

             6)

                echo "Ingrese el nombre del usuario: "

                read username

                echo "Ingrese el nombre del grupo al que desea añadir al usuario: "

                read groupname

                gpasswd -a "$username" "$groupname"

                echo "Usuario $username añadido al grupo $groupname."

                ;;

 

            7)

                submenu_grupos
break

                ;;

            0)

                mostrar_menu
break
                ;;

            *)

                echo "Opción inválida. Ingrese una opción válida."

                ;;

        esac

 

        read -p "Presione Enter para continuar..."

    done

}


# Submenú para Gestión de Grupos

submenu_grupos() {

    while true; do

        clear

        echo "### Submenú de Gestión de Grupos ###"

        echo "1. Crear Grupo"

        echo "2. Eliminar Grupo"

        echo "3. Añadir Usuario a Grupo"

        echo "4. Quitar Usuario de Grupo"

        echo "5. Listar Grupos"

        echo "6. Ir a Gestión de Usuarios"

echo "0. Regresar al Menú Principal"

 

        read -p "Ingrese el número de opción: " opcion

 

        case $opcion in

            1)

                echo "Ingrese el nombre del grupo a crear: "

                read groupname

                groupadd "$groupname"

                echo "Grupo $groupname creado exitosamente."

                ;;

            2)

                echo "Ingrese el nombre del grupo a eliminar: "

                read groupname

                groupdel "$groupname"

                echo "Grupo $groupname eliminado exitosamente."

                ;;

            3)

                echo "Ingrese el nombre del usuario: "

                read username

                echo "Ingrese el nombre del grupo al que desea añadir al usuario: "

                read groupname

                gpasswd -a "$username" "$groupname"

                echo "Usuario $username añadido al grupo $groupname."

                ;;

            4)

                echo "Ingrese el nombre del usuario: "

                read username

                echo "Ingrese el nombre del grupo del que desea quitar al usuario: "

                read groupname

                gpasswd -d "$username" "$groupname"

                echo "Usuario $username eliminado del grupo $groupname."

                ;;

            5)

                echo "### Lista de Grupos ###"

                cut -d: -f1 /etc/group

                ;;

  6)

submenu_usuarios
break
;;

            0)

                mostrar_menu
break
                ;;

            *)

                echo "Opción inválida. Ingrese una opción válida."

                ;;

        esac

 

        read -p "Presione Enter para continuar..."

    done

}

 

# Submenú para Configuración de Red

submenu_red() {

    while true; do

        clear

        echo "### Submenú de Configuración de Red ###"

        echo "1. Asignar IP estática"

        echo "2. Desactivar interfaz de red"

        echo "3. Salir"

        read -p "Seleccione una opción (1-3): " opcion

 

        case $opcion in

            1)

                clear

                echo "### Asignar IP estática ###"

                read -p "Ingrese la dirección IP: " ip_address

                read -p "Ingrese la máscara de red (ej. 255.255.255.0): " netmask

                sudo ifconfig enp0s3 $ip_address netmask $netmask up

                echo "IP asignada correctamente."

                read -p "Presione Enter para continuar..."

                ;;

            2)

                clear

                echo "### Desactivar interfaz de red ###"

                sudo ifconfig enp0s3 down

                echo "Interfaz de red desactivada."

                read -p "Presione Enter para continuar..."

                ;;

            3)

                break

                ;;

            *)

                echo "Opción no válida. Por favor, seleccione una opción válida (1-3)."

                read -p "Presione Enter para continuar..."

                ;;

        esac

    done

}



registro_de_comandos() {

    read -p "Ingrese el nombre de usuario cuyo historial de comandos desea ver: " username

 

    # Verifica si el usuario existe o no

    if id "$username" &>/dev/null; then

        # Muestra el historial de comandos de ese usuario

        less "/home/$username/.bash_history"

    else

        echo "El usuario '$username' no existe."

    fi

}

# Submenú para Logs Propios de la Empresa
submenu_logs_propios() {
    while true; do
        clear
        echo "### Submenú de Logs Propios de la Empresa ###"
        echo "1. Ver Registro de Autenticación"
        echo "2. Ver Registro del Sistema"
        echo "3. Ver Registro de Comandos"
        echo "4. Ver Registro de Acceso a Archivos"
        echo "5. Ver Registro de Cambios en la Configuración del Sistema"
        echo "6. Ver Registro de Acceso Remoto (ssh.log)"
        echo "7. Ver Registro de Eventos de Seguridad de Contenedores"
        echo "8. Ver Registro de Eventos de Base de Datos"
        echo "9. Ver Registro de Firewall (iptables.log)"
        echo "10. Ver Registro de Auditoría de Archivos"
        echo "11. Ver Registro de Correo Electrónico (mail.log)"
        echo "12. Ver Registro de Acceso a Archivos (file access log)"
        echo "13. Ver Registro de Actividad de Firewall de Aplicaciones (WAF)"
        echo "14. Ver Registro de Acceso Remoto a la Base de Datos"
        echo "0. Regresar al Menú Principal"

        read -p "Ingrese el número de opción: " opcion

        case $opcion in
            1)
                less /var/log/auth.log
                ;;
            2)
                less /var/log/syslog
                ;;
   3)
                registro_de_comandos
                ;;
            4)
                less /var/log/file_access.log
                ;;
            5)
                less /var/log/audit/audit.log
                ;;
            6)
                less /var/log/secure
                ;;
            7)
                less /var/log/docker.log
                ;;
            8)
                less /var/log/mysql/error.log
                ;;
            9)
                less /var/log/nftables.log
                ;;
            10)
                less /var/log/audit/audit.log
                ;;
            11)
                less /var/log/mail.log
                ;;
            12)
                less /var/log/file_access.log
                ;;
            13)
                less /var/log/httpd/modsec_audit.log
                ;;
            14)
                less /var/log/remote_db.log
                ;;
            0)
                return
                ;;
            *)
                echo "Opción inválida. Ingrese una opción válida."
                ;;
        esac
    done
}


# Submenú para Gestión de Servicios
submenu_servicios() {
    clear
    echo "### Submenú de Gestión de Servicios ###"
    echo "1. Iniciar Docker"
    echo "2. Iniciar Firewalld"
    echo "3. Regresar al Menú Principal"

    read -p "Ingrese el número de opción: " opcion

    case $opcion in
        1)
            echo "Iniciando servicio Docker..."
            systemctl start docker
            ;;
        2)
            echo "Iniciando servicio Firewalld..."
            systemctl start firewalld
            ;;
        3)
            return
            ;;
        *)
            echo "Opción inválida. Ingrese una opción válida."
            ;;
    esac

    read -p "Presione Enter para continuar..."
}

# Submenú para Configuración de Firewall
submenu_firewall() {

clear

echo "### Submenú de Configuración de Firewall ###"

read -p "Ingrese la dirección IP que desea bloquear: " ip_address

echo "Configurando firewall para bloquear la dirección IP $ip_address..."

sudo iptables -A INPUT -s "$ip_address" -j DROP

  read -p "Presione enter para continuar"

}


# Submenú para Respaldo Local
submenu_respaldo_local() {
    clear
    echo "### Submenú de Respaldo Local ###"
    echo "Realizando respaldo de iptables..."
    sudo iptables-save > /backup/iptables_backup.rules
    echo "Respaldo realizado correctamente"
    read -p "Presione Enter para continuar..."
}

# Submenú para Respaldo Remoto

submenu_respaldo_remoto() {

    clear

    echo "### Submenú de Respaldo Remoto ###"

 

    # Pedir la ruta del directorio local a respaldar

    read -p "Ingrese la ruta del directorio local a respaldar: " directorio_local

 

    # Pedir el usuario y la dirección del servidor remoto

    read -p "Ingrese el nombre de usuario del servidor remoto: " usuario_remoto

    read -p "Ingrese la dirección del servidor remoto (IP o nombre de host): " servidor_remoto

 

    # Pedir la ruta del directorio de destino en el servidor remoto

    read -p "Ingrese la ruta del directorio de destino en el servidor remoto: " directorio_destino_remoto

 

    # Realizar el respaldo remoto utilizando rsync

    rsync -avz -e ssh "$directorio_local" "$usuario_remoto@$servidor_remoto:$directorio_destino_remoto"

 

    echo "Respaldo remoto realizado correctamente."

 

    read -p "Presione Enter para continuar..."

}

# Función para mostrar el menú principal

mostrar_menu() {

    clear

    echo "### Menú del Operador del Centro de Cómputos ###"

    echo "1. Gestión de Usuarios"

    echo "2. Gestión de Grupos"

    echo "3. Configuración de Red"

    echo "4. Gestión de Servicios"

    echo "5. Configuración de Firewall"

    echo "6. Respaldo Local"

    echo "7. Respaldo Remoto"

    echo "8. Ver Logs de Auditoría"

    echo "9. Ver Logs Propios de la Empresa"

    echo "0. Salir"

}

 

# Loop principal

while true; do

    mostrar_menu

    read -p "Ingrese el número de opción: " opcion

 

    case $opcion in

        1)

            submenu_usuarios

            ;;

        2)

            submenu_grupos

            ;;

        3)

            submenu_red

            ;;

        4)

            submenu_servicios

            ;;

        5)

            submenu_firewall

            ;;

        6)

            submenu_respaldo_local

            ;;

        7)

            submenu_respaldo_remoto

            ;;

        8)

            less /var/log/audit/audit.log

            ;;

        9)

            submenu_logs_propios

            ;;

        0)

            echo "Saliendo del script."

            break

            ;;

        *)

            echo "Opción inválida. Ingrese una opción válida."

            ;;

    esac

done

