🚀 GPO Management PowerShell Script
This PowerShell script helps administrators easily manage Group Policy Objects (GPOs) in an Active Directory (AD) environment. With this tool, you can search for GPOs, delete them (if needed), and track every action through a log file. 🛠️

✨ Features
🔍 Search for GPO: Find GPOs by name using a CSV file as reference.
✅ Verify GPO in AD: Double-check if the GPO still exists in Active Directory before taking any action.
🗑️ Delete GPO: Delete a GPO after confirming, and log every deletion.
📝 Action Logs: Automatically logs every action (successes, failures, errors) to a log file for easy auditing.
🚫 Handle Non-Existent GPOs: Provides clear error messages if a GPO is not found.
🧰 Prerequisites
Make sure you have the following:

PowerShell installed on your system.

Group Policy Module loaded:

If not installed, run this command to install the Group Policy Management Console:

Install-WindowsFeature -Name GPMC

Active Directory environment with appropriate permissions to manage GPOs.

