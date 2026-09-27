# Spider-Man: NYC 🕷️🗽

<p align="center">
  <img src="public/logo.png" alt="Spider-Man NYC Logo" width="520" />
</p>

<p align="center">
  <b>A 3D web-slinging action game built with Three.js, Vite, and Capacitor for Web & Android.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Web%20%7C%20Android-brightgreen?style=flat-square" alt="Platform" />
  <img src="https://img.shields.io/badge/Three.js-r186-black?style=flat-square&logo=three.js" alt="Three.js" />
  <img src="https://img.shields.io/badge/Capacitor-v8.5-blue?style=flat-square&logo=capacitor" alt="Capacitor" />
  <img src="https://img.shields.io/badge/Offline-100%25%20Bundled-red?style=flat-square" alt="Offline Ready" />
</p>

---

## 🎮 Key Features

- **Iconic Suit Selection**:
  - **Homecoming Suit** (Tom Holland era)
  - **Classic 2002 Suit** (Tobey Maguire era with custom diffuse & bump textures)
  - **The Amazing Spider-Man 2 Suit** (Andrew Garfield era)
  - Live interactive 3D model preview in the suit menu (drag to rotate).

- **Stylized Procedural Manhattan**:
  - True-to-life avenue and street grid system with animated traffic and yellow cabs.
  - Central Park with procedural trees and reservoir.
  - Hudson & East River water shaders.
  - Iconic landmarks: Empire State Building with spire beacon & Chrysler Building.
  - Times Square illuminated billboard district.
  - Dynamic neighborhood detection (Midtown, Central Park, Financial District, Harlem, etc.).

- **Physics & Web-Slinging**:
  - Momentum-based pendulum web swinging with fling release boost.
  - Camera-directed web targeting (webs anchor where you look and turn).
  - High-velocity **Web-Zip** mechanic (`Q` / `RMB` / `ZIP` button) to dart directly toward building facades.
  - Wall-climbing and rooftop mantling.

- **Dynamic HUD**:
  - Real-time rotating minimap with compass heading.
  - Speedometer (KM/H) and dynamic FOV widening at high speeds.
  - Health bar and current district tracker.

- **Audio & Post-Processing**:
  - UnrealBloom glow passes for Times Square billboards and sunset skyline haze.
  - Procedural 3D web-shooter sound effects via the Web Audio API.

- **📱 Native Android APK**:
  - Standalone Android APK bundled with **100% offline assets** (Three.js and 3D models embedded).
  - Locked to **Landscape** orientation (`sensorLandscape`).
  - **Immersive sticky fullscreen mode** (hides status bar and navigation buttons).
  - Screen wake lock (`FLAG_KEEP_SCREEN_ON`) prevents display dimming during gameplay.
  - Custom 3D metallic Spider emblem **App Icon**, **Adaptive Icon**, and **Splash Screen**.

---

## 🕹️ Controls

### Desktop (Keyboard & Mouse)
| Action | Key / Input |
| :--- | :--- |
| **Move** | `W`, `A`, `S`, `D` |
| **Look / Aim** | Mouse (click anywhere to lock pointer) |
| **Web Swing** | Hold `Left Click` or `Space` (while in the air) |
| **Steer Swing** | `A` (steer left) / `D` (steer right) |
| **Web-Zip** | `Q` or `Right Click` |
| **Jump** | `Space` |
| **Sprint / Wall Climb** | `Shift` (hold `W` into walls to climb) |

### Mobile / Touch (Android APK & Mobile Web)
| Action | Control |
| :--- | :--- |
| **Move** | Virtual Analog Joystick (bottom-left) |
| **Camera** | Drag anywhere on right half of screen |
| **Web Swing** | Hold **WEB** button |
| **Web-Zip** | Tap **ZIP** button |
| **Jump** | Tap **JUMP** button |
| **Sprint** | Tap **SPRINT** toggle button |

---

## 📱 Android APK Installation

The game is packaged as an Android application (`com.spiderman.nyc`):

### Option 1: Install via ADB (USB Debugging)
With your phone connected via USB and Developer Options enabled:
```powershell
adb install -r Spider-Man-NYC.apk
```

### Option 2: Direct Transfer
1. Transfer `Spider-Man-NYC.apk` to your phone via USB cable, Google Drive, or local Wi-Fi.
2. Tap the APK file on your device.
3. Allow **"Install unknown apps"** when prompted by Android Settings.
4. Launch **Spider-Man NYC** and play!

---

## 🛠️ Development & Building

### Prerequisites
- [Node.js](https://nodejs.org/) (v18+)
- [OpenJDK 21](https://adoptium.net/) (for Android builds)
- [Android SDK](https://developer.android.com/studio) (API 34+)

### 1. Run Web Dev Server
```bash
npm install
npm run dev
```
Open `http://localhost:5173` in your browser.

### 2. Build Web Bundle
```bash
npm run build
```
Generates production-optimized static files in `dist/`.

### 3. Build Android APK
Compile the complete Android APK with one command:
```powershell
npm run build:apk
```
This automatically runs `vite build`, syncs web assets with Capacitor (`npx cap sync android`), compiles using Gradle, and outputs `Spider-Man-NYC.apk` to the project root.

---

## 📂 Project Structure

```
spiderman-game/
├── android/               # Native Android project (Capacitor)
│   ├── app/src/main/res/  # App launcher icons, adaptive icons, splash screens
│   └── gradle.properties  # Configured for JDK 21 build
├── public/                # Static assets bundled into production
│   ├── icon.png           # 512x512 app icon
│   ├── logo.png           # 3D Spider emblem banner
│   └── models/            # Rigged 3D .glb character models & textures
├── scripts/               # Icon & asset generation tooling
├── index.html             # Main entry point & 3D Three.js game engine
├── package.json           # Scripts & project dependencies
├── vite.config.js         # Vite bundler configuration
└── Spider-Man-NYC.apk     # Compiled Android package
```

---

## ⚖️ Disclaimer

This project is a fan-made, non-commercial game developed solely for educational and portfolio demonstration purposes. Spider-Man and related characters and assets are trademarks and copyright of Marvel Entertainment, LLC and Sony Pictures Entertainment Inc.
