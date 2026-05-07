# SvartOS

SvartOS is a collection of utils and apps to use effectively your computer.

Apps:
sddm ok
hyprland ok 
quickshell
tofi ok 
hyprpaper
hyprlock
hypridle

kitty ok
nautilus (lxappearance for gtk theme) ok

wifi (nmcli) ok
bluetooth (bluez)
usb daemon
screenshot
power mode
btop


sddm:
```shell
sudo pacman -S sddm
sudo systemctl enable sddm
```

Hyprland:
```shell
sudo pacman -S hyprland
```

HyprEcosystem
```shell
sudo pacman -S hyprlock hypridle hyprpaper
```

Quickshell:
```shell
sudo pacman -S quickshell ttf-hack-nerd brightnessctl libnotify
```


Power profile:
```shell
sudo pacman -S power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon

powerprofilesctl get
powerprofilesctl set <profile>
```

Screenshot:
```shell
sudo pacman -S grim slurp swappy viu
```
