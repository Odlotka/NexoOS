#!/usr/bin/env bash
# ==============================================================================
# NexoOS ISO Compiler Script (mkarchiso wrapper)
# Builds NexoOS-x86_64.iso with multi-kernel tiering and unified assets
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${SCRIPT_DIR}/work"
OUT_DIR="${SCRIPT_DIR}/out"

echo -e "\033[1;36m"
cat << "EOF"
  _   _                 ___  ____  
 | \ | | _____  _____  / _ \/ ___| 
 |  \| |/ _ \ \/ / _ \| | | \___ \ 
 | |\  |  __/>  < (_) | |_| |___) |
 |_| \_|\___/_/\_\\___/ \___/|____/ 
  Advanced Cyber & Gaming Distribution
EOF
echo -e "\033[0m"

# Verification: Root privileges required by mkarchiso
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m[ERROR] This build script must be run as root (or via sudo).\033[0m" 
   exit 1
fi

# Verification: Required packages installed on build host
command -v mkarchiso >/dev/null 2>&1 || {
    echo -e "\033[1;33m[!] 'archiso' package is missing. Installing...\033[0m"
    pacman -Sy --noconfirm archiso
}

# Clean previous working directories if requested
if [[ "${1:-}" == "--clean" ]]; then
    echo -e "\033[1;33m[*] Cleaning previous work and out directories...\033[0m"
    rm -rf "${WORK_DIR}" "${OUT_DIR}"
fi

mkdir -p "${WORK_DIR}" "${OUT_DIR}"

echo -e "\033[1;32m[*] Commencing NexoOS ISO compilation via mkarchiso...\033[0m"
echo -e "\033[1;34m[*] Work Directory: ${WORK_DIR}\033[0m"
echo -e "\033[1;34m[*] Output Directory: ${OUT_DIR}\033[0m"

mkarchiso -v -w "${WORK_DIR}" -o "${OUT_DIR}" "${SCRIPT_DIR}"

echo -e "\033[1;32m[✓] Build completed successfully!\033[0m"
echo -e "\033[1;32m[✓] Generated ISO image:\033[0m"
ls -lh "${OUT_DIR}"/*.iso
