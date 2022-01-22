#!/bin/bash

# Script to install Arch EFI on VirtualBox

loadkeys br-abnt2
pacman -Sy --needed pacman-contrib
curl -LO "https://archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&use_mirror_status=on"
MIRRORLIST="$(ls | grep country)"
sed -i 's/^.\(.*\)/\1/' "$MIRRORLIST"
mv "$MIRRORLIST" /etc/pacman.d/mirrorlist-gen
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bak
rankmirrors -n 5 /etc/pacman.d/mirrorlist-gen > /etc/pacman.d/mirrorlist

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

echo "It's now time to chroot, please execute:
\$> arch-chroot /mnt
and execute base-2.sh"
