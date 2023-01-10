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
afterwords sync network time protocol even if you're using Ethernet
```sh
timedatectl set-mtp true
```

## Mirrors
### This is for my case since I have to manually add mine anways

add a manual entry like this to `etc/pacman.d/mirrorlist`
```sh
Server = http://mirror.xeonbd.com/archlinux/$repo/os/$arch
```

## Partitioning Using Windows EFI
1. use `lsblk` to see the drives
2. use `cfdisk <drive path ex /dev/sda>` to select your boot drive
3. Go down to Free space or delete the partitions from the previous installation and select new then select write and confirm by typing "yes" and quit the program
4. `lsblk` again to see our newly created partition, take note of the drive name, this will be where we want to install Arch linux aka the `/mnt` location.

### Formatting
To format the drive to ext4 use this command `mkfs.ext4 <drive path ex /dev/sda5>` 


## Mounting
The first thing to mount has to be the drive we'll be using for Arch Linux.

```sh
mount <drive path ex /dev/sda5> /mnt
```

After mounting the **root** partition aka `/mnt` we can now create folders for the other drives we want to mount such as boot, windwos and any other hard drives partitions.

```sh
mkdir /mnt/boot
mkdir /mnt/win10
mkdir /mnt/Audio-Video
mkdir /mnt/Downloads
mkdir /mnt/Downloads-Games
mkdir /mnt/Games
```
Now we have all the folders you need for all the partitions you want to mount, mount each one as shown below

My current mounts looks like this
```sh
# Boot drive

`mount /dev/sdc6 /mnt` #root

`mount /dev/sdc5 /mnt/boot` #boot

`mount /dev/sdc3 /mnt/win10` #win10

#1TB drive

`mount /dev/sdb2 /mnt/Audio-Video` #Audio&Video

`mount /dev/sdb3 /mnt/Downloads-Games` #Downloads and Games

# 2TB Drive

`mount /dev/sda2 /mnt/Games` #Games

`mount /dev/sda1 /mnt/Downloads` #Downloads 
```

# Base

```sh
pacstrap /mnt base linux linux-firmware nano git amd-ucode
```

# FSTAB
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

This will create a fstab based on the UUID of the partitions.

```sh
cat /mnt/etc/fstab
```

To check the fstab file

# Chroot
Now we can enter the installation and leave the ISO installer using the command 
```sh
arch-chroot /mnt
```

# Swapfile
### Creating a swapfile using these commands
```sh
fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkmswap /swapfile
swapon /swapfile
```
Add the following line at the end of `/etc/fstab`

```sh
/swapfile none swap defaults 0 0
```