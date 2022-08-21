<#
Title: RSATinstaller.ps1
Description: Script for installing RSAT (Active Directory)
Date: 2021-04-24
Last Modified: 2021-04-24
#>

# Turn all errors in stopping errors
$ErrorActionPreference = "Stop" 

# Title
Set-Variable title -Value "RSAT Installer"

# PATH to "UseWUServer" registry Key
Set-Variable regPath -Value "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
Set-Variable regEntryName -Value "UseWUServer"

# Windows Update Service Name
Set-Variable windowsUpdateService -Value "Windows Update"

# Package name to install
Set-Variable lookupName -Value "Rsat.*"
Set-Variable packageName -Value "Rsat.ActiveDirectory.DS-LDS.Tools~*"

Write-Output $title 

Try{

    # set registry key to 0 (off)
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Setting registry key to 0..." 
    Set-ItemProperty -Path $regPath -Name $regEntryName -Value 0   
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End" 

    # restart Windows update service
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Restarting Services..." 
    Restart-Service -Name $windowsUpdateService   
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End" 

    # print the matching features
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Found this Packets: " 
    Get-WindowsCapability -Online | Where-Object {$_.Name -like "*$lookupName*"}
    
    # Get list of Matching Packets
    $existingMatchingFeatures = Get-WindowsCapability -Online | Where-Object {$_.Name -like "*$lookupName*"}

    ForEach ($Feature in $existingMatchingFeatures){

        Write-Output "[$(Get-Date -Format "HH:mm:ss")] Installing Packet: $($Feature.Name)"

        if ($Feature.State -eq "NotPresent") {
            
            # Actually install the feature
            Add-WindowsCapability -Online -Name $Feature.Name
            Write-Output "[$(Get-Date -Format "HH:mm:ss")] Packet: $($Feature.Name) Installed :)"

        } else {
            
            Write-Output "[$(Get-Date -Format "HH:mm:ss")] Packet: $($Feature.Name) Already Installed"
        }
    }

    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End" 


    # Restore registry Key
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Setting registry key to 1..." 
    Set-ItemProperty -Path $regPath -Name $regEntryName -Value 1   
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End" 

    # restart Windows update service
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] Restarting Services..." 
    Restart-Service -Name $windowsUpdateService   
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End" 

} Catch {

    Write-Output "[$(Get-Date -Format "HH:mm:ss")]An Error Occurred : $error" 
}

# Disabling Variables
Remove-Variable regPath
Remove-Variable regEntryName
Write-Output "[$(Get-Date -Format "HH:mm:ss")] EndScript, Have a nice Day!" 
