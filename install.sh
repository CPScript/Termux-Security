#!/bin/bash

install_dependencies() {
  if [ ! -f requirements.txt ]; then
    echo "Error: 'requirements.txt' not found. Please re-install this repository!"
    return 1
  fi

  dependencies=$(cat requirements.txt)

  echo "The following dependencies will be installed:"
  echo "$dependencies"
  read -p "Do you want to install them? (y/n) " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo 'updating!'
    sleep 2
    pkg update
    pkg upgrade
    clr
    echo 'installing python'
    sleep 2
    pkg install python
    clr
    echo 'installing requirements'
    sleep 2
    pip install -r requirements.txt
    sleep 1
    echo "You may now type these commands to run the software:
    'cd vpn'
    'python run.py'
    "
  else
    echo "Installation cancelled."
  fi
}

install_dependencies