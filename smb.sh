#!/usr/bin/bash

smbConfWrite () {
    data ="
[usb]
    comment = Media Share
    path = /media/USBDrive
    writeable = yes
    force group = pi
    create mask = 0660
    directory mask = 0771
    read only = no

[pi-share]
    comment = Pi Share
    path = /home/pi
    writeable = yes
    force group = pi
    create mask = 0660
    directory mask = 0771
    read only = no"
    if grep -q $data /etc/samba/smb.conf; then
        tput setaf 1; echo "Data has already been written!"
        tput setaf 2; echo "resetting smbd"
        sudo systemctl restart smbd
    else
        echo $data >> /etc/samba/smb.conf
        tput setaf 2; echo "done!"
        tput setaf 2; echo "resetting smbd"
        sudo systemctl restart smbd
        tput setaf 2; echo "Config is ready."
    fi
    
}


sambaSetup () {
    tput setaf 3;
    which samba > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Samba already installed!"
        tput setaf 3;
    else
        echo "Setting up samba"
        cd /media
        sudo mkdir USBDrive
        sudo umount /dev/sda1
        tput setaf 3; echo "mounting /dev/sda1 /media/USBDrive"
        sudo mount /dev/sda1 /media/USBDrive
        tput setaf 3; echo "Downloading samba..."
        sudo apt-get install samba samba-common-bin
        tput setaf 3; echo "creating backup for smb.conf"
        cp /etc/samba/smb.conf /etc/samba/smb.conf.bak  #Make a backup of the config file
        tput setaf 3; echo "updating the smb.conf file"
        smbConfWrite
        tput setaf 5; echo "Please enter samba password"
        read pass
        sudo smbpasswd -a $pass
        tput setaf 2; echo "Please run setup.sh {sambaConfig} to update the config"
    fi
}

sambaSetup