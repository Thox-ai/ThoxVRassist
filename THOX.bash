#!/usr/bin/env bash
# THOX.ai Vision Prototyping Deployment Script
# Usage: ./THOX.bash [deploy|serve|cleanup]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="ThoxVRassist"
DEPLOYMENT_DIR="$SCRIPT_DIR/deployments"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
usage() {
    cat <<EOF
THOX.ai Vision Prototyping Deployment Tool

Usage: $0 [command] [options]

Commands:
  deploy    - Deploy to GitHub Pages (requires GITHUB_TOKEN env var)
  serve     - Start local HTTP server (default port 8080)
  cleanup   - Remove deployment artifacts and temp files

Environment Variables:
  GITHUB_TOKEN  - GitHub Personal Access Token with repo scope
  PORT          - Optional port for local server (default: 8080)
  BASE_URL      - GitHub Pages base URL (default: /)

Examples:
  $0 deploy                    # Deploy to GitHub Pages
  $0 serve                     # Run local dev server
  $0 cleanup                   # Clean up deployment artifacts

EOF
}

deploy() {
    echo -e "${YELLOW}[DEPLOYMENT]${NC} Initializing GitHub Pages deployment..."
    
    # Create deployment directory if it doesn't exist
    mkdir -p "$DEPLOYMENT_DIR"
    
    # Check if GITHUB_TOKEN is set
    if [[ -z "${GITHUB_TOKEN:-}" ]]; then
        echo -e "${RED}[ERROR]${NC} GITHUB_TOKEN environment variable is not set."
        echo "Set a valid token with repo scope to deploy to GitHub Pages."
        return 1
    fi
    
    # Build the project
    echo -e "${GREEN}[BUILD]${NC} Building project..."
    cd "$SCRIPT_DIR"
    
    # Create .github/workflows directory
    mkdir -p .github/workflows
    
    # Create CI workflow
    cat > .github/workflows/pages.yml << 'WORKFLOW'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
    paths:
      - 'index.html'
      - '.github/workflows/pages.yml'
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Pages
        uses: actions/configure-pages@v4
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: '.'

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
WORKFLOW
    
    # Create README.md with deployment instructions
    cat > README.md << 'README'
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

## 📄 License

MIT License - See LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please read CONTRIBUTING.md for details on our code of conduct, contributing guidelines, and pull request process.

## 📞 Support

For technical support or questions, please open an issue on GitHub.

---

**THOX.ai** - Mixed Reality Prototyping Assistant
README

    # Build deployment artifacts
    cp index.html "$DEPLOYMENT_DIR/"
    cp README.md "$DEPLOYMENT_DIR/"
    
    echo -e "${GREEN}[SUCCESS]${NC} Deployment completed successfully!"
    echo "Files placed in: $DEPLOYMENT_DIR"
}

serve() {
    # Check for optional PORT environment variable
    PORT="${PORT:-8080}"
    
    echo -e "${YELLOW}[INFO]${NC} Starting local HTTP server on port $PORT..."
    
    python -m http.server "$PORT"
}

cleanup() {
    echo -e "${YELLOW}[CLEANUP]${NC} Removing deployment artifacts..."
    
    # Remove deployment directory if it exists
    if [[ -d "$DEPLOYMENT_DIR" ]]; then
        rm -rf "$DEPLOYMENT_DIR"
        echo "Removed: $DEPLOYMENT_DIR"
    fi
    
    # Remove .github directory if it exists
    if [[ -d ".github" ]]; then
        rm -rf .github
        echo "Removed: .github directory"
    fi
    
    echo -e "${GREEN}[DONE]${NC} Cleanup completed."
}

# Main script logic
case "${1:-}" in
    deploy)
        deploy
        ;;
    serve)
        serve
        ;;
    cleanup)
        cleanup
        ;;
    *)
        usage
        ;;
esac
