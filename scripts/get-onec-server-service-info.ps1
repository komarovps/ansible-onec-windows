
$WQL = 'SELECT Name, PathName FROM Win32_Service WHERE Name LIKE "1C:Enterprise%"'
$services = Get-WmiObject -query $WQL

foreach ($service in $services) {
    $srv_name = $service.Name
    $srv_pathname = $service.PathName
    break
}
Write-Debug "Service pathname: $srv_pathname" 
if (!$srv_pathname) { return }

$pattern = '\-.*'

Select-String $pattern -input $srv_pathname -AllMatches |
      % { $_.Matches } | % {
        $srv_params = $_.Value    
      }

Write-Output $srv_name
Write-Output $srv_params
