:local LocalHostName [/system identity get name]
:local UsedCPU [/system resource get cpu-load]
:local FreeCPU (100 - $UsedCPU)
:local FreeRam ((100 * [/system resource get free-memory]) / [/system resource get total-memory])
:local UsedRam (100 - $FreeRam)
:local Date [/system clock get date]
:local Time [/system clock get time]
:local Domain "smtp.163.com"
:local Port "25"
:local User "from@163.com"
:local PassWord "password"
:local ToUser "to@163.com"
:local FromUser "from@163.com"
:local Subject ("$LocalHostName Reboot")
:local Message ("$Date $Time $LocalHostName free memory is less than $FreeRam%, has been reboot")
:local Host [:resolve $Domain]

:if ($FreeRam < 10 or $FreeCPU < 10 ) do={
  /tool e-mail set address=$Host port=$Port from=$FromUser user=$User password=$PassWord
  /tool e-mail send to=$ToUser from=$FromUser subject=$Subject body=$Message
  /system reboot
} else={
  /log warning "CPU is already in use $UsedCPU% , Memory is already in use $UsedRam%"
}
