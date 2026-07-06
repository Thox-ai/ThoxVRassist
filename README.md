<!-- thox-badges -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=flat-square&labelColor=09090b)](LICENSE)
[![THOX.ai](https://img.shields.io/badge/THOX.ai-portfolio-0a0a0a?style=flat-square&labelColor=09090b)](https://thox.ai)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/ThoxVRassist)
[![Release](https://img.shields.io/github/v/release/Thox-ai/ThoxVRassist?style=flat-square&labelColor=09090b&logo=github)](https://github.com/Thox-ai/ThoxVRassist/releases)
[![Last Commit](https://img.shields.io/github/last-commit/Thox-ai/ThoxVRassist?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/ThoxVRassist/commits/main)
[![Issues](https://img.shields.io/github/issues/Thox-ai/ThoxVRassist?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/ThoxVRassist/issues)
<!-- /thox-badges -->

# THOX.ai Quest 3 Prototyping Assistant

A web-based Mixed Reality (MR) companion application designed to run on the
Meta Quest 3 (512GB). It assists hardware engineers with soldering, assembly,
and 3D print quality control by leveraging Gemini 2.5 Flash Vision for
real-time, edge-style inference.

## Features

- **Zero-Install Architecture**: Runs entirely within the Meta Quest Browser or
  any standard mobile/desktop web browser.
- **Soldering QC**: Analyzes circuit board joints for cold solders, bridging,
  and insufficient wetting.
- **Assembly Guidance**: Identifies components on your workbench and suggests
  the next logical assembly step.
- **3D Print Metrology**: Inspects 3D printed parts for common defects like
  warping, layer shifting, and under-extrusion.
- **Futuristic HUD UI**: A high-tech augmented reality overlay with terminal
  outputs and scanline effects.

## Tech Stack

- **Frontend**: HTML5, Tailwind CSS (via CDN), Phosphor Icons
- **AI Engine**: Google Gemini 2.5 Flash (Vision) via REST API
- **Hardware Target**: Meta Quest 3 (passthrough camera capture via HTML file
  inputs)

## Setup and Usage

### 1. Deployment

Serve `index.html` with any standard web server (GitHub Pages, Vercel,
Netlify, or a local server).

```bash
python -m http.server 8080
# Open on Quest 3 Browser at http://localhost:8080 or your GitHub Pages URL
```

### 2. Access on Quest 3

1. Open the Meta Quest Browser in your headset.
2. Navigate to the hosted URL.
3. Click "Activate Sensors"; the Quest browser prompts you to capture an image
   using the headset's external cameras.
4. Select a mode (Soldering, Assembly, or Print QC).
5. The image is sent to Gemini Vision and the analysis streams back into the
   virtual terminal in seconds.

### 3. API Configuration

The application uses Google Gemini 2.5 Flash Vision API. Set the
`GEMINI_API_KEY` environment variable:

```bash
export GEMINI_API_KEY="your-api-key-here"
export GEMINI_API_KEY="your-api-key" && python -m http.server 8080
```

## Note on Quest 3 Camera Access

Standard WebXR APIs do not allow direct raw pixel access to the Quest 3
passthrough cameras for continuous streaming due to privacy restrictions. This
application uses the standard HTML `<input type="file" capture="environment">`
tag, which invokes the Quest native camera capture UI so the user explicitly
snaps and shares a high-resolution image of the workbench for analysis.

## Quality Control Modes

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

## Repository Layout

```
ThoxVRassist/
├── index.html        # Single-file MR application (HUD + capture + analysis)
├── THOX.bash         # Helper shell utilities
├── LICENSE            # MIT license
├── README.md          # This document
├── CONTRIBUTING.md    # Contribution guidelines
└── SECURITY.md        # Security policy
```

## Documentation

- [CONTRIBUTING.md](CONTRIBUTING.md) - contribution guidelines
- [SECURITY.md](SECURITY.md) - vulnerability reporting policy
- [THOX.ai](https://thox.ai) - product portfolio

## Legal

Copyright (c) 2026 Thox.ai LLC. All rights reserved.

Thox.ai LLC is an independent Texas limited liability company.

- **Tommy Xaypanya** - Chief Technology Officer (CTO)
- **Craig Ross** - Chief Executive Officer (CEO)

Licensed under the [MIT License](LICENSE).