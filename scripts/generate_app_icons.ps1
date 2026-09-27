Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\Aryan\.gemini\antigravity-ide\brain\0c59fb54-48f9-4ea0-b0c7-d230f884eddf\.user_uploaded\media_1790518062684.png"
if (-not (Test-Path $srcPath)) {
    Write-Error "Source image not found at $srcPath"
    exit 1
}

$srcBmp = [System.Drawing.Bitmap]::FromFile($srcPath)
$srcW = $srcBmp.Width   # 800
$srcH = $srcBmp.Height  # 450

# The spider emblem is centered horizontally and vertically.
# Let's extract the square region centered on the spider.
# 450x450 square from X = (800 - 450) / 2 = 175, Y = 0
$sqSize = 450
$sqX = [int](($srcW - $sqSize) / 2)
$sqY = 0

function Create-Resized-Icon {
    param(
        [int]$targetW,
        [int]$targetH,
        [double]$scaleRatio = 1.0,
        [bool]$isRound = $false,
        [bool]$isForeground = $false
    )

    $outBmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($outBmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    $bgColor = [System.Drawing.Color]::FromArgb(255, 14, 19, 28) # #0E131C

    if ($isForeground) {
        # Transparent background for foreground layer so it composites over ic_launcher_background
        $g.Clear([System.Drawing.Color]::Transparent)
    } else {
        $g.Clear($bgColor)
    }

    # Calculate destination rectangle
    $drawW = [int]($targetW * $scaleRatio)
    $drawH = [int]($targetH * $scaleRatio)
    $destX = [int](($targetW - $drawW) / 2)
    $destY = [int](($targetH - $drawH) / 2)

    if ($isRound) {
        $path = New-Object System.Drawing.Drawing2D.GraphicsPath
        $path.AddEllipse(0, 0, $targetW, $targetH)
        $g.SetClip($path)
    }

    # Draw the cropped square source into destination
    $srcRect = New-Object System.Drawing.Rectangle($sqX, $sqY, $sqSize, $sqSize)
    $destRect = New-Object System.Drawing.Rectangle($destX, $destY, $drawW, $drawH)
    $g.DrawImage($srcBmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

    $g.Dispose()
    return $outBmp
}

# 1. Generate Mipmap Launcher Icons
$densities = @{
    "mdpi"    = @{ icon = 48;  fg = 108 }
    "hdpi"    = @{ icon = 72;  fg = 162 }
    "xhdpi"   = @{ icon = 96;  fg = 216 }
    "xxhdpi"  = @{ icon = 144; fg = 324 }
    "xxxhdpi" = @{ icon = 192; fg = 432 }
}

foreach ($density in $densities.Keys) {
    $dir = "android\app\src\main\res\mipmap-$density"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    
    $iconSize = $densities[$density].icon
    $fgSize = $densities[$density].fg

    # Standard ic_launcher.png (92% safe scale with dark background)
    $icon = Create-Resized-Icon -targetW $iconSize -targetH $iconSize -scaleRatio 0.95 -isRound $false -isForeground $false
    $icon.Save("$dir\ic_launcher.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $icon.Dispose()

    # Round ic_launcher_round.png (82% safe scale inside circle clip)
    $roundIcon = Create-Resized-Icon -targetW $iconSize -targetH $iconSize -scaleRatio 0.85 -isRound $true -isForeground $false
    $roundIcon.Save("$dir\ic_launcher_round.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $roundIcon.Dispose()

    # Foreground ic_launcher_foreground.png (66% safe scale for adaptive icon masks)
    $fgIcon = Create-Resized-Icon -targetW $fgSize -targetH $fgSize -scaleRatio 0.68 -isRound $false -isForeground $false
    $fgIcon.Save("$dir\ic_launcher_foreground.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $fgIcon.Dispose()

    Write-Output "Generated icons for mipmap-$($density): $($iconSize)px icon, $($fgSize)px fg"
}

# 2. Generate Splash Screens
function Create-Splash {
    param(
        [int]$targetW,
        [int]$targetH,
        [string]$outPath
    )

    $outBmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($outBmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $bgColor = [System.Drawing.Color]::FromArgb(255, 14, 19, 28)
    $g.Clear($bgColor)

    # Scale the 800x450 image to fit nicely within the splash screen with padding
    $ratioW = $targetW / $srcW
    $ratioH = $targetH / $srcH
    # For landscape, keep aspect ratio; for portrait, scale to fit width nicely
    $scale = [Math]::Min($ratioW, $ratioH) * 0.85
    if ($scale -gt 1.5) { $scale = 1.5 }
    if ($targetH -gt $targetW) { # portrait
        $scale = ($targetW * 0.9) / $sqSize
    }

    if ($targetH -gt $targetW) {
        # Portrait: draw cropped square emblem
        $drawW = [int]($sqSize * $scale)
        $drawH = [int]($sqSize * $scale)
        $destX = [int](($targetW - $drawW) / 2)
        $destY = [int](($targetH - $drawH) / 2)
        $srcRect = New-Object System.Drawing.Rectangle($sqX, $sqY, $sqSize, $sqSize)
        $destRect = New-Object System.Drawing.Rectangle($destX, $destY, $drawW, $drawH)
        $g.DrawImage($srcBmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    } else {
        # Landscape: draw full wide image
        $drawW = [int]($srcW * $scale)
        $drawH = [int]($srcH * $scale)
        $destX = [int](($targetW - $drawW) / 2)
        $destY = [int](($targetH - $drawH) / 2)
        $srcRect = New-Object System.Drawing.Rectangle(0, 0, $srcW, $srcH)
        $destRect = New-Object System.Drawing.Rectangle($destX, $destY, $drawW, $drawH)
        $g.DrawImage($srcBmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    }

    $g.Dispose()

    $parent = Split-Path -Path $outPath -Parent
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    $outBmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $outBmp.Dispose()
    Write-Output "Generated splash: $outPath (${targetW}x${targetH})"
}

# Landscape splash screens (game is landscape!)
Create-Splash -targetW 480  -targetH 320  -outPath "android\app\src\main\res\drawable\splash.png"
Create-Splash -targetW 480  -targetH 320  -outPath "android\app\src\main\res\drawable-land-mdpi\splash.png"
Create-Splash -targetW 800  -targetH 480  -outPath "android\app\src\main\res\drawable-land-hdpi\splash.png"
Create-Splash -targetW 1280 -targetH 720  -outPath "android\app\src\main\res\drawable-land-xhdpi\splash.png"
Create-Splash -targetW 1600 -targetH 960  -outPath "android\app\src\main\res\drawable-land-xxhdpi\splash.png"
Create-Splash -targetW 1920 -targetH 1280 -outPath "android\app\src\main\res\drawable-land-xxxhdpi\splash.png"

# Portrait splash screens (in case device briefly rotates before orientation locks)
Create-Splash -targetW 320  -targetH 480  -outPath "android\app\src\main\res\drawable-port-mdpi\splash.png"
Create-Splash -targetW 480  -targetH 800  -outPath "android\app\src\main\res\drawable-port-hdpi\splash.png"
Create-Splash -targetW 720  -targetH 1280 -outPath "android\app\src\main\res\drawable-port-xhdpi\splash.png"
Create-Splash -targetW 960  -targetH 1600 -outPath "android\app\src\main\res\drawable-port-xxhdpi\splash.png"
Create-Splash -targetW 1280 -targetH 1920 -outPath "android\app\src\main\res\drawable-port-xxxhdpi\splash.png"

# 3. Web & App Root Icons
if (-not (Test-Path "public")) { New-Item -ItemType Directory -Path "public" -Force | Out-Null }
# Copy full logo to public/logo.png
Copy-Item $srcPath "public\logo.png" -Force

# Generate 512x512 icon for PWA/Capacitor
$pwa512 = Create-Resized-Icon -targetW 512 -targetH 512 -scaleRatio 0.95 -isRound $false -isForeground $false
$pwa512.Save("public\icon.png", [System.Drawing.Imaging.ImageFormat]::Png)
$pwa512.Dispose()

# Generate favicon.png (64x64)
$fav64 = Create-Resized-Icon -targetW 64 -targetH 64 -scaleRatio 0.95 -isRound $false -isForeground $false
$fav64.Save("public\favicon.png", [System.Drawing.Imaging.ImageFormat]::Png)
$fav64.Dispose()

$srcBmp.Dispose()
Write-Output "All icons and splash screens generated successfully!"
