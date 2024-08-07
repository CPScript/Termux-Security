#!/bin/bash

install_dependencies() {
  if [ ! -f requirements.txt ]; then
    echo "Error: 'requirements.txt' not found. Please re-install this repository or such file."
    return 1
  fi

  dependencies=$(cat requirements.txt)
  clear # clear everything
  echo "The following dependencies will be installed:"
  echo "$dependencies"
  echo ""
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
    echo "Finished installing dependancies"
    echo "If there were any errors, please make an issue at https://github.com/CPScript/Termux-Sec"
    echo ""
    read -p "Back to Menu? (y/n): " rmenu
    if [ "$rmenu" = "y" ]; then
      mainloop
    else
      break
    fi
    
  elif [[ $REPLY =~ ^[Nn]$ ]]; then
    clear
    echo "Installation cancelled." 
    
  else
    echo "err: Please type Y/y or N/n"
    echo "Please try again."
  fi
}

banner() { #I got a plan for this banner design later
echo "
banner here!
[1] Install dependencies
[2] Execute Software
[3] place holder!
"
}

mainloop() {
banner
echo -e '┌─[number] - [User-Input]'
read -p "└─────> " -n 1 -r
  if [[ $REPLY =~ ^[1]$ ]]; then
    clear
    install_dependencies # call 
  elif [[ $REPLY =~ ^[2]$ ]]; then
    echo 'works'
    sleep 0.5
    cd ~/Android-stuff/src && menu.sh
  else
    clear
    echo "err: Please type a number."
  fi
}

mainloop
