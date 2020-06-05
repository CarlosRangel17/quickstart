# Install core environment packages using Chocolatey a
Try
{
	#TODO: Write logic 
	echo "Writing Core packages! (Not really)"
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript <?>
    Break
}
