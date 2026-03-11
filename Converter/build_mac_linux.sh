#!/bin/bash
# ============================================================
# Hood College Coding Club — JSON Uploader Build Script
# Run this on macOS or Linux to build the standalone app.
# ============================================================

set -e

echo ""
echo " =========================================="
echo "  Hood College Coding Club"
echo "  CSV/Excel to JSON Uploader -- Builder"
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

# ── Install tkinter on macOS (Homebrew Python excludes it) ──
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo ""
    echo "[0/3] Checking tkinter (required for the GUI)..."
    if ! python3 -c "import tkinter" &>/dev/null; then
        echo "      tkinter not found -- installing via Homebrew..."
        if ! command -v brew &>/dev/null; then
            echo "[ERROR] Homebrew is not installed."
            echo "        Install it from https://brew.sh then re-run this script."
            exit 1
        fi
        PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
        brew install python-tk@$PY_VER
        echo "[OK] tkinter installed."
    else
        echo "[OK] tkinter is available."
    fi
fi

# ── Create virtual environment ───────────────────────────
# Use --system-site-packages on macOS so the venv can see
# the system-level tkinter installed by brew.
VENV_DIR=".build_venv"
echo ""
echo "[1/3] Setting up virtual environment..."

if [ -d "$VENV_DIR" ]; then
    echo "      Removing old venv for a clean build..."
    rm -rf "$VENV_DIR"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    python3 -m venv --system-site-packages "$VENV_DIR"
else
    python3 -m venv "$VENV_DIR"
fi
echo "[OK] Virtual environment created."

source "$VENV_DIR/bin/activate"
echo "[OK] Virtual environment activated."

# ── Install packages ──────────────────────────────────────
echo ""
echo "[2/3] Installing required packages..."
pip install --upgrade pip --quiet
pip install requests openpyxl pyinstaller --quiet
echo "[OK] Packages installed."

# ── Build ─────────────────────────────────────────────────
echo ""
echo "[3/3] Building standalone app with PyInstaller..."
echo "      (This may take 1-3 minutes -- please wait)"
echo ""

python -m PyInstaller --noconfirm HoodCC_JSON_Uploader.spec

deactivate

echo ""
echo " =========================================="
echo "  BUILD COMPLETE"
echo " =========================================="
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  macOS app:    dist/HoodCC_JSON_Uploader"
    echo ""
    echo "  To share with others, zip the dist folder:"
    echo "    zip -r HoodCC_JSON_Uploader_mac.zip dist/"
else
    echo "  Linux binary: dist/HoodCC_JSON_Uploader"
fi
echo ""
