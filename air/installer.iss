; PeacefreeRevival: the Inno Setup 6 script that scripts/release_air.py builds the AIR app's
; installer with (to-do 12, step B). It installs an app folder made by scripts/package_air.py as
; it is, for the current user only, with no admin prompt. release_air.py passes in these defines,
; the names and version from the app's own descriptor (META-INF/AIR/application.xml):
;   AppFolder      the app folder to install
;   AppId          the descriptor's <id>: Windows keeps the uninstall entry under it, and a newer
;                  installer with the same one updates the app, so it never changes either
;   AppName        the descriptor's <name>: the install folder and the shortcuts
;   ExeName        the descriptor's <filename> and .exe
;   AppVersion     the descriptor's <versionLabel> without "Revival " ("1.0")
;   VersionNumber  the descriptor's <versionNumber> ("1.0.0")
;   SetupIcon      an .ico of air/icons/, for the installer itself
;   OutputDir, OutputName  where the installer goes
; The uninstaller removes only what it installed, so the saves (in AppData, in a folder named
; after the app ID) stay. What each setting does: Inno Setup's help (ISetup.chm).

#ifndef AppFolder
  #error Build this with scripts/release_air.py, which passes in the defines above.
#endif

[Setup]
AppId={#AppId}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
; Windows' installed apps list shows these; never the game's own publisher (unofficial).
AppPublisher=Peacefree Revival (unofficial fan patch)
AppPublisherURL=https://github.com/hamsterkoster/PeacefreeRevival
VersionInfoVersion={#VersionNumber}
; The current user only, no admin prompt: {autopf} is then %LOCALAPPDATA%\Programs.
PrivilegesRequired=lowest
DefaultDirName={autopf}\{#AppName}
; One Start menu entry, no Start menu folder to pick.
DisableProgramGroupPage=yes
; The app is 64-bit only (package_air.py's -arch x64).
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SetupIconFile={#SetupIcon}
UninstallDisplayIcon={app}\{#ExeName}
OutputDir={#OutputDir}
OutputBaseFilename={#OutputName}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
; Ticked by default; the silent install in release_air.py --check leaves it out.
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[InstallDelete]
; An update installs over the old version: its runtime goes first, so no file of an older AIR
; SDK stays next to the new one.
Type: filesandordirs; Name: "{app}\Adobe AIR"

[Files]
Source: "{#AppFolder}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\{#ExeName}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#ExeName}"; Tasks: desktopicon

[Run]
; "Launch Peacefree Revival" on the last page, ticked.
Filename: "{app}\{#ExeName}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent
