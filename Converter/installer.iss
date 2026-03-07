; Hood College Coding Club — CSV/Excel → JSON GitHub Uploader
; Inno Setup Installer Script
; Run this with Inno Setup Compiler (free): https://jrsoftware.org/isinfo.php

#define AppName      "Hood CC JSON Uploader"
#define AppVersion   "1.0.0"
#define AppPublisher "Hood College Coding Club"
#define AppURL       "https://hood.edu"
#define AppExeName   "HoodCC_JSON_Uploader.exe"

[Setup]
AppId={{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={autopf}\HoodCC JSON Uploader
DefaultGroupName={#AppName}
AllowNoIcons=yes
; Installer output
OutputDir=installer_output
OutputBaseFilename=HoodCC_JSON_Uploader_Setup_v{#AppVersion}
; Compression
Compression=lzma2/ultra64
SolidCompression=yes
; UI
WizardStyle=modern
WizardSizePercent=120
; No admin rights required — installs per-user
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon";     Description: "Create a &desktop shortcut";           GroupDescription: "Additional icons:"; Flags: unchecked
Name: "quicklaunchicon"; Description: "Create a &Quick Launch shortcut"; GroupDescription: "Additional icons:"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
; Main executable (built by PyInstaller)
Source: "dist\{#AppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; Optional: include README and How-To doc alongside the exe
Source: "README.md";                                DestDir: "{app}"; Flags: ignoreversion isreadme
Source: "HowToUse_HoodCC_JSON_Uploader.docx";      DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist

[Icons]
; Start Menu shortcut
Name: "{group}\{#AppName}";          Filename: "{app}\{#AppExeName}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
; Desktop shortcut (optional)
Name: "{autodesktop}\{#AppName}";    Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Run]
; Offer to launch after install
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName} now"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Clean up log folder on uninstall (optional — remove these lines to keep logs)
; Type: filesandordirs; Name: "{userdocs}\HoodCC_Logs"
