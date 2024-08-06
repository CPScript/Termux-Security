#!/bin/bash

install_VPNdependencies() {
  if [ ! -f requirements.txt ]; then
    echo "Error: 'requirements.txt' not found. Please re-install this repository!"
    return 1
  fi

  dependencies=$(cat requirements.txt)
  clear # clear everything
  echo "The following dependencies will be installed:"
  echo "$dependencies"
  read -p "Please confirm installation (y/n) " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo 'updating!'
    sleep 2
    pkg update
    pkg upgrade
    echo '
    installing python'
    sleep 2
    pkg install python
    echo '
    installing requirements'
    sleep 2
    pip install -r requirements.txt
    sleep 1
    echo '
    done!'
    sleep 2
    clear
    echo "
How to run the software:
'cd vpn' - Go to dir
'chmod +x vpn_tui.py' - Make executable
'vpn_tui.py' - Run file
    
    "
  else
    echo "Installation cancelled."
  fi
}

install_STCdependencies() {
clear
echo 'still being set up!'
}

banner() { #I got a ppan for this banner design later
echo "
banner here!
[1] Install VPN dependencies
[2] Install Static dependencies
[3] place holder!
"
}

banner
read -p "Please type number" -n 1 -r
  if [[ $REPLY =~ ^[1]$ ]]; then
    clear
    install_VPNdependencies # call 
  elif [[ $REPLY =~ ^[2]$ ]]; then
    clear
    install_STCdependencies # call 
  else
    echo "err"
  fi
