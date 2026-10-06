# NexoOS (x86_64) 🌌
### The Ultimate Low-Latency Gaming, Cyber-Operations & Self-Healing Linux OS

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-x86__64-00F0FF?style=for-the-badge&logo=arch-linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Compositor-Hyprland%20Wayland-9D00FF?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Antivirus-Nexo%20Sentinel%20AI-10B981?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Display-Ultra%20High--Hz%20(144--500Hz+)-F43F5E?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-GPLv3-yellow?style=for-the-badge" />
</p>

---

**NexoOS** to dystrybucja Linuksa oparta na Arch Linux, zaprojektowana od podstaw jako bezkompromisowa alternatywa dla Windowsa – łącząca **maksymalną płynność i odświeżanie ekranu (144Hz, 240Hz, 360Hz, 500Hz+)**, **zerowy input lag w grach e-sportowych (Direct Scanout, Tearing)**, **ekstremalną prywatność z wbudowanym antywirusem (Nexo Sentinel AI)** oraz **luksusowy interfejs Hyprland z dolnym dokiem w stylu frosted-glass**.

Dostarczana jako hybrydowy obraz ISO (`NexoOS-x86_64.iso`), w pełni kompatybilny z nowoczesnym **UEFI** oraz klasycznym **BIOS**.

---

## ⚡ Kluczowe Wyróżniki NexoOS

### 🎮 1. Gaming & E-Sport (Dlaczego gracze wybierają NexoOS)
* **Automatyczne Maksymalne Odświeżanie Monitora (`highrr` 144Hz – 500Hz+):** NexoOS automatycznie wykrywa i ustawia najwyższą dostępną częstotliwość odświeżania dla każdego monitora. Pełne wsparcie dla **Adaptive Sync / VRR (G-Sync & FreeSync)**, nielimitowanych FPS i płynności animacji.
* **GPU Instant Replay (ShadowPlay Ultra-FPS):** Wbudowany bufor powtórek w pamięci VRAM/RAM ze sprzętową akceleracją NVENC / VAAPI. Zapisuje powtórki w natywnym klatkażu Twojego monitora (120, 144, 240, 360 FPS) w jakości 1080p/4K bez spadku płynności rozgrywki! Skrót <kbd>Win</kbd> + <kbd>Alt</kbd> + <kbd>R</kbd>.
* **Ultra Gaming Boost & Tearing:** Sprzętowy bypass Direct Scanout, planista jądra `linux-zen` z algorytmem EEVDF oraz odblokowany natychmiastowy tearing dla zerowych opóźnień myszy w CS2, Apex, Fortnite.
* **OpenRGB Control Center:** Sterowanie podświetleniem komputera i podzespołów (GPU, RAM, wentylatory) bez instalowania ciężkich aplikacji producentów. Wbudowany **Tryb Stealth** wyłącza całe RGB jednym kliknięciem.
* **Pre-kompilacja Shaderów:** Eliminacja przycięć w grach (stutteringu) dzięki buforowaniu shaderów DXVK/VKD3D.

### 🛡️ 2. Nexo Sentinel AI & Cyberbezpieczeństwo
* **Autonomiczny Antywirus Nexo Sentinel:**
  * **Skanowanie w locie (In-Flight):** Globalny demon `inotifywait` bada każdy nowo zapisany plik w ułamku sekundy, niezależnie od folderu docelowego.
  * **Wskaźnik Zagrożenia (Threat Score 0–100%):** Heurystyczna ocena ryzyka i klasyfikacja wektorów ataku (Ransomware, Stealer haseł/portfeli, Dropper, Keylogger, CryptoMiner).
  * **Przycisk „Podejrzyj co wskazuje na wirusa”:** Szczegółowy podgląd podejrzanych funkcji, odwołań sieciowych i sygnatur.
  * **Jednorazowa Piaskownica Bubblewrap:** Bezpieczne uruchamianie podejrzanych plików w odizolowanym kontenerze bez dostępu do Twoich prawdziwych danych.
* **Nexo USB Guard (BadUSB & Pendrive Shield):**
  * Blokuje urządzenia podszywające się pod klawiatury (Rubber Ducky).
  * Błyskawicznie analizuje podłączony pendrive (wykrywa ukryte skrypty `.bat`, `.sh`, `.ps1`, `.exe`, makra i `autorun.inf`).
  * Wybór uprawnień: **Tylko do odczytu**, **Blokada skryptów (`noexec`)**, **Pełny dostęp** lub **Pełny skan antywirusowy**.
* **Przycisk Paniki (Panic Protocol):** Skrót <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> natychmiast zamyka przeglądarki, czyści schowek, odcina Wi-Fi/LAN, rygluje szyfrowany sejf i blokuje ekran.
* **Pancerny Sejf Plików (AES-256-GCM):** Skrót <kbd>Win</kbd> + <kbd>V</kbd> montuje zaszyfrowany sejf `~/Sejf` za pomocą `gocryptfs`.
* **Hardware Anti-Snoop:** Sprzętowy wskaźnik i wyłącznik mikrofonu oraz kamery internetowej na poziomie jądra.

### 🪟 3. Doświadczenie Windowsa bez Frustracji (Zero-Friction UX)
* **Klawisz Windows otwiera Menu Start:** Naciśnięcie samego klawisza <kbd>Super</kbd> otwiera wyszukiwarkę aplikacji i gier.
* **Smart Wine Launcher:** Dwuklik na pobranym pliku `.exe` lub `.msi` otwiera okno wyboru: *Uruchom przez Proton/Wine*, *Uruchom w piaskownicy*, lub *Zainstaluj ze skrótem w Menu Start*.
* **QuickLook (Spacja = Podgląd):** Naciśnięcie <kbd>Spacji</kbd> w Nautilusie otwiera natychmiastowy pływający podgląd zdjęć, wideo, plików muzycznych, PDF i tekstu.
* **Menedżer Autostartu:** Graficzna lista z przełącznikami ON/OFF aplikacji uruchamianych ze startem systemu.
* **Automatyczne Montowanie Dysków Windows:** Wykrywanie i montowanie partycji NTFS oraz obsługa zaszyfrowanych dysków BitLocker z prawami zapisu.
* **Połączenie ze Smartfonem (KDE Connect):** Współdzielony schowek między telefonem a komputerem, bezprzewodowy transfer plików i powiadomienia.

### 🔄 4. Self-Healing OS (Automatyczna Samonaprawa & Rollback)
* **NexoOS Doctor:** Narzędzie autodiagnostyki SMART dysków, naprawy zablokowanych baz pacmana (`db.lck`), resetowania kluczy PGP i restartu PipeWire.
* **Migawki Btrfs / Snapper z integracją w bootloaderze GRUB:** Nawet w przypadku krytycznej awarii, użytkownik może cofnąć system do poprzedniego stanu wybierając migawkę bezpośrednio z menu startowego GRUB!

### 🌙 5. Zdrowie Wzroku & Narzędzia
* **Tryb Nocny (Filtr Światła Niebieskiego):** Skrót <kbd>Win</kbd> + <kbd>Alt</kbd> + <kbd>N</kbd> lub ikona w doku ociepla barwy (3800K/3000K) z automatycznym harmonogramem po zachodzie słońca.
* **Ekranowy OCR:** Skrót <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> pozwala zaznaczyć dowolny fragment ekranu i natychmiast skopiować rozpoznany tekst (PL + ENG) do schowka.
* **Szybki Pobieracz Multimediów:** Pobieranie wideo 4K i muzyki MP3 z YouTube i TikToka za pomocą `yt-dlp`.

---

## ⌨️ Oficjalna Mapa Skrótów Klawiszowych NexoOS

| Skrót | Działanie |
| :--- | :--- |
| <kbd>Win</kbd> (samodzielnie) | Menu Start / Wyszukiwarka Aplikacji |
| <kbd>Win</kbd> + <kbd>E</kbd> | Eksplorator Plików (Nautilus z QuickLook spacją) |
| <kbd>Win</kbd> + <kbd>I</kbd> | Centrum Ustawień i Personalizacji (`nexo-tweaks`) |
| <kbd>Win</kbd> + <kbd>Alt</kbd> + <kbd>R</kbd> | **Zapisz Powtórkę z Gry (ShadowPlay 60 FPS)** |
| <kbd>Win</kbd> + <kbd>Alt</kbd> + <kbd>N</kbd> | **Przełącz Tryb Nocny (Filtr światła niebieskiego)** |
| <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> | **Ekranowy OCR (Zaznacz i skopiuj tekst z ekranu)** |
| <kbd>Win</kbd> + <kbd>V</kbd> | **Zaszyfrowany Sejf Plików (Nexo Vault)** |
| <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> | **Natychmiastowe Wyczyszczenie Schowka** |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> | **Błyskawiczny Przycisk Paniki (Panic Protocol)** |
| <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> / <kbd>Print</kbd> | Zrzut ekranu do schowka |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Esc</kbd> | Menedżer Zadań (Btop) |
| <kbd>Alt</kbd> + <kbd>F4</kbd> | Zamknij aktywne okno |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> | Przełącznik okien |

---

## 🏗️ Kompilacja Obrazu ISO

Projekt jest w pełni skonfigurowany pod **GitHub Actions** – każde wypchnięcie zmian do gałęzi `main` automatycznie buduje i publikuje obraz `.iso`.

Aby zbudować obraz lokalnie na systemie Arch Linux:
```bash
# 1. Zainstaluj archiso
sudo pacman -Syu --noconfirm archiso

# 2. Uruchom skrypt budujący
sudo ./build.sh
```
Gotowy obraz zostanie zapisany w katalogu `out/NexoOS-x86_64.iso`.
