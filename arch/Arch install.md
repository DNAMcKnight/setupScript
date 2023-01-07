# Arch Install Guide
### This guide will help you reinstall arch with a seperate EFI partition so you can dual boot Arch and Windows using grub.

---

## Keyboard
### If you don't have a US keyboard, you need to select your keymap.

To find available keymaps `locatectl list-keymap`

To filter results `locatectl list-keymap | grep <keyboard layout>`

To set a keymap `loadkeys <keyboard layout>`

---

## Ethernet
Ethernet should work automatically, use `ip a` to get your current ip or for wifi use command `iwctl`

`timedatectl set-ntp true` this will sync network time protocol.

---

## Mirrors

Run the following commands

```sh
pacman -Syyy
pacman -S reflector
reflector -C <country> -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
```
If for some reason reflector can't find the country you can always add a manual entry like `Server = http://mirror.xeonbd.com/archlinux/$repo/os/$arch` to  `etc/pacman.d/mirrorlist`

## Partitioning Using Windows EFI
1. use `lsblk` to see the drives
2. use `cfdisk <drive path ex /dev/sda>` to select your boot drive
3. Go down to Free space or delete the partitions from the previous installation and select new then select write and confirm by typing "yes" and quit the program
4. `lsblk` again to see our newly created partition, take note of the drive name, this will be where we want to install Arch linux aka the `/mnt` location.

### Formatting
To format the drive to ext4 use this command `mkfs.ext4 <drive path ex /dev/sda5>` 

---

## Mounting
The first thing to mount has to be the drive we'll be using for Arch Linux.

`mount <drive path ex /dev/sda5> /mnt` This command will mount the **path you choose** to **/mnt**

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

`mount <drive path to EFI partition ex /dev/sda4> /mnt/boot` This will mount the **choosen EFI partition** to  **/mnt/boot**
`mount <drive path to win10> /mnt/win10` This will mount the **choosen drive** to **/mnt/win10** 

My current mounts looks like this

### Boot drive

`mount /dev/sdc6 /mnt` root

`mount /dev/sdc5 /mnt/boot` boot

`mount /dev/sdc3 /mnt/win10` win10

### 1TB drive

`mount /dev/sdb2 /mnt/Audio-Video` Audio&Video

`mount /dev/sdb3 /mnt/Downloads-Games` Downloads and Games

### 2TB Drive

`mount /dev/sda2 /mnt/Games` Games

`mount /dev/sda1 /mnt/Downloads` Downloads

# Base
Now we will install the base for linux using this command


### For intel
```bash
pacstrap /mnt base linux linux-firmware nano git intel-ucode
```

### For AMD
```sh
pacstrap /mnt base linux linux-firmware nano git amd-ucode
```

# FSTAB
`genfstab -U /mnt >> /mnt/etc/fstab`

This will create a fstab based on the UUID of the partitions.

`cat /mnt/etc/fstab`

To check the fstab file

# Chroot
Now we can enter the installation and leave the ISO installer using the command `arch-chroot /mnt`

# Swapfile
### Creating a swapfile using these commands
```sh
fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkmswap /swapfile
swapon /swapfile
```
Next we must add swapfile to fstab, add the following line at the end of `/etc/fstab`

```
/swapfile none swap defaults 0 0
```

# Locate
`timedatectl list-timezones | grep <country>` This command should filter the country results

Incase it doesn't work `ls /usr/share/zoneinfo` should show you the list of results

`ln -sf /usr/share/zoneinfo/<country or whatever> /etc/localtime` replace the country or whatever with your timezone.

Example 

```sh
ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
```

`nano /etc/locale.gen` Edit this file and uncomment **en_US.UTF-8**

```sh
locale-gen
echo "LANG=en_us.UTF-8" >> /etc/locale.conf
```
If you have changed your keyboard layout you will need to do one more step `echo "KEYMAP="<whatever keymap you choose>" >> /etc/vconsole.conf`

# Hostname
open hostname and add a hostname `/etc/hostname` in this file

now open `/etc/hosts` and add the following end of the file
```
1270.0.1    localhost
::1         localhost
127.0.0.1   arch.localdomain    arch
```
`arch` being the hostname

Now set a root password using `passwd`.
# Grub
We need to install the following packages there are 29 of them
```sh
pacman -S grub efibootmgr os-prober ntfs-3g networkmanager network-manager-applet wireless_tools wpa_supplicant dialog mtools base-devel linux-headers git bluez bluez-utils pulseaudio-bluetooth cups openssh
```
This is for a 64 bit machine

```sh
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

```
### Note: If you don't see windows bootloader, make sure secure boot in bios and fast startup in windows is turned off! 
### By default `os-prober` is turnned off make sure to turn it on in order to detect windows bootloader.


# Services
### The following services need to be enabled

```sh
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable org.cups.cupsd
systemctl enable sshd
```
# New User
Replace `<username>` with the username of your own choice.
```sh
useradd -mG wheel <username>
```
Then set a password for it with this command
```sh
passwd <username>
```
Now use the command `EDITOR=nano visudo` and uncomment the line
```sh
%wheel ALL=(ALL) ALL
```
Save that and exit

# Reboot
Congratulations we're half way done! now before we reboot we should unmount all our drives with this command
```sh
unmount -a
sudo reboot
```
Proceed with the reboot.

## Login using the newly created user. 

# Internet 
If you're using ethernet things should work out of the box however to setup wifi use `nmtui`

# Graphics Drivers
These drives are for x86 aka 64 bit systems only.
For virtual machines use this command
```sh
sudo pacman -S xf86-video-qxl
```
For Intel HD Graphics
```sh
sudo pacman -S xf86-video-intel
```
For AMD Graphics cards
```sh
sudo pacman -S xf86-video-amdgpu
```
For Nvidia Graphics cards
```sh
sudo pacman -S nvidia nvidia-utils
```

# Display server
Here's how I have mine setup

```sh
sudo pacman -S xorg
```
For kde we will use SDDM as the display manager
```sh
sudo pacman -S sddm
sudo systemctl enable sddm
```
first to download sddm and second to enable at startup

# Desktop
I'm going to use plasma
```sh
sudo pacman -S plasma kde-applications packagekit-qts
```
# Fonts using yay
Before we install fonts we need to get yay first.
```sh
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
yay -S ttf-ms-win11-auto
```
That should install yay and the fonts, if the fonts fail to install don't worry just run it all again.
Restart into desktop to finish it off

## Conngratulations you've successfully installed Arch linux, if you've had trouble with anything here please refer back to the video I used to install everything on my machine, this was just a guide for future me and anyone who has been looking for a step by step written guide.
https://www.youtube.com/watch?v=L1B1O0R1IHA