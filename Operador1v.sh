Menu de Administrador:

#!/bin/bash
# Menú principal
while true; do
echo "1. Crear usuario"
echo "2. Eliminar usuario"
echo "3. Crear grupo"
echo "4. Eliminar grupo"
echo "5. Configurar red"
echo "6. Gestionar servicios"
echo "7. Configurar firewall"
echo "8. Realizar respaldo local"
echo "9. Salir"
read -p "Ingrese el número de opción: " option
case $option in
1)
read -p "Ingrese el nombre de usuario a crear: " username
useradd "$username"
echo "Usuario $username creado exitosamente."
;;
2)
read -p "Ingrese el nombre de usuario a eliminar: " username
userdel "$username"
echo "Usuario $username eliminado exitosamente."
;;
3)
read -p "Ingrese el nombre del grupo a crear: " groupname
groupadd "$groupname"
echo "Grupo $groupname creado exitosamente."
;;
4)
read -p "Ingrese el nombre del grupo a eliminar: " groupname
groupdel "$groupname"
echo "Grupo $groupname eliminado exitosamente."
;;
5)
echo "Configuración de red..."
sudo ifconfig eth0 192.168.1.10 netmask 255.255.255.0 up # Asignación de ip esatica
;;
6)
echo "Iniciando servicio Docker y iptables..."
systemctl start docker
systemctl start firewalld
;;
7)
echo "Configuración de firewall..."
sudo iptables -A INPUT -s 167.56.193.209 -j DROP #bloquear entrada de una ip
;;
8)
echo "Realizando respaldo de iptables..."
sudo iptables-save > /backup/iptables_backup.rules
echo "Respaldo realizado correctamente"
;;
9)
echo "Saliendo del script."
break
;;
*)
echo "Opción inválida. Ingrese una opción válida."
;;
esac
done
