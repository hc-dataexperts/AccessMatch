#!/bin/bash
# ============================================================
# Hood College Coding Club — JSON Uploader Build Script
# Run this on macOS or Linux to build the standalone app.
# ============================================================

set -e

echo ""
echo " =========================================="
echo "  Hood College Coding Club"
echo "  CSV/Excel to JSON Uploader — Builder"
echo " =========================================="
echo ""

# ── Check Python ─────────────────────────────────────────
if ! command -v python3 &>/dev/null; then
    echo "[ERROR] Python 3 is not installed."
    echo "        macOS:  brew install python3"
    echo "        Ubuntu: sudo apt install python3 python3-pip"
    exit 1
fi
echo "[OK] Python: $(python3 --version)"

# ── Install packages ─────────────────────────────────────
echo ""
echo "[1/2] Installing required packages..."
pip3 install --upgrade pip --quiet
pip3 install requests openpyxl pyinstaller --quiet
echo "[OK] Packages installed."

# ── Build ─────────────────────────────────────────────────
echo ""
echo "[2/2] Building standalone app with PyInstaller..."
echo "      (This may take 1-3 minutes — please wait)"
echo ""

pyinstaller --noconfirm HoodCC_JSON_Uploader.spec

echo ""
echo " =========================================="
echo "  BUILD COMPLETE"
echo " =========================================="
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  macOS app:  dist/HoodCC_JSON_Uploader"
    echo ""
    echo "  To distribute on macOS, zip the 'dist' folder:"
    echo "    zip -r HoodCC_JSON_Uploader_mac.zip dist/"
else
    echo "  Linux binary:  dist/HoodCC_JSON_Uploader"
fi
echo ""
