#!/bin/bash
mv /root/.ownfirewall/.iptables.save /root/.iptables.save~
iptables-save > /etc/.iptables.save
iptables-save > /root/.ownfirewall/.iptables.save