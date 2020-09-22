#!/bin/bash
clear

echo "..........................................."
echo "..........................................."
echo "..........................................."
echo "..............Config Firewall.............."
echo ".................4 Server.................."
echo "..........................................."
echo "..........................................."
echo ".................By dot1mav................"
echo "..........................................."
echo "..........................................."
echo "..........................................."

echo "Server IP : "
read ipserver
echo "api and http and ssh configed"
echo "Number of port you need (internet) : "
read Number
for (( i=0; i<${Number}; i++ ));
do
echo "Ports $i : "
read Port[$i]
done
echo "Number of port you need (local) : "
read Numberlocal
for (( i=0; i<${Numberlocal}; i++ ));
do
echo "Ports $i : "
read Portlocal[$i]
done





clear
echo ".........................................................."
echo ".........................................................."
echo "..................Configuration Firewall.................."
echo ".........................................................."
echo ".........................................................."
echo "Write Log By Comment :FirewallV1:"
iptables -N log
iptables -A log -j LOG --log-level 6 --log-prefix ':FirewallV1:'
iptables -A log -j DROP
echo ".........................................................."
echo "deny Spoofing Attack"
iptables -A INPUT -i eth0 -s 127.0.0.0/8 -j DROP
iptables -A INPUT -s 224.0.0.0/4 -j DROP
iptables -A INPUT -d 224.0.0.0/4 -j DROP
iptables -A INPUT -s 240.0.0.0/5 -j DROP
iptables -A INPUT -d 240.0.0.0/5 -j DROP
iptables -A INPUT -s 0.0.0.0/8 -j DROP
iptables -A INPUT -d 0.0.0.0/8 -j DROP
iptables -A INPUT -d 239.255.255.0/24 -j DROP
iptables -A INPUT -d 255.255.255.255 -j DROP
echo ".........................................................."
echo "deny Drop excessive RST packets to avoid smurf attacks"
iptables -A INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT
echo ".........................................................."
echo "deny PortScanner"
iptables -A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK -m state --state NEW -j DROP 
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP 
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP 
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP 
iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP 
iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j DROP 
iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j DROP 
iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j DROP 
iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
echo ".........................................................."
echo "Stop smurf attacks"
iptables -A INPUT -p icmp -m icmp --icmp-type address-mask-request -j DROP
iptables -A INPUT -p icmp -m icmp --icmp-type timestamp-request -j DROP
iptables -A INPUT -p icmp -m icmp -j DROP
echo ".........................................................."
echo "Drop all invalid packets"
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A FORWARD -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP
echo ".........................................................."
echo "deny LAND Attack"
iptables -A INPUT -s $ipserver -j DROP
iptables -A INPUT -s localhost -j DROP
iptables -A INPUT -s 127.0.0.0/8 -j DROP
echo ".........................................................."
echo " open localports need "
for l in ${Portlocal[*]}; do
iptables -A INPUT -s localhost -p tcp --dport $l -j ACCEPT
iptables -A OUTPUT -s localhost -p tcp --source-port $l -j ACCEPT  
done
echo ".........................................................."
echo "Change SSH Port to 7779"
iptables -A INPUT -p tcp --dport 22 -j log
iptables -A INPUT -p tcp --sport 22 -j log
iptables -A INPUT -p tcp -m state --state NEW --dport 7779 -m recent --set -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW --dport 7779 -m recent --update --seconds 120 --hitcount 2 -j DROP
iptables -A INPUT -p tcp --dport 7779 -j ACCEPT
iptables -A OUTPUT -p tcp --source-port 7779 -j ACCEPT
echo ".........................................................."
echo "API Firewall config"
iptables -A INPUT -p tcp --dport 8000 -i eth0 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 8000 -i eth0 -m state --state NEW -m recent --update --seconds 5 --hitcount 10 -j DROP
iptables -A INPUT -p tcp --dport 8000 -j ACCEPT
iptables -A OUTPUT -p tcp --source-port 8000 -j ACCEPT
echo ".........................................................."
echo "http config"
iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --update --seconds 20 -j DROP
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --source-port 80 -j ACCEPT
echo ".........................................................."
echo "deny DDOS Attack"
for j in ${Port[*]}; do
iptables -A INPUT -p tcp --dport $j -i eth0 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport $j -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
iptables -A INPUT -p tcp --dport $j -j ACCEPT
iptables -A OUTPUT -p tcp --source-port $j -j ACCEPT  
done
echo ".........................................................."
echo "open port for backup"
iptables -A INPUT -p tcp --source-port 7779 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 7779 -j ACCEPT  
echo ".........................................................."
echo "End Config"
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
iptables -A FORWARD -j DROP
echo ".........................................................."
clear
."