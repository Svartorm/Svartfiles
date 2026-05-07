# Gaming setup 

Simple gaming setup for simple indy games.

### Hardware
[Thinkpad L390]
CPU: I5-8365U
RAM: 16G
GPU: Intel UHD 620

## Install drivers
Ensure multilib is enable in `pacman.conf`.

```shell
sudo pacman -S mesa vulkan-intel intel-media-driver lib32-vulkan-intel libva-intel-driver vulkan-tools

vulkaninfo --summary
```

## Install Steam
```shell
sudo pacman -S steam wine-staging winetricks lib32-pipewire
```
