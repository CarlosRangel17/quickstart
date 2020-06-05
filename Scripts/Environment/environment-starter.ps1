param (
	[string]$orgprofile = "",
	[string]$advprofile = ""
)
 
Write-Host "************************************************"
echo "Starting environment installation process..."
Try
{
	#TODO: Remove stop command whenever all scripts are setup 
	# Start logging
	. "../utils/start-transcript"

	# Define variables 
	
	
	# Set the Remote-Signed policy 
	. "../utils/set-remote-signed-policy"
	
	# Run Chocolatey installation 
	. "../chocolatey/choco-install"
	
	# Set up the core environment packages 
	./environment-core-setup 
	
	# Set up (optional) organizational profile packages 
	if ($orgprofile)
	{
		echo "Organization profile flag detected..."
		switch ($orgprofile)
		{
			'Developer'   { ./environment-org-developer-setup }
			'QA'   { ./environment-org-qa-setup }
			# 'Test'   { echo "Install Test profile." }
			''   { echo "" }	 
		}
	}
	
	# Set up (optional) advanced profile packages 
	if ($advprofile)
	{
		echo "Advanced profile flag detected..."
		switch ($advprofile)
		{
			'Web'   { ./environment-adv-web-setup }
			'Mobile'   { ./environment-adv-mobile-setup }
			# 'Test'   { echo "Install Advanced profile: Test." }
			''   { echo "" }	 
		}
	}
	
	# Stop logging
	. "../utils/stop-transcript"
}
Catch
{
	# TODO: Write rollback process 
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript
    Break
}
