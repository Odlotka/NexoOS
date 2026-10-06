#!/usr/bin/env bash
# ==============================================================================
# NexoOS Post-Installation Shell Hook
# Generates immutable @factory-base snapshot and configures Btrfs rollback engine
# ==============================================================================

set -euo pipefail

echo "[*] Initializing NexoOS post-installation hooks..."

# Check if target root is Btrfs
ROOT_FSTYPE="$(findmnt -n -o FSTYPE / || true)"

if [[ "${ROOT_FSTYPE}" == "btrfs" ]]; then
    echo "[*] Btrfs filesystem detected. Creating @factory-base snapshot..."
    
    # Mount top-level Btrfs volume to temporary directory
    ROOT_DEV="$(findmnt -n -o SOURCE / | sed 's/\[.*\]//')"
    TMP_MNT="/tmp/btrfs-top"
    mkdir -p "${TMP_MNT}"
    mount -o subvolid=5 "${ROOT_DEV}" "${TMP_MNT}"

    # Verify and create read-only snapshot
    if [[ -d "${TMP_MNT}/@" ]]; then
        if [[ ! -d "${TMP_MNT}/@factory-base" ]]; then
            btrfs subvolume snapshot -r "${TMP_MNT}/@" "${TMP_MNT}/@factory-base"
            echo "[✓] Read-only immutable @factory-base snapshot created successfully!"
        fi
    fi
    umount "${TMP_MNT}"
    rmdir "${TMP_MNT}"
fi

# Enable necessary systemd services
systemctl enable NetworkManager.service || true
systemctl enable tor.service || true
systemctl enable usbguard.service || true
systemctl enable nexo-mac-spoof.service || true
systemctl enable nexo-clean-memory.service || true

# Rebuild initramfs with Plymouth
mkinitcpio -P || true

# Update GRUB configuration
if command -v update-grub >/dev/null 2>&1; then
    update-grub || true
elif command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o /boot/grub/grub.cfg || true
fi

echo "[✓] NexoOS installation finalized."
