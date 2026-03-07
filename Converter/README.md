# CSV / Excel → JSON · GitHub Uploader

> **Developed by [Hood College Coding Club](https://hood.edu)**  
> A desktop tool to convert CSV and Excel files to JSON and upload them directly to a private GitHub repository. Distributed as a standalone installer — no Python or command line required for end users.

---

## For End Users — Installation

### Windows (Recommended)
1. Download `HoodCC_JSON_Uploader_Setup_v1.0.0.exe` from the Releases section
2. Double-click and follow the installer wizard
3. Launch from the Desktop shortcut or Start Menu

> **No Python, pip, or command line needed.** Everything is bundled.

### macOS / Linux
Download the binary from Releases and run it directly. Or see **Build from Source** below.

---

## Features

- **Multi-format input** — Supports `.csv`, `.xlsx`, and `.xls` files
- **Smart cleaning** — Automatically skips fully-empty rows and columns
- **Direct GitHub upload** — Pushes JSON to any branch in any private or public repo
- **Fine-grained token support** — Uses GitHub's modern `Bearer` auth
- **Step tracker** — Visual 6-stage progress bar
- **Test Connection** — Validates token and repo access before uploading
- **Activity Log** — Real-time log in the UI
- **Session log file** — Auto-saved to `~/HoodCC_Logs/uploader_YYYYMMDD.log`
- **Auto URL parsing** — Paste a full GitHub URL; owner/repo are split automatically

---

## For Developers — Build from Source

### Prerequisites
- Python 3.9+
- pip

### Install dependencies
```bash
pip install requests openpyxl
```

### Run directly
```bash
python csv_to_json_uploader.py
```

### Build standalone installer

**Windows** — just double-click:
```
build_windows.bat
```

**macOS / Linux:**
```bash
chmod +x build_mac_linux.sh
./build_mac_linux.sh
```

The build script will:
1. Install `pyinstaller` automatically
2. Bundle everything into a single `.exe` (Windows) or binary (Mac/Linux)
3. If [Inno Setup](https://jrsoftware.org/isinfo.php) is installed, also produce a Windows installer `.exe`

Output: `dist/HoodCC_JSON_Uploader.exe` + `installer_output/HoodCC_JSON_Uploader_Setup_v1.0.0.exe`

---

## GitHub Token Setup

1. Go to **GitHub → Settings → Developer settings → Fine-grained tokens**
2. Click **Generate new token**
3. Under **Repository access**, select your target repository
4. Under **Permissions → Repository permissions**, set **Contents → Read and write**
5. Copy the token and paste it into the **Personal Token** field in the app

> The token is masked in the UI and never written to disk.

---

## File Structure

```
csv_to_json_uploader.py              # Main app — single Python file
HoodCC_JSON_Uploader.spec            # PyInstaller build config
build_windows.bat                    # One-click Windows build script
build_mac_linux.sh                   # Mac/Linux build script
installer.iss                        # Inno Setup installer script (Windows)
README.md                            # This file
HowToUse_HoodCC_JSON_Uploader.docx   # Full user guide
```

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `Repo not found (404)` | Check repo name spelling; ensure token has Contents: Read & Write |
| `Token invalid (401)` | Regenerate token; check for extra spaces |
| `403 Forbidden` | Edit token → set Contents to Read and write |
| `UTF-8 decode error` | Re-save CSV as UTF-8: Excel → Save As → CSV UTF-8 |
| `Sheet not found` | Sheet name is case-sensitive |
| `File > 1 MB` | Set JSON Indent to 0 (minified) |
| SmartScreen warning | Click "More info" then "Run anyway" (app is not code-signed) |

---

## Log File

All sessions are automatically saved to:
```
~/HoodCC_Logs/uploader_YYYYMMDD.log
```

---

Developed and maintained by **Hood College Coding Club** · [hood.edu](https://hood.edu)
