# Install Developer environment packages using Chocolatey
Try
{
	#TODO: Write logic 
	echo "Installing Developer packages! (Not really)"
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript <?>
    Break
}
