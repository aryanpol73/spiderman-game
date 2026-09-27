Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\Aryan\.gemini\antigravity-ide\brain\0c59fb54-48f9-4ea0-b0c7-d230f884eddf\.user_uploaded\media_1790518062684.png"
$bmp = [System.Drawing.Bitmap]::FromFile($srcPath)

$c1 = $bmp.GetPixel(10, 10)
$c2 = $bmp.GetPixel(790, 10)
$c3 = $bmp.GetPixel(10, 440)
$c4 = $bmp.GetPixel(790, 440)

Write-Output "Corner colors:"
Write-Output "Top-Left: R=$($c1.R), G=$($c1.G), B=$($c1.B) -> #$($c1.R.ToString('X2'))$($c1.G.ToString('X2'))$($c1.B.ToString('X2'))"
Write-Output "Top-Right: R=$($c2.R), G=$($c2.G), B=$($c2.B) -> #$($c2.R.ToString('X2'))$($c2.G.ToString('X2'))$($c2.B.ToString('X2'))"
Write-Output "Bottom-Left: R=$($c3.R), G=$($c3.G), B=$($c3.B) -> #$($c3.R.ToString('X2'))$($c3.G.ToString('X2'))$($c3.B.ToString('X2'))"
Write-Output "Bottom-Right: R=$($c4.R), G=$($c4.G), B=$($c4.B) -> #$($c4.R.ToString('X2'))$($c4.G.ToString('X2'))$($c4.B.ToString('X2'))"

$bmp.Dispose()
