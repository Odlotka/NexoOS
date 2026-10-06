#!/usr/bin/env bash
# NexoOS archiso profile definition
# Defines build metadata, filesystem types, boot labels, and permissions

iso_name="NexoOS"
iso_label="NEXOOS_$(date +%Y%m)"
iso_publisher="NexoOS Cyber Operations & System Architecture Group <https://nexoos.org>"
iso_application="NexoOS Live/Rescue/Installation Media (x86_64)"
iso_version="$(date +%Y.%m.%d)"
install_dir="nexoos"
buildmodes=('iso')
bootmodes=(
    'bios.syslinux'
    'uefi.grub'
)
pacman_conf="pacman.conf"

# Compression parameters for maximum squashfs performance and space efficiency
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19' '-b' '1M')

# File permissions specification for airootfs overlay
file_permissions=(
    ["/root"]="0:0:0700"
    ["/root/customize_airootfs.sh"]="0:0:0755"
    ["/usr/bin/nexo-cli"]="0:0:0755"
    ["/usr/bin/nexo-reset"]="0:0:0755"
    ["/usr/bin/nexo-wallpaper-daemon"]="0:0:0755"
    ["/usr/bin/nexo-tweaks"]="0:0:0755"
    ["/usr/bin/nexo-wine-manager"]="0:0:0755"
    ["/usr/bin/nexo-killswitch"]="0:0:0755"
    ["/usr/bin/nexo-lock"]="0:0:0755"
    ["/usr/bin/nexo-desktop-clock"]="0:0:0755"
    ["/usr/bin/nexo-clock-settings"]="0:0:0755"
    ["/usr/bin/nexo-autostart-installer"]="0:0:0755"
    ["/usr/bin/nexo-dock-position"]="0:0:0755"
    ["/usr/bin/nexo-nightmode"]="0:0:0755"
    ["/usr/bin/nexo-doctor"]="0:0:0755"
    ["/usr/bin/nexo-clipboard-guard"]="0:0:0755"
    ["/usr/bin/nexo-vault"]="0:0:0755"
    ["/usr/bin/nexo-antisnoop"]="0:0:0755"
    ["/usr/bin/nexo-replay"]="0:0:0755"
    ["/usr/bin/nexo-exe-launcher"]="0:0:0755"
    ["/usr/bin/nexo-autostart-manager"]="0:0:0755"
    ["/usr/bin/nexo-mount-windows"]="0:0:0755"
    ["/usr/bin/nexo-phone-connect"]="0:0:0755"
    ["/usr/bin/nexo-rgb"]="0:0:0755"
    ["/usr/bin/nexo-panic"]="0:0:0755"
    ["/usr/bin/nexo-ocr"]="0:0:0755"
    ["/usr/bin/nexo-downloader"]="0:0:0755"
    ["/usr/bin/nexo-sentinel"]="0:0:0755"
    ["/usr/bin/nexo-sentinel-guard"]="0:0:0755"
    ["/usr/bin/nexo-usb-guard"]="0:0:0755"
    ["/etc/calamares/modules/post-install.sh"]="0:0:0755"
)
