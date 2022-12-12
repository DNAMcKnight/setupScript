#!/usr/bin/bash


screenSetup () {
    which screen > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Screen already installed!"
        tput setaf 3;
    else
        echo "Installing screen..."
        sudo apt-get install screen
        tput setaf 2; echo "Screen installation complete!"
    fi
}


microSetup () {
    tput setaf 3;
    which micro > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "micro already installed!"
        tput setaf 3;
    else
        echo "Downloading micro..."
        curl https://getmic.ro | bash
        tput setaf 3; echo "Changing permissions for micro"
        sudo chown root:root micro
        tput setaf 2; echo "Micro installation complete!"
        sudo mv micro /usr/local/bin
        tput setaf 3; echo "Moving micro to /usr/local/bin"
        which micro
    fi
}

case "$1" in
    screen)
        screenSetup
        ;;
    micro)
        microSetup
        ;;
    samba)
        /usr/bin/bash smb.sh
        ;;
    all)
        screenSetup
        microSetup
        /usr/bin/bash smb.sh
        ;;
    *)
        tput setaf 5; echo "Usage: setup.sh {screen|micro|samba|all}"
        exit 1
        ;;
esac

exit 0