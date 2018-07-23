#!/bin/bash

#Selector by Wamphyre
#Version 1.0

test $? -eq 0 || exit 1 "Necesitas ser root para ejecutar este script"

echo "Bienvenido al Script Selector"

echo ""; sleep 3

echo "A lo largo de este script podrás seleccionar una serie de paquetes para instalar en tu sistema FreeBSD"

echo ""; sleep 3

echo "AVISO¡¡ EJECUTA SOLO ESTE SCRIPT EN UN SISTEMA LIMPIO"

echo ""

sleep 5

echo "Primero, actualicemos el gestor de paquetes y todos los paquetes del sistema"

echo ""; sleep 3

pkg update && pkg upgrade -y

echo ""

echo "Gestor de paquetes y paquetes instalados actualizados"

echo ""; sleep 3

echo "Actualizando Sistema Operativo"

echo "" ; sleep 3

freebsd-update fetch && freebsd-update install

echo "" 

echo "Obteniendo arbol de Ports";

echo ""

sleep 3

portsnap fetch extract

echo ""

sleep 3

echo "Arbol de ports extraido"

echo ""

sleep 3

echo "Mostrando entornos de escritorio recomendados"

echo ""

sleep 1

echo "XFCE"

echo ""

sleep 1

echo "MATE"

echo ""

sleep 1

echo "OPENBOX"

echo ""

echo ; read -p "¿Qué entorno quieres instalar?: " de ;

if [ "$de" = "xfce" ]

then

pkg install -y xorg slim xfce nano htop xarchiver zip rar xfce4-volumed-pulse xfce4-pulseaudio-plugin thunar-archive-plugin xfce-evolution mate-icon-theme-faenza slim-themes deadbeef vlc transmission filezilla bluefish gimp

sysrc moused_enable="YES"

sysrc dbus_enable="YES"

sysrc hald_enable="YES"

sysrc slim_enable="YES"

echo ""

echo ; read -p "¿Estás usando un Macbook?: " Y;

echo ""

if [ "$Y" = "si" ]

then

sysrc moused_enable="NO"

echo 'wsp_load="YES"' >> /boot/loader.conf

echo ""

echo "Driver para el touchpad de Mac cargado"

sleep 1

echo ""

else fi

cd

touch .xinitrc

echo 'exec xfce4-session' >> .xinitrc

echo ""

echo ; read -p "¿Quieres habilitar XFCE para otro usuario?: " X;

echo ""

if [ "$X" = "si" ]

then

echo ; read -p "Dime usuario: " user;

touch /usr/home/$user/.xinitrc

echo 'exec xfce4-session' >> /usr/home/$user/.xinitrc

echo ""

echo "$user habilitado"

else fi

echo ""

elif [ "$de" = "mate" ]

then

pkg install -y xorg slim mate-desktop mate nano htop xarchiver zip mate-icon-theme-faenza slim-themes deadbeef vlc transmission filezilla bluefish gimp

sysrc moused_enable="YES"

sysrc dbus_enable="YES"

sysrc hald_enable="YES"

sysrc slim_enable="YES"

echo ""

echo ; read -p "¿Estás usando un Macbook?: " Y;

echo ""

if [ "$Y" = "si" ]

then

sysrc moused_enable="NO"

echo 'wsp_load="YES"' >> /boot/loader.conf

echo ""

echo "Driver para el touchpad de Mac cargado"

sleep 1

echo ""

else fi

cd

touch .xinitrc

echo 'exec mate-session' >> .xinitrc

echo ""

echo ; read -p "¿Quieres habilitar MATE para otro usuario?: " X;

echo ""

if [ "$X" = "si" ]

then

echo ; read -p "Dime usuario: " user;

touch /usr/home/$user/.xinitrc

echo 'exec mate-session' >> /usr/home/$user/.xinitrc

echo ""

echo "$user habilitado"

else fi

echo ""

elif [ "$de" = "openbox" ]

then

pkg install -y openbox openbox-themes obconf obmenu obkey menumaker scrot compton lxappearance nitrogen tint2

sysrc moused_enable="YES"

sysrc dbus_enable="YES"

sysrc hald_enable="YES"

sysrc slim_enable="YES"

echo ""

echo ; read -p "¿Estás usando un Macbook?: " Y;

echo ""

if [ "$Y" = "si" ]

then

sysrc moused_enable="NO"

echo 'wsp_load="YES"' >> /boot/loader.conf

echo ""

echo "Driver para el touchpad de Mac cargado"

sleep 1

echo ""

else fi

cd

touch .xinitrc

echo "exec openbox-session" >> .xinitrc

echo ""

echo ; read -p "¿Quieres habilitar OpenBox para otro usuario?: " Z;

echo ""

if [ "$Z" = "si" ]

then

echo ; read -p "Dime usuario: " user;

touch /usr/home/$user/.xinitrc

echo "exec openbox-session" >> /usr/home/$user/.xinitrc

echo ""

echo "$user habilitado"

cd /usr/home/$user/

mkdir .config/openbox

cp /usr/local/etc/xdg/openbox/* /usr/home/$user/.config/openbox/

pw groupmod video -m $user

echo '#Barra de tareas
tint2 &' >> /.config/openbox/autostart 

echo '#Compositor de ventanas
compton -CcGF &' >> /.config/openbox/autostart

echo '#Wallpaper
nitrogen --restore &' >> /.config/openbox/autostart

echo '#conky
conky &' >> /.config/openbox/autostart

echo '#volumeicon
volumeicon &' >> /.config/openbox/autostart

else fi

echo ""

else

echo "No se instalará ningún entorno de escritorio"

fi

echo ""

echo "Mostrando navegadores web recomendados"

echo ""

echo "Chromium"

echo "" ; sleep 1

echo "Firefox"

echo "" ; sleep 1

echo "Midori"

echo "" ; sleep 1

echo ; read -p "¿Qué navegador web quieres instalar? " browser ;

echo ""

if [ "$browser" = "chromium" ]

then

pkg install -y chromium

elif [ "$browser" = "firefox" ]

then 

pkg install -y firefox-esr

elif [ "$browser" = "midori" ]

then

pkg install -y midori

else

echo "No se instalará ningún navegador"

fi

echo ""

echo ; read -p "¿Quieres compilar los drivers de NVIDIA?: " gpu;

echo ""

if [ "$gpu" = "si" ]

then

echo ; read -p "¿Tienes una NVIDIA antigua o moderna?: " gpu2;

if [ "$gpu2" = "antigua" ]

then

kldload linux.ko

sysrc linux_enable="YES"

cd /usr/ports/x11/nvidia-driver-340
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-settings
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-xconfig
make install clean BATCH=yes

echo 'nvidia_load="YES"' >> /boot/loader.conf

nvidia-xconfig

echo ""

echo "Driver instalado"

echo ""

elif [ "$gpu2" = "moderna" ]

then

kldload linux.ko

sysrc linux_enable="YES"

cd /usr/ports/x11/nvidia-driver
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-settings
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-xconfig
make install clean BATCH=yes

echo 'nvidia-modeset_load="YES"' >> /boot/loader.conf

nvidia-xconfig

echo ""

echo "Driver instalado"

else fi

else echo "No se instalarán los drivers de la GPU"

fi

echo "Optimizando Sistema"

echo ""

sleep 2

mv /etc/sysctl.conf /etc/sysctl.conf.bk
echo 'vfs.usermount=1' >> /etc/sysctl.conf
echo 'vfs.vmiodirenable=0' >> /etc/sysctl.conf
echo 'vfs.read_max=4' >> /etc/sysctl.conf
echo 'kern.ipc.shmmax=67108864' >> /etc/sysctl.conf
echo 'kern.ipc.shmall=32768' >> /etc/sysctl.conf
echo 'kern.ipc.somaxconn=256' >> /etc/sysctl.conf
echo 'kern.ipc.shm_use_phys=1' >> /etc/sysctl.conf
echo 'kern.ipc.somaxconn=32' >> /etc/sysctl.conf
echo 'kern.maxvnodes=60000' >> /etc/sysctl.conf
echo 'kern.coredump=0' >> /etc/sysctl.conf
echo 'kern.sched.preempt_thresh=224' >> /etc/sysctl.conf
echo 'kern.sched.slice=3' >> /etc/sysctl.conf
echo 'kern.maxfiles=10000' >> /etc/sysctl.conf
echo 'hw.snd.feeder_rate_quality=3' >> /etc/sysctl.conf
echo 'hw.snd.maxautovchans=32' >> /etc/sysctl.conf
echo 'vfs.lorunningspace=1048576' >> /etc/sysctl.conf
echo 'vfs.hirunningspace=5242880' >> /etc/sysctl.conf
echo 'kern.ipc.shm_allow_removed=1' >> /etc/sysctl.conf
echo 'hint.pcm.0.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.1.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.2.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.3.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.4.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.5.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.6.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.7.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.8.eq="1"' >> /boot/loader.conf
echo 'hint.pcm.9.eq="1"' >> /boot/loader.conf
echo 'hw.snd.vpc_autoreset=0' >> /boot/loader.conf
echo 'hw.syscons.bell=0' >> /boot/loader.conf
echo 'hw.usb.no_pf=1' >> /boot/loader.conf
echo 'hw.usb.no_boot_wait=0' >> /boot/loader.conf
echo 'hw.usb.no_shutdown_wait=1' >> /boot/loader.conf
echo 'hw.psm.synaptics_support=1' >> /boot/loader.conf
echo 'kern.maxfiles="25000"' >> /boot/loader.conf
echo 'kern.maxusers=16' >> /boot/loader.conf
echo 'kern.cam.scsi_delay=10000' >> /boot/loader.conf
touch /etc/pf.conf
echo 'block in all' >> /etc/pf.conf
echo 'pass out all keep state' >> /etc/pf.conf
sysrc pf_enable="YES"
sysrc pf_rules="/etc/pf.conf" 
sysrc pf_flags=""
sysrc pflog_enable="YES"
sysrc pflog_logfile="/var/log/pflog"
sysrc pflog_flags=""
sysrc ntpd_enable="YES"
sysrc ntpdate_enable="YES"
sysrc powerd_enable="YES"
sysrc powerd_flags="-a hiadaptive"
sysrc clear_tmp_enable="YES"
sysrc syslogd_flags="-ss"
sysrc sendmail_enable="NONE"
sysrc dumpdev="NO"

echo "Sistema optimizado"

sleep 2

echo ""

echo "Actualizando microcódigo de la CPU..."

echo ""

sleep 2

pkg install -y devcpu-data

sysrc microcode_update_enable="YES"

service microcode_update start

echo ""

echo "Microcódigo actualizado"

echo ""

echo "Aplicando Hardening"

sleep 2

echo ""

touch /etc/sysctl.conf

echo 'kern.elf64.nxstack=1' >> /etc/sysctl.conf
echo 'sysctl security.bsd.map_at_zero=0' >> /etc/sysctl.conf
echo 'security.bsd.see_other_uids=0' >> /etc/sysctl.conf
echo 'security.bsd.see_other_gids=0' >> /etc/sysctl.conf
echo 'security.bsd.unprivileged_read_msgbuf=0' >> /etc/sysctl.conf
echo 'security.bsd.unprivileged_proc_debug=0' >> /etc/sysctl.conf
echo 'kern.randompid=9800' >> /etc/sysctl.conf
echo 'security.bsd.stack_guard_page=1' >> /etc/sysctl.conf
echo 'net.inet.udp.blackhole=1' >> /etc/sysctl.conf
echo 'net.inet.tcp.blackhole=2' >> /etc/sysctl.conf
echo 'net.inet.ip.random_id=1' >> /etc/sysctl.conf

sleep 1

echo ".....25%"

sleep 2

echo "..............35%"

sleep 2

echo "........................75%"

sleep 2

echo "..................................100%"

sleep 2

echo ""

echo "Sistema Securizado"

echo ""

echo "Limpiando Sistema"

echo ""

sleep 1

pkg clean -y

echo ""

echo "Sistema limpio"

echo ""

echo "Por favor, reinicia ahora tu sistema"

echo ""

echo "Selector by Wamphyre :)"

echo ""

echo "https://wamphyre.tk"
