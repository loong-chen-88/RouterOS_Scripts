:do {
:local USE "root"
:local PWD "password"
:local DOMAIN "example.f3322.net"
:local RemoteIP [:resolve $DOMAIN]
:log warning ("RemoteIP:".$RemoteIP)
:delay 5s
:local LocalIP [ /ip address get [/ip address find interface="pppoe-out1" ] address ]
:set LocalIP [:pick $LocalIP 0 [:find $LocalIP "/"]]
:log warning ("LocalIP:".$LocalIP)
:if ($RemoteIP != $LocalIP) do={
/tool fetch url=("http://members.3322.net/dyndns/update\?hostname=$DOMAIN&myip=$LocalIP") mode=http user=$USE password=$PWD dst-path=$DOMAIN
:delay 3s
:local Result [/file get $DOMAIN contents]
:if ([:find $Result "good"] != "nil") do={
:log warning ($DOMAIN."update success")
} else={
:log warning ($DOMAIN."Update failed")}
/file remove $DOMAIN}}

######################################
#如果PPPOE-OUT1掉线状态则更新PPPOE-OUT2#
######################################
:do {
:local ether
:local USE "root"
:local PWD "password"
:local DOMAIN "example.f3322.net"
:local RemoteIP [:resolve $DOMAIN]
:log warning ("RemoteIP:".$RemoteIP)
:local status [/interface pppoe-client get [/interface pppoe-client find name="pppoe-out1"] running];
:if ($status=true) do={
:set ether "pppoe-out1"};
:if ($status=false) do={
:set ether "pppoe-out2"};
:delay 5s
:local LocalIP [ /ip address get [/ip address find interface="pppoe-out1" ] address ]
:set LocalIP [:pick $LocalIP 0 [:find $LocalIP "/"]]
:log warning ("LocalIP:".$LocalIP)
:if ($RemoteIP != $LocalIP) do={
/tool fetch url=("http://members.3322.net/dyndns/update\?hostname=$DOMAIN&myip=$LocalIP") mode=http user=$USE password=$PWD dst-path=$DOMAIN
:delay 3s
:local Result [/file get $DOMAIN contents]
:if ([:find $Result "good"] != "nil") do={
:log warning ($DOMAIN."update success")
} else={
:log warning ($DOMAIN."Update failed")}
/file remove $DOMAIN}}