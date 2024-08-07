#!/bin/bash

install_VPNdependencies() {
  if [ ! -f STCrequirements.txt ]; then
    echo "Error: 'VPNrequirements.txt' not found. Please re-install this repository or such file."
    return 1
  fi

  dependencies=$(cat VPNrequirements.txt)
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
    pip install -r VPNrequirements.txt
    sleep 1
    echo '
    done!'
    sleep 2
    clear
    echo "
How to run the software:
'cd src' - Go to dir
'chmod +x vpn_tui.py' - Make executable
'vpn_tui.py' - Run file
    
    "
  else
    echo "Installation cancelled."
  fi
}

install_STCdependencies() {
  if [ ! -f STCrequirements.txt ]; then
    echo "Error: 'STCrequirements.txt' not found. Please re-install this repository or such file."
    return 1
  fi

  dependencies=$(cat STCrequirements.txt)
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
    pip install -r STCrequirements.txt
    sleep 1
    echo '
    done!'
    sleep 2
    clear
    echo "
How to execute the software:
'cd src' - Go to dir
'menu.sh' - Execute
    
    "
  else
    echo "Installation cancelled."
  fi
}

banner() { #I got a plan for this banner design later
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
