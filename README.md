# NexoOS (x86_64) - Low-Latency Cyber Operations & Gaming OS

**NexoOS** is an advanced, production-grade Linux distribution engineered for ultra-low latency desktop scheduling, hardware-accelerated animated environments, and defensive/offensive security workflows.

Packaged as a bootable, hybrid `.iso` (`NexoOS-x86_64.iso`) via the `archiso` framework, compatible with both **Modern UEFI (GPT)** and **Legacy BIOS (MBR)**.

---

## Architecture & Subsystems Overview

### 1. Multi-Kernel Tiering Architecture
- **`linux-zen` (Default Boot Profile)**: Tuned for ultra-low latency desktop scheduling, EEVDF process balancing, and high-framerate gaming responsiveness.
- **`linux-hardened` (High Security Profile)**: Fortified against heap spraying, restricted usercopy, BPF mitigations, and page poisoning (`init_on_alloc=1 init_on_free=1`).
- **`linux-lts` (Recovery & Stability Fallback)**: Long-term support kernel ensuring seamless fallback during major GPU/DKMS driver transitions.

### 2. Windows-Style Two-Stage Lockscreen
- **Stage 1 (Glance Screen)**: High-resolution lockscreen wallpaper (`/usr/share/nexoos/branding/lockscreen.png`), large digital clock, date, status indicators, and prompt (*"Naciśnij spację lub kliknij, aby się zalogować"*).
- **Stage 2 (Transition)**: Pressing the `Spacebar` (or mouse swipe) triggers an upward slide physics-based easing transition.
- **Stage 3 (Authentication & Desktop Handover)**: Circular user avatar, password entry field, and smooth cross-fade handover into the active Hyprland compositor session without screen flickering.

### 3. Live & Animated Wallpaper Engine
- **Hardware Acceleration**: Integrated `mpvpaper` with VA-API/NVDEC/VDPAU hardware decoding for looping `.mp4`/`.webm`/`.mkv` videos at near 0% CPU consumption.
- **Steam Wallpaper Engine**: Built-in compatibility layer with automatic discovery of Steam Workshop assets in `~/.local/share/Steam/steamapps/workshop/content/431960/`.
- **Intelligent Gaming Performance Daemon (`nexo-wallpaper-daemon`)**:
  - Automatically listens to active window states and `gamemode` status.
  - Sends `SIGSTOP` to wallpaper rendering processes when a game or fullscreen application is running, releasing 100% of GPU compute and VRAM.
  - Issues `SIGCONT` seamlessly when returning to the desktop.

### 4. Storage & Factory Reset Engine (`nexo-reset`)
- **Btrfs Layout**:
  - `@` (Root system image)
  - `@home` (User profiles and personal documents)
  - `@var_log` (System logging)
  - `@snapshots` (Snapper rollback hierarchy)
  - `@factory-base` (Read-only immutable snapshot created at installation)
- **3-Mode Reset Wizard**:
  - **Mode 1: Complete Factory Wipe**: Rolls back `@` to `@factory-base`, wipes and re-creates clean `@home` from `/etc/skel/`.
  - **Mode 2: Keep Personal Documents**: Rolls back `@`, preserves user documents/downloads/media, and resets configs and dotfiles to default.
  - **Mode 3: Quick Privacy & Traces Purge**: Cleans journalctl logs, shell histories, caches, and temporary Wine prefixes.

### 5. Windows (.exe) Binary Automation & Gaming Stack
- **Direct Double-Click Execution**: Registered `binfmt_misc` kernel handlers (`/etc/binfmt.d/wine.conf`) allow launching `.exe` and `.msi` files directly without terminal intervention.
- **Bubblewrap Security Sandbox**: Right-click context menu "Run in Isolated Sandbox" running Windows binaries inside an unprivileged sandbox blocking access to `~/.ssh`, `~/.gnupg`, and system devices.
- **`nexo-wine-manager`**: Graphical & CLI utility to terminate frozen Windows processes (`wineserver -k`), purge DXVK shader caches, and manage custom prefixes.

### 6. Strict Anonymity & Defensive Security
- **Tor Infrastructure**: System-wide transparent proxying, Snowflake and obfs4 pluggable transports.
- **MAC Address Spoofing**: Automatic MAC address cycling across all network interfaces on scan and connection via NetworkManager.
- **Stateful Killswitch (`nexo-killswitch`)**: Stateful `nftables` policy dropping all egress packets not routed through Tor or an active VPN tunnel.
- **Anti-Forensics**: Ephemeral hostname generation, dynamic machine-id rotation, USBGuard BadUSB protection, and RAM zeroing on shutdown.

---

## Build Instructions (Arch Linux Build Host)

### Prerequisites
Ensure `archiso` and `git` are installed on the host:
```bash
sudo pacman -Syu --noconfirm archiso
```

### Compiling the ISO
Execute the build wrapper script:
```bash
sudo ./build.sh
```
This generates `out/NexoOS-x86_64.iso` utilizing zstd level 19 compression.

### Testing under QEMU
To verify UEFI booting:
```bash
./run-qemu.sh uefi
```
To verify Legacy BIOS booting:
```bash
./run-qemu.sh bios
```

---

## Master Command-Line Interface (`nexo-cli`)

| Command | Action |
| :--- | :--- |
| `nexo-cli update` | Synchronizes Arch, BlackArch, and Flatpak repositories |
| `nexo-cli stealth on` | Engages Tor transparent proxy, nftables killswitch, and MAC cycling |
| `nexo-cli stealth off` | Disengages killswitch and restores standard networking |
| `nexo-cli clean` | Flushes package cache, orphan packages, and temporary prefixes |
| `nexo-cli backup` | Creates an immediate timestamped Btrfs system snapshot |
| `nexo-cli doctor` | Audits GPU acceleration, IP/DNS leak status, and firewall chains |
