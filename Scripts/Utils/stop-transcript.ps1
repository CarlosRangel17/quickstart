# Stop transcript based off current date (MMddyyyy)
Try
{
	$Datestamp = get-date -format 'MMddyyyy'
	stop-transcript
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript <?>
    Break
}

