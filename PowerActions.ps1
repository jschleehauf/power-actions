# Author: Jarratt Schleehauf
# This PowerShell script allows a user with admin credentials to run Configuration Manager Actions
# on a specified machine that is connected to the domain.
# Last Edit: 01/10/2024 
# Version 2.0
# This version allows the user retry the computer name if entered incorrectly. Also indicates to the user
# If the command ran successfully.
 

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
# Change variable to false since execution successful.
$retry = $false




}
	catch {
		$ErrorMessage = $_.Exception.Message
		$retryCount++
		Write-Host "$retryCount retries, error occurred.  `n $ErrorMessage" -ForegroundColor Red -BackgroundColor Black
		
	}
} while ($retry)
Write-Host " Command Successful"

