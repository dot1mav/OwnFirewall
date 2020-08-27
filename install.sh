#!/bin/bash

ROOT="/etc"
LSB_FILE="lsb-release"
DISTRIB_SUFFIX="release"
DEBIAN_FILE="/etc/debian_version"
DEBIAN_NAME="Debian"
FILENAME="/etc/os-release"
UNAME=""

# FUNCTIONS

getDistroName(){
        if [[ -z  "$FILENAME" ]] ; then
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
}

findDistro(){
	if [[ -f "$FILENAME" ]] ; then
		DISTRO=$(head -1  /etc/os-release | cut -f 2 -d '"' | cut -f 1 -d ' ')
	else
		FILENAME="/etc/redhat-release"
        	if [[ ! -f "$FILENAME" ]] ; then
			FILENAME=$(find $ROOT/ -maxdepth 1      \
				-name \*$DISTRIB_SUFFIX         \
				-and ! -name $LSB_FILE          \
				-and -type f    2> /dev/null    \
				| head -1 )
	        fi
        	getDistroName $FILENAME
	fi
}

install(){
	findDistro
	if [[ "$DISTRO" == "Linuxmint" || "$DISTRO" == "Debian" || "$DISTRO" == "Ubuntu" ]]
	then
		echo "Debian Distro :)"
	elif [[ "$DISTRO" == "Arch" || "$DISTRO" == "ManjaroLinux" ]] ; then
		echo "Arch Base Distro :)"
	elif [[ "$DISTRO" == "CentOS" || "$DISTRO" == "Fedora" || "$DISTRO" == "rhel" ]] ; then
		echo "Redhat Distro :)"
	else
		echo $DISTRO
		echo "Your distro is not supported :("
	fi
}

main(){

	if [[ $EUID -ne 0 ]]; then
	   echo "please run as root"
	   exit 1
	fi

	UNAME=$(uname)

	if [ "$UNAME" == "Linux" ] ; then
		install
	elif [ "$UNAME" == "Darwin" ] ; then
		echo "you use Darwin and this os not supported"
		exit
	elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
		echo "you use Windows and this os not supported"
		exit
	fi
}

##############################################################

main
