#!/bin/bash

ROOT="/etc"
LSB_FILE="lsb-release"
DISTRIB_SUFFIX="release"
DEBIAN_FILE="/etc/debian_version"
DEBIAN_NAME="Debian"
FILENAME="/etc/os-release"
UNAME=""

PYTHON_PKG="python3 python3-pip"

# FUNCTIONS
db_install(){
	apt-get update &> /dev/null
	apt-get upgrade -y &> /dev/null
	apt-get install $PYTHON_PKG -y &> /dev/null
}

getDistroName(){
	if [[ -f $FILENAME ]] ; then
		DISTRO=$(head -1  $FILENAME | cut -f 2 -d '"')
		DISTRO=${DISTRO/Linux/}
	else
		FILENAME="/etc/redhat-release"
        	if [[ ! -f $FILENAME ]] ; then
			FILENAME=$(find $ROOT/ -maxdepth 1      \
				-name \*$DISTRIB_SUFFIX         \
				-and ! -name $LSB_FILE          \
				-and -type f    2> /dev/null    \
				| head -1 )
	        fi
		if [[ -z  $FILENAME ]] ; then
			if [[ -f "$DEBIAN_FILE" ]] ; then
				DISTRO=$DEBIAN_NAME
			else
				echo "Unable to find your distro"
			fi
		else
			CONTENT=$(head -1 $FILENAME 2> /dev/null)
			DISTRO=$(echo $CONTENT | sed \
				-e "s/[[:blank:]][Ll][Ii][Nn][Uu][Xx][[:blank:]]/ /g" \
				-e "s/\(.*\)[[:blank:]]release.*/\1/" \
				-e "s/[[:blank:]]/ /g" )
		fi
	fi
}

install(){
	getDistroName

	if [ $DISTRO == "Mint" ] || [ $DISTRO == "Debian" ] || [ $DISTRO == "Ubintu" ] ; then
		echo "Debian Distro :)"
		db_install
	elif [ $DISTRO == "Arch" ] || [ $DISTRO == "ManjaroLinux" ] ; then
		echo "Arch Base Distro :)"
	elif [ $DISTRO == "CentOS" ] || [ $DISTRO == "Fedora" ] || [ $DISTRO == "rhel" ] ; then
		echo "Redhat Distro :)"
	else
		echo $DISTRO
		echo "Your distro is not supported :("
		exit
	fi

	python3 -m pip install pipenv &> /dev/null
	python3 -m pipenv check &> /dev/null
	python3 -m pipenv lock &> /dev/null
	python3 -m pipenv update &> /dev/null
	pythone -m pipenv install -r req.txt &> /dev/null
	clear


	python3 -m pipenv run python3 main.py
}

main(){

	if [[ $EUID -ne 0 ]]; then
	   echo "please run as root"
	   exit 1
	fi

	UNAME=$(uname)

	if [ $UNAME == "Linux" ] ; then
		install
	elif [ $UNAME == "Darwin" ] ; then
		echo "you use Darwin and this os not supported"
		exit
	elif [ $UNAME == CYGWIN* ] || [ $UNAME == MINGW* ] ; then
		echo "you use Windows and this os not supported"
		exit
	fi
}

##############################################################

main
