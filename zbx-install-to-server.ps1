#set variables
$path = "C:\Temp\Zabbix\"
$msi = "zabbix.msi"
$ZabbixServerIPAddress = "10.10.100.30"
$ListenPort = "10050"

#create dir, download and install
mkdir $path
Set-Location $path
Invoke-WebRequest -Uri https://cdn.zabbix.com/zabbix/binaries/stable/5.2/5.2.5/zabbix_agent-5.2.5-windows-amd64-openssl.msi -OutFile ($path + $msi)
msiexec /i $msi /qn /norestart HOSTNAME=hostname HOSTNAMEFQDN=1 SERVER=$ZabbixServerIPAddress LPORT=$ListenPort SERVERACTIVE=$ZabbixServerIPAddress RMTCMD=1

#config firewall rules
netsh advfirewall firewall add rule name="Zabbix Agent" dir=in action=allow protocol=TCP localport=10050
netsh advfirewall firewall add rule name="Zabbix Agent" dir=out action=allow protocol=TCP localport=10050
netsh advfirewall firewall add rule name="Zabbix Agent" dir=in action=allow protocol=UDP localport=10050
netsh advfirewall firewall add rule name="Zabbix Agent" dir=out action=allow protocol=UDP localport=10050