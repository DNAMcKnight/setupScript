#!/usr/bin/bash

yayInstall () {
    tput setaf 3;
    which yay > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 3;
    else
        tput setaf 2;
        sudo pacman -Syy
        sudo pacman -S base-devel -y
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        yay -V
        cd ~
        rm -rf yay
    fi
}

yayChecker () {
    which yay > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Yay already installed!"
        tput setaf 3;
    else
        yayInstall
    fi
}

yayCheckerSilent () {
    which yay > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 3;
    else
        yayInstall
    fi
}

fontInstall () {
    yayCheckerSilent
    tput setaf 2; echo "Installing Microsoft fonts..."
    yay -S https://aur.archlinux.org/ttf-ms-win11-auto.git
}

vscodeInstall() {
    tput setaf 3;
    which code > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "VSCode already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S https://aur.archlinux.org/visual-studio-code-bin.git
    fi
}

cloudflareInstall() {
    tput setaf 3;
    which warp-cli > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "cloudflare already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S https://aur.archlinux.org/cloudflare-warp-bin.git
    fi
}

parsecInstall() {
    tput setaf 3;
    which parsecd > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Parsec already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S https://aur.archlinux.org/parsec-bin.git
    fi
}

qbitTorrentInstall() {
    tput setaf 3;
    which qbittorrent > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Qbittorrent already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S qbittorrent 
    fi
}

obsInstall() {
    tput setaf 3;
    which obs > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "OBS already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S obs-studio
    fi
}

discordInstall() {
    tput setaf 3;
    which discord > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Discord already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S discord
    fi
}




discordInstall() {
    tput setaf 3;
    which discord > /dev/null
    if [ $? -eq 0 ]; then
        tput setaf 1; echo "Discord already installed!"
        tput setaf 3;
    else
        yayCheckerSilent
        yay -S discord
    fi
}





case "$1" in
    yay)
        yayChecker
        ;;
    qbittorrent)
        qbitTorrentInstall
        ;;
    obs)
        obsInstall
        ;;
    discord)
        discordInstall
        ;;
    vscode)
        vscodeInstall
        ;;
    parsec)
        parsecInstall
        ;;
    windowsFont)
        fontInstall
        ;;
    all)
        yayChecker
        # fontInstall
        qbitTorrentInstall
        obsInstall
        discordInstall
        vscodeInstall
        parsecInstall
        ;;
    *)
        tput setaf 5; echo "Usage: setup.sh {yay|qbittorrent|obs|discord|vscode|parsec|windowsFont|all}"
        exit 1
        ;;
esac