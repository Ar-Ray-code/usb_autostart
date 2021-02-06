#!/bin/bash
USER_NAME=$(whoami)
echo ${USER_NAME}
sudo systemctl set-default multi-user.target

mkdir /home/${USER_NAME}/usb
sudo rm /etc/systemd/system/usb_ubuntu.service
rm /home/${USER_NAME}/.usb_mount.sh
sudo sh -c "echo 'source ~/.bashrc\nmount /dev/sda1 /home/${USER_NAME}/usb/\ncd /home/${USER_NAME}/\nsh /home/${USER_NAME}/usb/startup/start_service.sh\nwait' >> /home/${USER_NAME}/.usb_mount.sh"
sudo sh -c "echo '[Unit]\nDescripton=USB_Ubuntu Auto Start\nAfter=systemd-networkd-wait-online.service\n\n[Service]\nExecStart=/usr/bin/sudo /bin/sh /home/${USER_NAME}/.usb_mount.sh\n\nType=simple\n\nUser=ubuntu\nGroup=ubuntu\n\n[Install]\nWantedBy=multi-user.target' >> /etc/systemd/system/usb_ubuntu.service"

sudo systemctl enable usb_ubuntu.service
sudo reboot
