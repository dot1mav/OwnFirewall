#!/bin/bash
sudo apt update &> /dev/null
sudo apt upgrade -y &> /dev/null
sudo apt install portsentry -y &> /dev/null