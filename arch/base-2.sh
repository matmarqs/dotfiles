#!/bin/bash

# Part 2 of Arch Installation. This part is after arch-chroot.

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=br-abnt2 > /etc/vconsole.conf

echo -e "Please, choose your hostname: "
read hostname
echo "$hostname" > /etc/hostname
echo "127.0.0.1    localhost
::1          localhost
127.0.1.1    $hostname.localdomain    $hostname" >> /etc/hosts

echo "Please, create a password for root."
passwd

echo "Please, create a name for your user."
read username
useradd -m -g users -G wheel $username
echo "Now, create a password for your user."
passwd $username

echo "Installing sudo."
pacman -S sudo
echo -e "\n$username ALL=(ALL) ALL" | EDITOR='tee -a' visudo

echo "Installing and configuring grub."
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\n\n"
echo "Installation complete. Now, type the following commands:"
echo -e "\n"
echo "\$> exit"
echo "\$> umount -R /mnt"
echo "\$> poweroff"
echo -e "\n"
echo "After that you can disconnect the installation media and reboot the system."
