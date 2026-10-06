#!/usr/bin/env bash
# ==============================================================================
# NexoOS QEMU Verification & Test Harness
# Launches the built ISO in QEMU with UEFI (OVMF) or BIOS modes
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/out"
ISO_IMAGE="$(ls -t "${OUT_DIR}"/*.iso 2>/dev/null | head -n1 || true)"

if [[ -z "${ISO_IMAGE}" || ! -f "${ISO_IMAGE}" ]]; then
    echo -e "\033[1;31m[ERROR] No ISO image found in ${OUT_DIR}. Run ./build.sh first.\033[0m"
    exit 1
fi

echo -e "\033[1;36m[*] Found NexoOS image: ${ISO_IMAGE}\033[0m"

BOOT_MODE="${1:-uefi}" # 'uefi' or 'bios'
MEMORY="${MEMORY:-4096M}"
SMP="${SMP:-4}"

QEMU_ARGS=(
    -m "${MEMORY}"
    -smp "${SMP}"
    -cdrom "${ISO_IMAGE}"
    -boot d
    -vga virtio
    -display gtk,gl=on
    -audiodev pa,id=snd0
    -device intel-hda
    -device hda-duplex,audiodev=snd0
    -net nic,model=virtio
    -net user
)

# Enable KVM if available
if [[ -e /dev/kvm && -r /dev/kvm && -w /dev/kvm ]]; then
    QEMU_ARGS+=(-enable-kvm -cpu host)
else
    echo -e "\033[1;33m[!] KVM not accessible. Emulation will be slower.\033[0m"
    QEMU_ARGS+=(-cpu max)
fi

if [[ "${BOOT_MODE}" == "uefi" ]]; then
    echo -e "\033[1;32m[*] Booting in Modern UEFI mode (OVMF)...\033[0m"
    OVMF_CODE="/usr/share/edk2-ovmf/x64/OVMF_CODE.fd"
    if [[ ! -f "${OVMF_CODE}" ]]; then
        OVMF_CODE="/usr/share/OVMF/OVMF_CODE.fd"
    fi
    if [[ -f "${OVMF_CODE}" ]]; then
        QEMU_ARGS+=(-drive if=pflash,format=raw,readonly=on,file="${OVMF_CODE}")
    else
        echo -e "\033[1;33m[!] OVMF firmware file not found at standard paths. Booting default...\033[0m"
    fi
else
    echo -e "\033[1;32m[*] Booting in Legacy BIOS mode...\033[0m"
fi

qemu-system-x86_64 "${QEMU_ARGS[@]}"
