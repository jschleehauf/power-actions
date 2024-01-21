# Author: Jarratt Schleehauf
# Last Edit: 01/05/2024
# This PowerShell script allows a user with admin credentials to run Configuration Manager Actions
# on a specified machine that is connected to the domain. 
# Version 1
# This version wraps the code in a try and catch block for error handling.

# set variable for errors
$retry


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
Invoke-Command -ComputerName $computerName -ScriptBlock $actions

# Change variable to false since execution successful.
$retry = false
}
	catch {
		$retryCount++
	}
} while ($retry)
