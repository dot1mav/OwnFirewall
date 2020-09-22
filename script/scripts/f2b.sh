#!/bin/bash

apt-get update &> /dev/null
apt-get upgrade -y &> /dev/null
apt-get install fail2ban -y &> /dev/null