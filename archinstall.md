# Arch install log

Last install: 5/4/26

## Commands

```shell
localectl list-keymaps

loadkeys fr-latin1

ip link 

iwctl

>> device list 
>> station wlan0 scan
>> station wlan0 get-networks
>> station wlan0 connect FrangWifiBox

ping google.com 

```

Partition disk
```shell
fdisk -l 

cfdisk /dev/nvme0n1
```
 - remove windows Partition
 - create 512M EFI system
 - create XXG Linux Filesystem (then write)

```shell
lsblk

mkfs.fat -F32 /dev/nvme0n1p1
mkfs.btrfs -L ArchRoot /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt 

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log

umount /mnt 
mount -o noatime,compress=zstd,subvol=@ /dev/nvme0n1p2 /mnt 
mkdir -p /mnt/{boot,home,.snapshots,var/log}
ls -a /mnt 
mount -o noatime,compress=zstd,subvol=@home /dev/nvme0n1p2 /mnt/home 
mount -o noatime,compress=zstd,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots 
mount -o noatime,compress=zstd,subvol=@var_log /dev/nvme0n1p2 /mnt/var/log
mount /dev/nvme0n1p1 /mnt/boot
lsblk -f 

mkdir -p /mnt/etc
genfstab -U /mnt >> /mnt/etc/fstab

pacstrap /mnt base linux linux-firmware sudo vim

arch-root /mnt 

timedatectl set-timezone Europe/Paris
hwclock --systohc

vim /etc/locale
locale-gen
echo "LANG=fr_FR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr-latin1" >> /etc/vconsole.conf
echo "SvartPad" >> /etc/hostname 

passwd
useradd -m svartorm
passwd svartorm
usermod -aG wheel,audio,video,optical,storage,input svartorm
visudo


pacman -S zram-generator
echo -e "[zram0]\nzram-size = ram / 2\ncompression-algorithm = zstd\nswap-priority = 100\nmount-point = /dev/zram0" >> /etc/systemd/zram-generator.conf

pacman -S grub efibootmgr
mkdir -p /boot/efi 
mount /dev/nvme0n1p1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg 

pacman -S base-devel git networkmanager sddm hyprland kitty

exit
lsblk
umount -l /mnt 
reboot

sudo systemctl start /dev/zram0
sudo systemctl enable --now NetworkManager 
sudo systemctl enable sddm

reboot
```
