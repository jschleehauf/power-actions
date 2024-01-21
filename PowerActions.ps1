# Author: Jarratt Schleehauf
# This PowerShell script allows a user with admin credentials to run Configuration Manager Actions
# on a specified machine that is connected to the domain.
# Last Edit: 01/10/2024 
# Version 3.0
# This version prompts the user if they want to run the command on another computer or exit the script.
 

# set variable for errors
$retry = $true
$retrycount = 0


do {
	try {
# Prompt the user for the computer name
$computerName = Read-Host "Enter the computer name"


# store all the actions to run
$actions = 
{

#Application Deployment Evaluation Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}" 

#Discovery Data Collection Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000003}"

#Hardware Inventory Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}"

#Machine Policy Retrieval Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000021}"

#Machine Policy Evaluation Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000022}"

#Software Updates Deployment Evaluation Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000114}"

#Software Updates Scan Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000113}"

#Windows Installer Source List Update Cycle
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000032}"

}

# Run the actions on the specified computer
Invoke-Command -ComputerName $computerName -ScriptBlock $actions -ErrorAction Stop


# Inform user the command executed successfully.
Write-Host " Command Successful"

#Prompt the user to determine if they want to exit or run command on another machine.
$UserSelection = Read-Host "Enter 0 to exit or 1 to run the command on another computer."


if ($UserSelection -eq 0) {
	$retry = $false
}
write-host "$UserSelection"
} catch {
		$ErrorMessage = $_.Exception.Message
		$retryCount++
		Write-Host "$retryCount retries, error occurred.  `n $ErrorMessage" 
		
	}
} while ($retry)


