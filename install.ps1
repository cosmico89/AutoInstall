# =============================================
# ⚙️ CONFIGURAZIONE
# =============================================

# Percorso per i file temporanei
$TempFolder = "$env:TEMP\InstallScripts"
New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null

# =============================================
# 1️⃣ INSTALLAZIONE CHOCOLATEY (se non presente)
# =============================================

if (!(Test-Path "C:\ProgramData\chocolatey\bin\choco.exe")) {
    Write-Host "🔹 Chocolatey non trovato, installazione in corso..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "✅ Chocolatey installato con successo!"
} else {
    Write-Host "✅ Chocolatey già installato!"
}

# =============================================
# 2️⃣ INSTALLAZIONE SOFTWARE TRAMITE CHOCOLATEY
# =============================================

Write-Host "🔹 Installazione software con Chocolatey..."
choco install googlechrome rustdesk vlc mpc-hc k-litecodecpackfull notepadplusplus thunderbird firefox -y

Write-Host "✅ Software installati con Chocolatey!"

# =============================================
# 3️⃣ INSTALLAZIONE VISUAL STUDIO CODE
# =============================================

Write-Host "🔹 Scaricamento e installazione di Visual Studio Code..."
$vsCodeUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"
$vsCodeInstaller = "$TempFolder\VSCodeSetup.exe"
Invoke-WebRequest -Uri $vsCodeUrl -OutFile $vsCodeInstaller

# Installazione silenziosa
Start-Process -FilePath $vsCodeInstaller -ArgumentList "/silent", "/mergetasks=!runcode" -Wait
Write-Host "✅ Visual Studio Code installato!"

# Installazione Language Pack Italiano per VS Code
Write-Host "🔹 Installazione Language Pack Italiano per VS Code..."
$env:Path += ";$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin"
code --install-extension MS-CEINTL.vscode-language-pack-it
Write-Host "✅ Language Pack IT installato!"

# =============================================
# 4️⃣ INSTALLAZIONE ADOBE READER
# =============================================

Write-Host "🔹 Scaricamento e installazione di Adobe Reader..."
$adobeUrl = "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/2301020399/AcroRdrDC2301020399_it_IT.exe"
$adobeInstaller = "$TempFolder\AcroRdrDC_it.exe"
Invoke-WebRequest -Uri $adobeUrl -OutFile $adobeInstaller

# Installazione silenziosa
Start-Process -FilePath $adobeInstaller -ArgumentList "/sAll", "/rs", "/rps", "/msi", "/norestart", "EULA_ACCEPT=YES" -Wait
Write-Host "✅ Adobe Reader installato!"

# =============================================
# 🎉 PULIZIA FINALE
# =============================================

Write-Host "🧹 Pulizia file temporanei..."
Remove-Item -Path $TempFolder -Recurse -Force

Write-Host "✅ Installazione completata! Riavviare il PC se necessario."
