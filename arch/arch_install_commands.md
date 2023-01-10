# Arch Installation Commands only

### This guide is for commands only, to document every command input in chronological order for the ease of installation.

## Keyboard

### Applicable only if you don't have US keyboard
```sh
loadkeys <keyboard layout>
```

## Ethernet
### Aapplicable only if you're using WiFi

```sh
ip a
iwctl
```
afterwords sync network time protocol
```sh
timedatectl set-mtp true
```

## Mirrors
### This is for my case since I have to manually add mine anways

add a manual entry like this to `etc/pacman.d/mirrorlist`
```sh
Server = http://mirror.xeonbd.com/archlinux/$repo/os/$arch
```