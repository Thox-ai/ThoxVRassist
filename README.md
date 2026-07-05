<!-- thox-badges -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square&labelColor=09090b)](LICENSE)
[![THOX.ai Portfolio](https://img.shields.io/badge/THOX.ai%20portfolio-View%20Project-blue?style=flat-square&labelColor=09090b)](https://thox.ai)
[![Status: active](https://img.shields.io/badge/status-active-green?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai)
[![Latest Release](https://img.shields.io/github/v/release/thox-ai/thox-ai?style=flat-square&labelColor=09090b&logo=github)](https://github.com/thox-ai/thox-ai/releases)
[![Last Commit](https://img.shields.io/github/last-commit/thox-ai/thox-ai?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai/commits/main)
[![Open Issues](https://img.shields.io/github/issues/thox-ai/thox-ai?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai/issues)
<!-- /thox-badges -->

# THOX.ai Quest 3 Prototyping Assistant

A web-based Mixed Reality (MR) companion application designed to run on the Meta Quest 3 (512GB). This tool assists hardware engineers with soldering, assembly, and 3D print quality control by leveraging Gemini 2.5 Flash Vision for real-time edge-style inference.

## 🚀 Features

- **Zero-Install Architecture**: Runs entirely within the Meta Quest Browser or any standard mobile/desktop web browser.
- **Soldering QC**: Analyzes circuit board joints for cold solders, bridging, and insufficient wetting.
- **Assembly Guidance**: Identifies components on your workbench and suggests the next logical assembly step.
- **3D Print Metrology**: Inspects 3D printed parts for common defects like warping, layer shifting, and under-extrusion.
- **Futuristic HUD UI**: Designed to look and feel like a high-tech augmented reality overlay with terminal outputs and scanline effects.

## 🛠️ Tech Stack

- **Frontend**: HTML5, Tailwind CSS (via CDN), Phosphor Icons
- **AI Engine**: Google Gemini 2.5 Flash (Vision) via REST API
- **Hardware Target**: Meta Quest 3 (utilizing passthrough camera capture via HTML file inputs)

## ⚙️ Setup & Usage

### 1. Deployment

Serve the `index.html` file using any standard web server (e.g., GitHub Pages, Vercel, Netlify, or a local server like `python -m http.server`).

```bash
# Start local development server
python -m http.server 8080

# Open on Quest 3 Browser
# Navigate to http://localhost:8080 or your GitHub Pages URL
```

### 2. Access on Quest 3

1. Open the Meta Quest Browser in your headset
2. Navigate to the hosted URL
3. Click "Activate Sensors" - the Quest browser will prompt you to capture an image using the headset's external cameras
4. Select your desired mode (Soldering, Assembly, or Print QC)
5. The image is sent to Gemini Vision, and the analysis is streamed back into the virtual terminal in seconds

### 3. API Configuration

The application uses Google Gemini 2.5 Flash Vision API. To use this service, you need to set the `GEMINI_API_KEY` environment variable:

```bash
export GEMINI_API_KEY="your-api-key-here"
```

You can also pass it directly when serving:

```bash
export GEMINI_API_KEY="your-api-key" && python -m http.server 8080
```

## 📝 Note on Quest 3 Camera Access

Currently, standard WebXR APIs do not allow direct raw pixel access to the Quest 3 passthrough cameras for continuous streaming due to privacy restrictions. This application elegantly bypasses this by utilizing the standard HTML `<input type="file" capture="environment">` tag, which invokes the Quest's native camera capture UI, allowing the user to explicitly snap and share a high-res image of their workbench for analysis.

## 🎯 Quality Control Modes

### Soldering QC Mode
- Detects cold joints (dull/grainy appearance)
- Identifies insufficient wetting
- Flags excessive solder (blobs)
- Detects solder bridges (shorts)
- Highlights scorched pads

### Assembly Mode
- Identifies all loose or partially assembled parts
- Suggests next logical assembly step
- Warns about alignment issues and common mistakes

### 3D Print QC Mode
- Detects layer shifting
- Identifies z-banding
- Flags severe stringing
- Detects warping off the bed
- Evaluates under-extrusion
- Provides PASS/FAIL verdict
