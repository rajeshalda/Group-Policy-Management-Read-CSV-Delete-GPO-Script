# 🚀 GPO Management PowerShell Script

This **PowerShell script** helps administrators easily manage Group Policy Objects (GPOs) in an Active Directory (AD) environment. With this tool, you can search for GPOs, delete them (if needed), and track every action through a log file. 🛠️

## ✨ Features

- 🔍 **Search for GPO**: Find GPOs by name using a CSV file as reference.
- ✅ **Verify GPO in AD**: Double-check if the GPO still exists in Active Directory before taking any action.
- 🗑️ **Delete GPO**: Delete a GPO after confirming, and log every deletion.
- 📝 **Action Logs**: Automatically logs every action (successes, failures, errors) to a log file for easy auditing.
- 🚫 **Handle Non-Existent GPOs**: Provides clear error messages if a GPO is not found.

## 🧰 Prerequisites

Make sure you have the following:

- **PowerShell** installed on your system.
- **Group Policy Module** loaded:
  
  If not installed, run this command to install the Group Policy Management Console:

  ```powershell
  Install-WindowsFeature -Name GPMC
  ```

- **Active Directory environment** with appropriate permissions to manage GPOs.

## 📂 Files

- **`GPO_Export.csv`**: CSV file containing details of GPOs (names, GUIDs, etc.). The script will search this file.
- **`GPO_Delete_Log.txt`**: Log file where every action (like GPO deletions) is recorded for auditing.

## 🚀 How to Use

1. **Export GPO Information**: First, export your GPO information into a CSV file with this PowerShell command:

   ```powershell
   Import-Module GroupPolicy
   Get-GPO -All | Select-Object DisplayName, Id, GpoStatus, Description, Owner, CreationTime, ModificationTime | 
       Export-Csv -Path C:\GPO_Export.csv -NoTypeInformation
   ```

2. **Run the Script**:
   - Open PowerShell as Administrator.
   - Run the script:

     ```powershell
     .\GPO_Management_Script.ps1
     ```

3. **Interactive GPO Management**:
   - Input the name of the GPO you want to manage.
   - The script will check both the CSV file and Active Directory.
   - If the GPO exists in AD, you’ll be prompted to delete it.
   - Logs of all actions will be saved automatically.

## 📝 Logs

Every action is logged in `GPO_Delete_Log.txt`, including:
- 🟢 **Successful deletions** of GPOs.
- 🛑 **Errors** if a GPO isn’t found in AD.
- 📛 Any **exceptions** that occur during the process.

Sample log entry:
```
2024-09-16 14:35:12 - GPO 'MyTestGPO' (GUID: abc12345-6789-abc1-2345-abc67890def1) deleted successfully.
2024-09-16 14:36:25 - GPO 'NonExistentGPO' does not exist in Active Directory.
```

## 🛠️ Customization

### Change the CSV File Path
Modify the `$csvFilePath` variable to point to your CSV file:

```powershell
$csvFilePath = "C:\Your\Path\To\GPO_Export.csv"
```

### Change the Log File Path
Update the `$logFilePath` variable to point to where you want the log file:

```powershell
$logFilePath = "C:\Your\Path\To\GPO_Delete_Log.txt"
```

## 🛑 Handling Errors

- The script checks if a GPO exists in **Active Directory** before attempting to delete it.
- If the GPO is in the CSV but not in AD, you'll see an error, and it will be logged.
- You can always refer to the `GPO_Delete_Log.txt` file for any issues or confirmation of actions.

## 🎯 Example Use Case

1. Run the script.
2. Search for `DemoGPO-1`.
3. Confirm whether you want to delete the GPO.
4. Watch the magic happen as the GPO is removed and a log entry is created! ✨

---

```bash
Enter the GPO name to search (or type 'exit' to quit): DemoGPO-1
GPO 'DemoGPO-1' found in AD. Do you want to delete it? (yes/no): yes
GPO 'DemoGPO-1' deleted successfully.
```

## 💡 Tips

- Always ensure that **GPO_Export.csv** is up-to-date before running the script to avoid discrepancies.
- If you’re testing, you can modify the `$logFilePath` to output the logs somewhere convenient.
- Use **`exit`** to stop the script anytime.

## 📜 License

This script is open-source and available for customization under the MIT License.

---

This script makes managing GPOs easier and more fun with interactive prompts and logging! Enjoy! 😎
