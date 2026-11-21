# ============================================================
#  Nova SS - @rywax
#  Kodu Calma PLS
# ============================================================

$ErrorActionPreference = "Stop"


$localAppData = $env:LOCALAPPDATA
if ([string]::IsNullOrWhiteSpace($localAppData)) {
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        $localAppData = Join-Path $env:USERPROFILE "AppData\Local"
    } else {
        $localAppData = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
    }
}
if ([string]::IsNullOrWhiteSpace($localAppData)) {
    throw "Windows Local AppData klasoru belirlenemedi."
}
$script:ToolsDir = Join-Path $localAppData "NovaSS\Tools"
if (-not (Test-Path -LiteralPath $script:ToolsDir -PathType Container)) {
    New-Item -ItemType Directory -Path $script:ToolsDir -Force | Out-Null
}


$script:Groups = @(
    @{
        Name  = "NirSoft"
        Color = "Cyan"
        Tools = @(
            @{ A="WinPrefetchView";      U="https://www.nirsoft.net/utils/winprefetchview-x64.zip";          D="Prefetch dosyalarini goruntuler" },
            @{ A="LastActivityView";     U="https://www.nirsoft.net/utils/lastactivityview.zip";             D="Son kullanici aktivitelerini listeler" },
            @{ A="USBDriveLog";          U="https://www.nirsoft.net/utils/usbdrivelog.zip";                 D="USB surucu gecmisini gosterir" },
            @{ A="WinDefLogView";        U="https://www.nirsoft.net/utils/windeflogview.zip";               D="Windows Defender log goruntuleyici" },
            @{ A="ShellBagsView";        U="https://www.nirsoft.net/utils/shellbagsview.zip";               D="Shell bags / klasor gecmisi" },
            @{ A="UninstallView";        U="https://www.nirsoft.net/utils/uninstallview-x64.zip";            D="Kaldirilan programlari listeler" },
            @{ A="LoadedDllsView";       U="https://www.nirsoft.net/utils/loadeddllsview-x64.zip";           D="Yuklu DLL listesi" },
            @{ A="JumpListsView";        U="https://www.nirsoft.net/utils/jumplistsview.zip";                D="Jump list gecmisi" },
            @{ A="BrowserDownloadsView"; U="https://www.nirsoft.net/utils/browser_download_view.zip";        D="Tarayici indirme gecmisi" },
            @{ A="AlternateStreamView";  U="https://www.nirsoft.net/utils/alternate_streams_view-x64.zip";   D="NTFS alternate stream analizi" },
            @{ A="ExecutedProgramsList"; U="https://www.nirsoft.net/utils/executedprogramslist.zip";         D="Calistirilmis programlar" },
            @{ A="FullEventLogView";     U="https://www.nirsoft.net/utils/fulleventlogview-x64.zip";         D="Olay gunluklerini hizlica goruntuler" },
            @{ A="OpenSaveFilesView";    U="https://www.nirsoft.net/utils/opensavefilesview-x64.zip";        D="Acilan/kaydedilen dosyalar" },
            @{ A="TaskSchedulerView";    U="https://www.nirsoft.net/utils/taskschedulerview-x64.zip";         D="Zamanlayici gorevleri" },
            @{ A="USBDeview";            U="https://www.nirsoft.net/utils/usbdeview-x64.zip";                D="USB cihaz gecmisi" }
        )
    }
    @{
        Name  = "Spokwn"
        Color = "Yellow"
        Tools = @(
            @{ A="BAMParser";      U="https://github.com/spokwn/BAM-parser/releases/download/v1.2.9/BAMParser.exe"; D="BAM kaydi ayristirici" },
            @{ A="PrefetchParser"; U="https://github.com/spokwn/prefetch-parser/releases/download/v1.5.5/PrefetchParser.exe"; D="Prefetch ayristirici" },
            @{ A="ProcessParser";  U="https://github.com/spokwn/process-parser/releases/download/v0.5.5/ProcessParser.exe"; D="Surec bilgisi ayristirici" },
            @{ A="JournalTrace";   U="https://github.com/spokwn/JournalTrace/releases/download/1.2/JournalTraceNormal.exe"; D="USN Journal izleme" },
            @{ A="PathsParser";    U="https://github.com/spokwn/PathsParser/releases/download/v1.2/PathsParser.exe"; D="Dosya yolu gecmisi" },
            @{ A="BamDeletedKeys"; U="https://github.com/spokwn/BamDeletedKeys/releases/download/v1.0/BamDeletedKeys.exe"; D="Silinen BAM kayitlari" }
        )
    }
    @{
        Name  = "OrbDiff"
        Color = "Green"
        Tools = @(
            @{ A="pv++";             U="https://github.com/Orbdiff/PrefetchView/releases/download/v1.6.6/pv++.exe"; D="Detayli Prefetch analiz" },
            @{ A="OrbAmcacheParser"; U="https://github.com/Orbdiff/AmcacheParser/releases/download/v1.0/AmcacheParser.exe"; D="Detayli Amcache analiz" },
            @{ A="JARParser";        U="https://github.com/Orbdiff/JARParser/releases/download/v1.2/JARParser.exe"; D="Basit JAR tarayici" },
            @{ A="Fileless";         U="https://github.com/Orbdiff/Fileless/releases/download/v1.3/fileless.exe"; D="PowerShell izleriyle fileless arar" },
            @{ A="BAMReveal";        U="https://github.com/Orbdiff/BAMReveal/releases/download/v1.3/BAMReveal.exe"; D="BAM kayitlarini goruntuler" }
        )
    }
    @{
        Name  = "Sistem / Analiz"
        Color = "White"
        Tools = @(
            @{ A="SystemInformer"; U="https://github.com/winsiderss/si-builds/releases/download/3.2.25275.112/systeminformer-build-canary-setup.exe"; D="Gelismis sistem monitoru" },
            @{ A="Everything";     U="https://www.voidtools.com/Everything-1.4.1.1029.x86-Setup.exe"; D="Anlik dosya arama" },
            @{ A="InjGen";         U="https://github.com/NotRequiem/InjGen/releases/download/v2.0/InjGen.exe"; D="Enjeksiyon tespit" },
            @{ A="Luyten";         U="https://github.com/deathmarine/Luyten/releases/download/v0.5.4_Rebuilt_with_Latest_depenencies/luyten-0.5.4.exe"; D="Java decompiler" },
            @{ A="dnSpy";          U="https://github.com/dnSpy/dnSpy/releases/download/v6.1.8/dnSpy.zip"; D=".NET decompiler/debugger" },
            @{ A="Jarabel.Light";  U="https://github.com/nay-cat/Jarabel/releases/download/light/Jarabel.Light.exe"; D="JAR analiz araci" },
            @{ A="Unicode";        U="https://github.com/RRancio/Exec/raw/main/Files/Unicode.exe"; D="Unicode karakter analizi" },
            @{ A="CachedProgramsList"; U="https://github.com/ponei/CachedProgramsList/releases/download/1.1/CachedProgramsList.exe"; D="Onbellek program listesi" },
            @{ A="TimeChangeDetect"; U="https://github.com/santiagolin/TimeChangeDetect/releases/download/1.0/TimeChangeDetect.exe"; D="Sistem saati degisim tespiti" },
            @{ A="LogParserLizard";  U="https://github.com/andrasferencz/LogParser-Lizard/releases/download/v1.11.0/LogParserLizardPortable.zip"; D="Log arama/filtreleme" },
            @{ A="PeStudio";         U="https://github.com/PeStudio/PeStudio/releases/download/v1.12.0/PeStudio.zip"; D="PE statik inceleme" },
            @{ A="trid";             U="https://mark0.net/download/trid_x64.zip"; D="Dosya turu tespiti" }
        )
    }
    @{
        Name  = "Minecraft Analiz"
        Color = "Blue"
        Tools = @(
            @{ A="cfr";             U="https://www.benf.org/other/cfr/cfr-0.152.jar"; D="Java decompiler (CFR)" },
            @{ A="procyon";         U="https://github.com/mstrobel/procyon/releases/download/0.6.0/procyon-decompiler-0.6.0.jar"; D="Procyon Java decompiler" },
            @{ A="jd-gui";          U="https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-windows-1.6.6.zip"; D="Java GUI decompiler" },
            @{ A="Bytecode-Viewer"; U="https://github.com/Konloch/bytecode-viewer/releases/download/v2.14.0/Bytecode-Viewer-2.14.0.jar"; D="Bytecode inceleme" },
            @{ A="yara";            U="https://github.com/VirusTotal/yara/releases/download/v4.2.6/yara-4.2.6-win64.zip"; D="Imza tabanli tarama" },
            @{ A="wireshark";       U="https://www.wireshark.org/download/win64/wireshark-win64-4.0.11.exe"; D="Ag trafigi analizi" }
        )
    }
    @{
        Name  = "Sysinternals"
        Color = "DarkGray"
        Tools = @(
            @{ A="ProcessMonitor";  U="https://download.sysinternals.com/files/ProcessMonitor.zip"; D="Gercek zamanli sistem izleme" },
            @{ A="ProcessExplorer"; U="https://download.sysinternals.com/files/ProcessExplorer.zip"; D="Sysinternals surec izleme" },
            @{ A="Autoruns";        U="https://download.sysinternals.com/files/Autoruns.zip"; D="Baslangic ogeleri denetimi" },
            @{ A="Sigcheck";        U="https://download.sysinternals.com/files/Sigcheck.zip"; D="PE imza kontrolu" },
            @{ A="Strings";         U="https://download.sysinternals.com/files/Strings.zip"; D="Dosya/surec metin cikarma" }
        )
    }
)

function Show-Header {
    Clear-Host
    $host.UI.RawUI.WindowTitle = "NOVA SS | @rywax"

    Write-Host "  ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ " -ForegroundColor DarkBlue
    Write-Host "  ████╗  ██║██╔═══██╗██║   ██║██╔══██╗" -ForegroundColor DarkBlue
    Write-Host "  ██╔██╗ ██║██║   ██║██║   ██║███████║" -ForegroundColor Cyan
    Write-Host "  ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║" -ForegroundColor Cyan
    Write-Host "  ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║" -ForegroundColor DarkCyan
    Write-Host "  ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host ""
    Write-Host ""
}
function Pause-Menu { Write-Host ""; Read-Host "Devam etmek icin Enter'a basin" | Out-Null }

function Get-FileName($url) {
    $u = [Uri]$url
    $n = [System.IO.Path]::GetFileName($u.AbsolutePath)
    if ([string]::IsNullOrWhiteSpace($n)) { $n = "download.bin" }
    return $n
}

function Get-FlatList {
    $flat = @()
    foreach ($g in $script:Groups) {
        foreach ($t in $g.Tools) {
            $flat += [pscustomobject]@{
                Group = $g.Name
                Color = $g.Color
                A     = $t.A
                U     = $t.U
                D     = $t.D
            }
        }
    }
    return $flat
}

function Download-Tool($tool) {
    $fn  = Get-FileName $tool.U
    $dst = Join-Path $script:ToolsDir $fn

    if (-not (Test-Path $dst)) {
        try {
            Invoke-WebRequest -Uri $tool.U -OutFile $dst -UseBasicParsing -ErrorAction Stop
        } catch {
            Write-Host "Indirme basarisiz: $($tool.A)" -ForegroundColor Red
            return $null
        }
    }

    if ($fn.ToLower().EndsWith(".zip")) {
        $ex = Join-Path $script:ToolsDir ([System.IO.Path]::GetFileNameWithoutExtension($fn))
        try {
            if (-not (Test-Path $ex)) {
                New-Item -ItemType Directory -Path $ex -Force | Out-Null
            }
            Expand-Archive -Path $dst -DestinationPath $ex -Force -ErrorAction Stop
            $exe = Get-ChildItem -Path $ex -Filter *.exe -Recurse -File |
                Where-Object { $_.Name -notmatch '^(unins|uninstall)' } |
                Select-Object -First 1
            if ($exe) { return $exe.FullName }
            return $ex
        } catch {
            Write-Host "Arac arsivi acilamadi: $($tool.A)" -ForegroundColor Red
            return $null
        }
    }

    return $dst
}
function Run-Target($path) {
    if (-not $path -or -not (Test-Path $path)) {
        Write-Host "Calistirilacak dosya bulunamadi." -ForegroundColor Red
        return
    }

    try {
        if ((Get-Item $path).PSIsContainer) {
            Start-Process explorer.exe -ArgumentList "`"$path`""
        } else {
            Start-Process -FilePath $path -WorkingDirectory (Split-Path $path -Parent)
        }
    } catch {
        Write-Host "Arac baslatilamadi: $($_.Exception.Message)" -ForegroundColor Red
    }
}


function Show-Tools {
    $flat = Get-FlatList
    while ($true) {
        Show-Header
        Write-Host "--- ARACLAR ---" -ForegroundColor Yellow
        Write-Host ""

        $i = 0
        $currentGroup = ""
        foreach ($t in $flat) {
            if ($t.Group -ne $currentGroup) {
                if ($currentGroup -ne "") { Write-Host "" }
                Write-Host "  [$($t.Group)]" -ForegroundColor $t.Color
                $currentGroup = $t.Group
            }
            $i++
            Write-Host ("   {0,2}) " -f $i) -NoNewline -ForegroundColor DarkGray
            Write-Host ("{0,-24}" -f $t.A) -NoNewline -ForegroundColor $t.Color
            Write-Host " $($t.D)" -ForegroundColor Gray
        }

        Write-Host ""
        Write-Host "   0) Geri" -ForegroundColor DarkGray
        Write-Host ""
        $sel = Read-Host "  Arac numarasi"

        if ($sel -eq "0") { return }
        if ($sel -notmatch "^\d+$") { Write-Host " Gecersiz." -ForegroundColor Red; Pause-Menu; continue }

        $idx = [int]$sel - 1
        if ($idx -lt 0 -or $idx -ge $flat.Count) { Write-Host " Gecersiz." -ForegroundColor Red; Pause-Menu; continue }

        Show-ToolDetail $flat[$idx]
    }
}

function Show-ToolDetail($tool) {
    while ($true) {
        Show-Header
        Write-Host "=======================================================" -ForegroundColor Cyan
        Write-Host ("  {0}" -f $tool.A) -ForegroundColor $tool.Color
        Write-Host "=======================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  Grup     : $($tool.Group)" -ForegroundColor $tool.Color
        Write-Host "  Aciklama : $($tool.D)" -ForegroundColor White
        Write-Host "  URL      : $($tool.U)" -ForegroundColor DarkGray
        $targetName = Get-FileName $tool.U
        Write-Host ("  Hedef    : " + $script:ToolsDir + "\" + $targetName) -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "  1) Indir" -ForegroundColor Green
        Write-Host "  2) Indir ve calistir" -ForegroundColor Green
        Write-Host "  3) Tarayicida ac" -ForegroundColor Green
        Write-Host "  0) Geri" -ForegroundColor DarkGray
        Write-Host ""
        $a = Read-Host "  Secim"
        switch ($a) {
            "1" {
                $p = Download-Tool $tool
                if ($p) { Write-Host "Arac hazir." -ForegroundColor Cyan; Start-Sleep -Milliseconds 500 }
            }
            "2" {
                $p = Download-Tool $tool
                if ($p) { Run-Target $p }
                Start-Sleep -Milliseconds 500
            }
            "3" { Start-Process $tool.U }
            "0" { return }
            default { Write-Host " Gecersiz." -ForegroundColor Red; Pause-Menu }
        }
    }
}
function Show-Downloaded {
    while ($true) {
        Show-Header
        Write-Host "--- INDIRILENLER ---" -ForegroundColor Yellow
        Write-Host "  Klasor: $script:ToolsDir" -ForegroundColor DarkGray
        Write-Host ""
        if (-not (Test-Path $script:ToolsDir)) {
            Write-Host "  Henuz indirilen arac yok." -ForegroundColor Yellow
            Pause-Menu; return
        }
        $files = Get-ChildItem -Path $script:ToolsDir -File | Sort-Object LastWriteTime -Descending
        if ($files.Count -eq 0) {
            Write-Host "  Henuz indirilen arac yok." -ForegroundColor Yellow
            Pause-Menu; return
        }
        $i = 0
        foreach ($f in $files) {
            $i++
            Write-Host ("  {0,2}) " -f $i) -NoNewline -ForegroundColor DarkGray
            Write-Host ("{0,-40}" -f $f.Name) -NoNewline -ForegroundColor White
            Write-Host (" {0} KB" -f [math]::Round($f.Length/1KB,1)) -ForegroundColor Gray
        }
        Write-Host ""
        Write-Host "  K) Klasoru ac   0) Geri" -ForegroundColor DarkGray
        $sel = Read-Host "  Dosya numarasi"
        if ($sel -eq "0") { return }
        if ($sel -match "^[kK]$") { Start-Process explorer.exe $script:ToolsDir; continue }
        if ($sel -notmatch "^\d+$" -or [int]$sel -lt 1 -or [int]$sel -gt $files.Count) {
            Write-Host " Gecersiz." -ForegroundColor Red; Pause-Menu; continue
        }
        $f = $files[[int]$sel - 1]
        Write-Host ""
        Write-Host "  $($f.FullName)" -ForegroundColor DarkGray
        Write-Host "  1) Calistir   2) Klasorde goster   3) Sil   0) Geri" -ForegroundColor Green
        $a = Read-Host "  Secim"
        switch ($a) {
            "1" { try { Start-Process -FilePath $f.FullName -WorkingDirectory $f.DirectoryName } catch { Write-Host " Hata: $($_.Exception.Message)" -ForegroundColor Red }; Pause-Menu }
            "2" { Start-Process explorer.exe "/select,`"$($f.FullName)`""; Pause-Menu }
            "3" { Remove-Item $f.FullName -Force; Write-Host " Silindi." -ForegroundColor Green; Pause-Menu }
        }
    }
}

$exit = $false
while (-not $exit) {
    Show-Header
    Write-Host "  1) Araclar"       -ForegroundColor White
    Write-Host "  2) Indirilenler" -ForegroundColor White
    Write-Host "  0) Cikis"        -ForegroundColor White
    Write-Host ""
    $sel = Read-Host "  Secim"
    switch ($sel) {
        "1" { Show-Tools }
        "2" { Show-Downloaded }
        "0" { $exit = $true }
        default { Write-Host " Gecersiz." -ForegroundColor Red; Pause-Menu }
    }
}

Write-Host ""
Write-Host "Nova SS kapatildi." -ForegroundColor DarkGray
