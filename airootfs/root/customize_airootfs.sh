#!/usr/bin/env bash
# ==============================================================================
# NexoOS airootfs Customization Script
# Executed by mkarchiso inside chroot during final ISO image assembly
# ==============================================================================

set -euo pipefail

echo "==> [NexoOS] Initializing airootfs environment..."

# 1. Localization & Timezone (Multi-language Support for Calamares)
sed -i 's/^#\([a-z].*UTF-8\)/\1/' /etc/locale.gen || true
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# 2. Set default root and live user
echo "==> [NexoOS] Creating live user 'nexo' with zsh shell..."
useradd -m -g users -G "wheel,audio,video,input,storage,power,network,adm" -s /bin/zsh nexo
passwd -d nexo
passwd -d root

# Sudoers configuration for live user
mkdir -p /etc/sudoers.d
cat << "EOF" > /etc/sudoers.d/10-installer
nexo ALL=(ALL) NOPASSWD: ALL
root ALL=(ALL) NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/10-installer

# 3. Copy skel dotfiles to user home and root
cp -rT /etc/skel /home/nexo
chown -R nexo:users /home/nexo
chmod -R 700 /home/nexo

# 4. Permissions for NexoOS utilities
chmod 755 /usr/bin/nexo-cli || true
chmod 755 /usr/bin/nexo-reset || true
chmod 755 /usr/bin/nexo-wallpaper-daemon || true
chmod 755 /usr/bin/nexo-tweaks || true
chmod 755 /usr/bin/nexo-wine-manager || true
chmod 755 /usr/bin/nexo-killswitch || true
chmod 755 /usr/bin/nexo-lock || true
chmod 755 /usr/bin/nexo-desktop-clock || true
chmod 755 /usr/bin/nexo-clock-settings || true
chmod 755 /usr/bin/nexo-autostart-installer || true
chmod 755 /usr/bin/nexo-dock-position || true
chmod 755 /usr/bin/nexo-nightmode || true
chmod 755 /usr/bin/nexo-doctor || true
chmod 755 /usr/bin/nexo-clipboard-guard || true
chmod 755 /usr/bin/nexo-vault || true
chmod 755 /usr/bin/nexo-antisnoop || true
chmod 755 /usr/bin/nexo-replay || true
chmod 755 /usr/bin/nexo-exe-launcher || true
chmod 755 /usr/bin/nexo-autostart-manager || true
chmod 755 /usr/bin/nexo-mount-windows || true
chmod 755 /usr/bin/nexo-phone-connect || true
chmod 755 /usr/bin/nexo-rgb || true
chmod 755 /usr/bin/nexo-panic || true
chmod 755 /usr/bin/nexo-ocr || true
chmod 755 /usr/bin/nexo-downloader || true
chmod 755 /usr/bin/nexo-sentinel || true
chmod 755 /usr/bin/nexo-sentinel-guard || true
chmod 755 /usr/bin/nexo-usb-guard || true
chmod 755 /etc/calamares/modules/post-install.sh || true

# 5. Enable Systemd Units
echo "==> [NexoOS] Enabling systemd units..."
systemctl enable NetworkManager.service
systemctl enable tor.service
systemctl enable nexo-mac-spoof.service
systemctl enable nexo-clean-memory.service
systemctl enable nexo-wallpaper.service || true

# Enable autologin on tty1 for live media
mkdir -p /etc/systemd/system/getty@tty1.service.d
cat << "EOF" > /etc/systemd/system/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin nexo --noclear %I 38400 linux
EOF

# Setup automatic Hyprland launch from tty1 login on live media
cat << "EOF" >> /home/nexo/.zprofile
if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" && "$(tty)" == "/dev/tty1" ]]; then
    exec Hyprland
fi
EOF
chown nexo:users /home/nexo/.zprofile

# Autostart Calamares installer on live desktop boot
mkdir -p /home/nexo/.config/autostart
cat << "EOF" > /home/nexo/.config/autostart/calamares.desktop
[Desktop Entry]
Type=Application
Version=1.0
Name=Install NexoOS
Comment=Install the operating system to disk
Exec=sudo calamares
Icon=calamares
Terminal=false
StartupNotify=true
Categories=Qt;System;
EOF
chown -R nexo:users /home/nexo/.config/autostart

# 6. Set Plymouth Default Theme
if command -v plymouth-set-default-theme >/dev/null 2>&1; then
    plymouth-set-default-theme -R nexoos || true
fi

echo "==> [NexoOS] airootfs customization finalized."
