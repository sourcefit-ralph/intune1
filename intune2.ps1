$hwidPath = "C:\HWID"
if (-not (Test-Path $hwidPath)) {
    New-Item -Type Directory -Path $hwidPath -Force
}
Set-Location -Path $hwidPath

 
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"

 
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force

 
if (-not (Get-Command Get-WindowsAutopilotInfo -ErrorAction SilentlyContinue)) {
    Install-Script -Name Get-WindowsAutopilotInfo -Force
}

 
$fullName = Read-Host "Enter Your Name"

 
$safeFileName = $fullName -replace "\s+", "_"
$outputFile = "$safeFileName`_AutopilotHWID.csv"
Get-WindowsAutopilotInfo -grouptag $env:computername -OutputFile $outputFile
$filePath = Join-Path -Path $hwidPath -ChildPath $outputFile
if (Test-Path $filePath) {
    Write-Output "`nAutopilot HWID report for $fullName saved at: $filePath"

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $notification = New-Object System.Windows.Forms.NotifyIcon
    $notification.Icon = [System.Drawing.SystemIcons]::Information
    $notification.BalloonTipTitle = "HWID File Saved"
    $notification.BalloonTipText = "Autopilot HWID report for $fullName has been successfully saved."
    $notification.BalloonTipIcon = "Info"
    $notification.Visible = $true
    $notification.ShowBalloonTip(5000) # Show notification for 5 seconds
} else {
    Write-Host "Failed to generate HWID file." -ForegroundColor Red
}
