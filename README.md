# Spider-Man: NYC Swing 🕷️🗽

A 3D Spider-Man web-swinging game built with Three.js in a single HTML file. Features procedural city generation, pendulum swing physics, landmark buildings, multiple suit styles, and dual controls for desktop and mobile.

---

## 🎮 Features

- **Suit Selection**: Choose between 3 iconic suits with real-time 3D model updating:
  - **Homecoming Suit** (Tom Holland era)
  - **Classic 2002 Suit** (Tobey Maguire era)
  - **Amazing Suit** (Andrew Garfield era)
- **Stylized Manhattan Map**:
  - Avenue/street grid with moving traffic
  - Central Park with trees and lake
  - Hudson & East Rivers
  - Midtown skyline & Times Square illuminated billboards
  - Landmarks: Empire State Building with spire beacon & Chrysler Building
  - Dynamic neighborhood detection (Midtown, Harlem, Central Park, Financial District, etc.)
- **Physics & Movement**:
  - Momentum-based pendulum web swinging
  - Release boost / fling physics
  - Web-zip mechanic to pull directly toward targeted surfaces
  - Wall climbing and running
- **Dynamic HUD**:
  - Live rotating Canvas minimap
  - Health bar & KM/H speedometer
  - Active neighborhood & objective tracker
- **Cross-Platform Controls**:
  - Full desktop keyboard + mouse controls
  - Virtual joystick & touch buttons for iOS / Android mobile devices
- **Visuals & Audio**:
  - Filmic ACES tone mapping & sunset atmospheric sky shader
  - Procedural web-shooter audio using Web Audio API

---

## 🕹️ Controls

### Desktop
- **Move**: `W`, `A`, `S`, `D`
- **Look**: Mouse (click anywhere to lock pointer)
- **Web Swing**: Hold `Left Click`, `E`, or `Space` (while airborne)
- **Web-Zip**: `Q` or `Right Click`
- **Jump**: `Space`
- **Sprint / Wall Climb**: `Shift` (hold `W` into walls to climb)

### Mobile / Touch
- **Move**: Virtual Left Joystick
- **Look**: Drag right side of screen
- **Web Swing**: Hold `WEB` button
- **Jump**: `JUMP` button
- **Sprint**: `SPRINT` toggle button

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/aryanpol73/spiderman-game.git
   cd spiderman-game
   ```
2. Open `index.html` directly in any modern browser (Chrome, Firefox, Edge, Safari), or serve it with any local web server:
   ```bash
   npx serve . -l 5173
   ```
   or with Vite:
   ```bash
   npx vite --host
   ```
