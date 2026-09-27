Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem -Path "android\app\src\main\res" -Recurse -Filter "*.png"
foreach ($f in $files) {
    try {
        $img = [System.Drawing.Image]::FromFile($f.FullName)
        Write-Output "$($f.Directory.Name)/$($f.Name): $($img.Width)x$($img.Height)"
        $img.Dispose()
    } catch {
        Write-Output "$($f.Name): Error"
    }
}
