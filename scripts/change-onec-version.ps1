$reg_path = "HKLM:SYSTEM\CurrentControlSet\Services\1C:Enterprise 8.3 Server Agent"
$value = Get-ItemProperty -Path $reg_path -Name ImagePath
Write-Output $value
$newpath = $value.ImagePath.replace('8.3.9.2170', '8.3.16.1148')
Write-Output $newpath 
Set-ItemProperty -Path $reg_path -Name ImagePath -Value $newpath