# Start transcript based off current date (MMddyyyy)
Try
{
	$Datestamp = get-date -format 'MMddyyyy'
	start-transcript -path C:/projects/power-shell/transcripts/environment-core-setup-$Datestamp
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName 
	#TODO: Write log file to add error message 
	# call .\stop-transcript <?>
    Break
}

