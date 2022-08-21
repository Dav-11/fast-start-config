<#
Title: JunkRemover
Description: Script for uninstalling Bloatware
Date: 2021-04-24
Last Modified: 2021-04-25
#>

#Get-appxpackage -allusers *windowsalarms* | Remove-AppxPackage

# Turn all errors in stopping errors
$ErrorActionPreference = "Stop" 

# Title
Set-Variable title -Value "Junk uninstaller"

# Path to xml file
$currentFolder = split-path $MyInvocation.MyCommand.Path
$xml = "$currentFolder\junkDescriptor.xml"


Write-Output $title

Try{

    # Read the structs from the xml file
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Opening File: $xml"
    [xml]$junkAll = get-content $xml

    # Extract the names of the programs set to true
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] getting selected programs names..."
    $junkToRemove = $junkAll.Junk.program | Where-Object {$_.active -match "True"}
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] got this names:"
    ForEach ($junk in $junkToRemove){

        Write-Output "`t$($junk.name)"
    }

    # Uninstall the found packages
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Removing Programs..."
    ForEach ($junk in $junkToRemove){

        # get the real program from the installed app list
        $realApp = Get-AppxPackage | Where-Object { $_.Name -like "$($junk.name)"}

        if ($null -eq $realApp) {
            
            # if the realApp var is null => the program is not installed
            Write-Output "[$(Get-Date -Format "HH:mm:ss")] Packet w/ name: $($junk.name) not Found"
        } else {
            
            # remove the app
            Get-appxpackage -allusers "$($realApp.Name)" | Remove-AppxPackage 
            Write-Output "[$(Get-Date -Format "HH:mm:ss")] Packet w/ name: $($junk.name) removed :)"
        }
    }

} Catch {

    Write-Output "[$(Get-Date -Format "HH:mm:ss")]An Error Occurred : $error" 
}

Write-Output "[$(Get-Date -Format "HH:mm:ss")] Script Ended, have a Nice day !"
