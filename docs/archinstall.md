# Arch install log

Last install: 5/4/26

This setup assumes you are installing arch from a bootable device (USB).

## Connect to the internet
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

## Partition disk and BTRFS subvolumes
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
```

## Setup the system
```shell
pacstrap /mnt base linux linux-firmware sudo vim

arch-root /mnt
```

Set the time and local of choice :
```shell
timedatectl set-timezone Europe/Paris
hwclock --systohc

vim /etc/locale
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr-latin1" >> /etc/vconsole.conf
echo "SvartPad" >> /etc/hostname 
```

## Setup user :
```shell
passwd
useradd -m svartorm
passwd svartorm
usermod -aG wheel,audio,video,optical,storage,input svartorm
visudo
```

## Enable ZRAM module 
```shell
pacman -S zram-generator
echo -e "[zram0]\nzram-size = ram / 2\ncompression-algorithm = zstd\nswap-priority = 100\n" >> /etc/systemd/zram-generator.conf
```

## Setup GRUB
```shell
pacman -S grub efibootmgr
mkdir -p /boot/efi 
mount /dev/nvme0n1p1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg 
```

## Exit boot key 
```shell
exit
lsblk
umount -l /mnt 
reboot
```
After the restart, start the zram module:
```shell
sudo systemctl start systemd-zram-setup@zram0
zramctl
```

## Wifi setup
```shell
sudo pacman -S networkmanager

sudo systemctl enable --now NetworkManager
```
Now connect to the wifi network:
```shell
nmcli dev wifi list
nmcli dev wifi connect SvartBox --ask
```

## Bluetooth setup
```shell
sudo pacman -S bluez bluez-utils

sudo systemctl enable --now bluetooth
```
Now to connect your devices:
```shell
bluetoothctl
power on
scan on
pair XX:XX:XX:XX:XX:XX # Your device MAC address
```

## Audio setup
```shell
sudo pacman -S pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber

systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

## Firewall setup
```shell
sudo pacman -S ufw

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

## Install AUR helper

```shell
sudo pacman -S base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## Install Snapshots

```shell
sudo pacman -S timeshift grub-btrfs inotify-tools

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl edit --full grub-btrfsd
```
Modify this:
`ExecStart=/usr/bin/grub-btrfsd --syslog /.snapshots`
into this:
`ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto`
```shell
sudo systemctl enable grub-btrfsd
sudo systemctl start grub-btrfsd
```

Autosnaps (create snapshot on system updates):
```shell
paru -S timeshift-autosnaps
```
