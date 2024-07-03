# Invoke-RestMethod -Uri https://link.sourcefit.info/intune1 | Invoke-Expression

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
Install-Script -Name Get-WindowsAutopilotInfo -Force

$pcName = Read-Host -Prompt "Enter the PC name"
Get-WindowsAutopilotInfo -Online -grouptag $pcName

