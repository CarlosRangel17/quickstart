Write-Host "************************************************"
echo "Starting environment installation process..."

# "Check Chocolatey installation"
$ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}

Write-Host "> Checking for Chocolatey installation..."
if ($ChocoInstalled) 
{
	Write-Host "> Chocolately installation detected..."
	Write-Host "> Checking for chocolatey upgrade..."
	choco upgrade chocolatey

	Write-Host "************************************************"
}
else 
{
	Write-Host "> Starting installation with powershesll..."
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

	Write-Host "Finished installation of chocolatey"  
	Write-Host "************************************************"
	return
}
