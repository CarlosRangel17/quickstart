Write-Host "************************************************"
echo "Starting environment deinstallation process..."

echo "Checking for Chocolatey installation..."
$ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}

if (!$ChocoInstalled) {
  Write-Warning "The ChocolateyInstall environment variable was not found. \n Chocolatey is not detected as installed. Nothing to do"
  return
}

echo "Proceeding with removing chocolatey..."
$userPath = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString()
$machinePath = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString()

@"
User PATH:
$userPath

Machine PATH:
$machinePath
"@ | Out-File "C:\PATH_backups_ChocolateyUninstall.txt" -Encoding UTF8 -Force

if ($userPath -like "*$env:ChocolateyInstall*") {
  Write-Output "Chocolatey Install location found in User Path. Removing..."
  # WARNING: This could cause issues after reboot where nothing is
  # found if something goes wrong. In that case, look at the backed up
  # files for PATH.
  [System.Text.RegularExpressions.Regex]::Replace($userPath, [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_.Replace(";;",";"), 'User')}
}

if ($machinePath -like "*$env:ChocolateyInstall*") {
  Write-Output "Chocolatey Install location found in Machine Path. Removing..."
  # WARNING: This could cause issues after reboot where nothing is
  # found if something goes wrong. In that case, look at the backed up
  # files for PATH.
  [System.Text.RegularExpressions.Regex]::Replace($machinePath, [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_.Replace(";;",";"), 'Machine')}
}

# Adapt for any services running in subfolders of ChocolateyInstall
$agentService = Get-Service -Name chocolatey-agent -ErrorAction SilentlyContinue
if ($agentService -and $agentService.Status -eq 'Running') { $agentService.Stop() }
# TODO: add other services here

# delete the contents (remove -WhatIf to actually remove)
# Remove-Item -Recurse -Force "$env:ChocolateyInstall" -WhatIf
Remove-Item -Recurse -Force "$env:ChocolateyInstall"

[System.Environment]::SetEnvironmentVariable("ChocolateyInstall", $null, 'User')
[System.Environment]::SetEnvironmentVariable("ChocolateyInstall", $null, 'Machine')
[System.Environment]::SetEnvironmentVariable("ChocolateyLastPathUpdate", $null, 'User')
[System.Environment]::SetEnvironmentVariable("ChocolateyLastPathUpdate", $null, 'Machine')

if ($env:ChocolateyToolsLocation) { Remove-Item -Recurse -Force "$env:ChocolateyToolsLocation" }
[System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'User')
[System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'Machine')
Write-Host "************************************************"