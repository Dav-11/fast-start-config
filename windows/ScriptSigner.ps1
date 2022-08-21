<#
Title: ScriptSigner
Description: Script for Signing script
Date: 2021-04-24
Last Modified: 2021-04-24
#>

# Turn all errors in stopping errors
$ErrorActionPreference = "Stop"

# Title
Set-Variable Title -Value "ScriptSigner"

# Script Path
$CurrentFolder = split-path $MyInvocation.MyCommand.Path
Set-Variable ScriptPath -Value "$CurrentFolder.\ActiveDirectoryInstaller.ps1"


WriteWrite-Output $Title
Write-Output "[$(Get-Date -Format "HH:mm:ss")] Signing the File @ this path: $ScriptPath"

try{
    $cert=(dir cert:currentuser\my\ -CodeSigningCert)
    Set-AuthenticodeSignature "$ScriptPath" $cert -TimestampServer http://tsa.starfieldtech.com
    Write-Output "[$(Get-Date -Format "HH:mm:ss")] End, Have a nice Day! :)"

}catch {
    Write-Output "[$(Get-Date -Format "HH:mm:ss")]An Error Occurred : $error"

}
