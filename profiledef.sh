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
    'bios.syslinux.mbr'
    'bios.syslinux.eltorito'
    'uefi-ia32.systemd-boot.esp'
    'uefi-x86_64.systemd-boot.esp'
    'uefi-ia32.systemd-boot.eltorito'
    'uefi-x86_64.systemd-boot.eltorito'
)

# Compression parameters for maximum squashfs performance and space efficiency
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19' '-b' '1M')

# File permissions specification for airootfs overlay
file_permissions=(
    ["/etc/shadow"]="0:0:0400"
    ["/etc/gshadow"]="0:0:0400"
    ["/etc/sudoers.d"]="0:0:0750"
    ["/etc/sudoers.d/10-installer"]="0:0:0440"
    ["/root"]="0:0:0700"
    ["/root/.automated_script.sh"]="0:0:0755"
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
    ["/etc/calamares/modules/post-install.sh"]="0:0:0755"
)
