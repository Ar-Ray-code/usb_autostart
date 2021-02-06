sudo apt update
sudo apt upgrade

mkdir /home/$(whoami)/usb
sudo echo -e "[Unit]\nDescripton=USB_Ubuntu Auto Start\nAfter=systemd-networkd-wait-online.service\n\n[Service]\nExecStart=/usr/bin/sudo /bin/sh /home/$(whoami)/.usb_mount.sh\n\nType=simple\n\nUser=ubuntu\nGroup=ubuntu\n\n[Install]\nWantedBy=multi-user.target" >> /etc/systemd/system/usb_ubuntu.service

echo -e "source ~/.bashrc\nmount /dev/sda1 /home/$(whoami)/usb/\nsh /home/$(whoami)/usb/startup/start_service.sh\nwait" >> /home/$(whoami)/.usb_mount.sh
sudo systemctl enable usb_ubuntu.service
sudo reboot