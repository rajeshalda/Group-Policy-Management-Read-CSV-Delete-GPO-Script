# Import the Group Policy module
Import-Module GroupPolicy

# Define the paths for the CSV file and log file
$csvFilePath = "C:\GPO_Export.csv"
$logFilePath = "C:\GPO_Delete_Log.txt"

# Read the CSV file
$gpoList = Import-Csv -Path $csvFilePath

# Function to log messages
function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Add-Content -Path $logFilePath -Value $logEntry
}

# Main loop to search and delete GPOs
while ($true) {
    # Ask the user to input a GPO name
    $gpoName = Read-Host "Enter the GPO name to search (or type 'exit' to quit)"

    # Allow the user to exit the loop
    if ($gpoName -eq 'exit') {
        break
    }

    # Check if the GPO exists in the CSV list
    $gpo = $gpoList | Where-Object { $_.DisplayName -eq $gpoName }

    if ($gpo) {
        # Before proceeding, check if the GPO still exists in Active Directory
        $adGpo = Get-GPO -Name $gpoName -ErrorAction SilentlyContinue

        if ($adGpo) {
            # If GPO is found in AD, ask for confirmation to delete
            $confirmation = Read-Host "GPO '$gpoName' found in AD. Do you want to delete it? (yes/no)"

            if ($confirmation -eq 'yes') {
                try {
                    # Attempt to delete the GPO using its GUID
                    Remove-GPO -Guid $gpo.Id -Confirm:$false
                    
                    # Log the deletion action
                    Write-Log "GPO '$gpoName' (GUID: $($gpo.Id)) deleted successfully."
                    Write-Host "GPO '$gpoName' deleted successfully."
                }
                catch {
                    # Log and display any error that occurs during deletion
                    Write-Log "Error deleting GPO '$gpoName': $_"
                    Write-Host "Error deleting GPO: $_"
                }
            }
            else {
                # If user chooses not to delete, just continue
                Write-Host "GPO '$gpoName' not deleted."
            }
        }
        else {
            # If the GPO is no longer found in Active Directory
            Write-Host "Error: GPO '$gpoName' does not exist in Active Directory."
            Write-Log "GPO '$gpoName' was found in CSV but does not exist in Active Directory."
        }
    }
    else {
        # If GPO is not found in the CSV file
        Write-Host "Error: GPO '$gpoName' does not exist in the CSV file."
        Write-Log "GPO '$gpoName' does not exist in CSV."
    }
}
