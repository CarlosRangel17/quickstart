# Install Advanced profiles packages for Mobile tech stack using Chocolatey 
Try
{
	#TODO: Write logic 
	echo "Installing Mobile packages! (Not really)"
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript <?>
    Break
}
