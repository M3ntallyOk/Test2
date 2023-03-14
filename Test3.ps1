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

$wallpaper_path = Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Wallpaper
$audio_path = "$env:SystemRoot\Temp\$($urls[1] | Split-Path -Leaf)"
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value '$env:SystemRoot\Temp\Yakuza_nishikiyama_bust.jpg'
rundll32.exe user32.dll, UpdatePerUserSystemParameters
Start-Process powershell.exe -ArgumentList "-c (New-Object Media.SoundPlayer '$audio_path').PlaySync();" -WindowStyle Hidden
Start-Sleep -Seconds 120  # Wait for 2 minutes
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $wallpaper_path
rundll32.exe user32.dll, UpdatePerUserSystemParameters
Remove-Item $path #remove the files
exit
