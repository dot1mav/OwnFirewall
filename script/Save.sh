#!/bin/bash
mv /root/.iptables.save /root/.iptables.save.backup
mv /home/.iptables.save /home/.iptables.save.backup
iptables-save > /Firewall/iptables
iptables-save > /Firewall/iptables-2
iptables-save > /home/.iptables.save
iptables-save > /root/.iptables.save
iptables-save > /.iptables.save