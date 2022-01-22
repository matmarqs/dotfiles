#!/bin/bash

# Script to install Arch EFI on VirtualBox

loadkeys br-abnt2
curl -LO "https://archlinux.org/mirrorlist/?country=BR&country=CA&country=DE&country=GB&country=US&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on"
MIRRORLIST="$(ls | grep country)"
sed -i 's/^.\(.*\)/\1/' "$MIRRORLIST"
mv "$MIRRORLIST" /etc/pacman.d/mirrorlist.bak
rankmirrors -n 15 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist

fdisk /dev/sda <<EOF
g
n
1

+512M
t
1
n
2

+6G
t
2
19
n
3


t
3
23
w
EOF

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2

pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
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
127.0.1.1    $hostname.localdomain    $hostname"

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
echo "poweroff"
echo -e "\n"
echo "After that you can disconnect the installation media and reboot the system."
