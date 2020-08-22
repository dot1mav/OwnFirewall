#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "please run as root"
   exit 1
fi

echo "..........................................................."
echo "....install.python3.and.make.virtualenv.for.run.command...."
echo "..........................................................."


UNAME=$(uname)

if [ "$UNAME" == "Linux" ] ; then
  apt-get update &> /dev/null
  apt-get upgrade &> /dev/null
  apt-get install python3 python3-pip -y &> /dev/null
  python3 -m pip install pipenv &> /dev/null
  python3 -m pipenv check &> /dev/null
  python3 -m pipenv lock &> /dev/null
  python3 -m pipenv update &> /dev/null
  pythone -m pipenv install -r req.txt &> /dev/null
  clear

  python3 main.py
elif [ "$UNAME" == "Darwin" ] ; then
	echo "Darwin"
	echo "not supported"
	exit
elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
	echo "Windows"
	echo "not supported"
	exit
fi
