<powershell>
Start-Transcript -Path C:\Windows\Temp\Computer.log
$logfile = "C:\Windows\Temp\userdata.log"
Write-Output "Adding User to Administrator"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
cmd /c net user /add "tempUser" "Qwerty@123#"
cmd /c net localgroup administrators "tempUser" /add
Stop-Transcript
</powershell>
<persist>true</persist>