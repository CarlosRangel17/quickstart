Write-Host "************************************************"
echo "Starting environment teardown process!"

echo "Checking for Chocolatey installation..."
$ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}

if (!$ChocoInstalled) {
  Write-Warning "The ChocolateyInstall environment variable was not found. \n Chocolatey is not detected as installed. Nothing to do"
  return
}

echo "Proceeding with removing chocolatey packages..."
echo "TODO: Not implemented yet..."