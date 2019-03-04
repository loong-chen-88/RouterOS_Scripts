:local LocalHostName [/system identity get name]
:local InstalledVersion [/system package update get installed-version]
:local LatestVersion [/system package update get latest-version]
:local Time [/system clock get time]
:local Date [/system clock get date]
:local Day [:pick $Date 4 6]
:local Month [:pick $Date 0 3]
:local Year [:pick $Date 7 11]
:local Mon ([:find jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec [:pick $Date 0 3]]+1);
:if ($Mon <=9) do={
:set Mon ("0".$Mon)}
/log warning "$Mon"
:local FileName ("$LocalHostName $Year$Mon$Day");
/system backup save name=$FileName
/log warning "Backup was successful"
:local Domain "smtp.163.com"
:local Port "25"
:local User "from@163.com"
:local PassWord "password"
:local ToUser "to@163.com"
:local FromUser "from@163.com"
:local Subject ("$Date $Time $LocalHostName Auto backup")
:local Message ("$Date $Time $LocalHostName automatic backup is successful, the current firmware version of the system is $InstalledVersion, the latest version is $LatestVersion")
:local Host [:resolve $Domain]
/tool e-mail set address=$Host port=$Port from=$FromUser user=$User password=$PassWord
/tool e-mail send to=$ToUser from=$FromUser subject=$Subject body=$Message file=$FileName
/log warning "backup file sent to $ToUser"