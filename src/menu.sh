#!/bin/bash

dir_check() {
  echo 'Directory switched to:' "$(pwd)"
  sleep 0.25
  clear
}

banner() {
  echo "===============================
Simple Termux Security Software
By - CPScript on GitHub
--------|TERMUX ONLY|----------
[1] Start vpn
[2] Start Static
-
[3] not in use
[4] not in use
-
[k] Kill (Force stop running script)
[0] Back
[e] Exit
"
}

back_func() {
  cd ~/ # return home
  cd ~/Termux-Sec && bash install.sh # change back and re-run install.sh
  # should do a directory check when 'install.sh' is ran
}

menu() {
  banner
  echo -e '┌─[number] - [User-Input]'
  read -p "└─────> " -n 1 -r

  if [[ $REPLY =~ ^[1]$ ]]; then
    echo "Starting vpn"
  elif [[ $REPLY =~ ^[2]$ ]]; then
    echo "Starting Static"
  elif [[ $REPLY =~ ^[3]$ ]]; then
    echo '3 works, not in use'
  elif [[ $REPLY =~ ^[4]$ ]]; then
    echo '4 works, not in use'

  elif [[ $REPLY =~ ^[k]$ ]]; then
    clear
    echo "
Please select what to stop:
[1] VPN
[2] Static Generator
    "
    read -p "Enter your choice: " rmenu
    if [ "$rmenu" = "1" ]; then
      process_name="vpn.py"
      PID=$(pgrep -f "$process_name")
      if [ -n "$PID" ]; then
        echo "Attempting to stop: $process_name (PID: $PID)."
        kill $PID
        sleep 2
        if pgrep -f "$process_name" > /dev/null; then
          echo "$process_name is being a lil bitch. Attempting to force kill"
          kill -9 $PID
        else
          echo "$process_name stopped successfully."
        fi
      else
        echo "Process $process_name not found."
      fi
    elif [ "$rmenu" = "2" ]; then
      process_name="static.sh"
      PID=$(pgrep -f "$process_name")
      if [ -n "$PID" ]; then
        echo "Attempting to stop: $process_name (PID: $PID)."
        kill $PID
        sleep 2
        if pgrep -f "$process_name" > /dev/null; then
          echo "$process_name is being a lil bitch. Attempting to force kill"
          kill -9 $PID
        else
          echo "$process_name stopped successfully."
        fi
      else
        echo "Process $process_name not found."
      fi
    fi
    read -p "Return to menu? (y/press enter to cancel): " response
    if [ "$response" = "y" ]; then
      menu
    else
      continue
    fi

  elif [[ $REPLY =~ ^[0]$ ]]; then
    echo ""
    read -p "Back to Installation menu? (y/enter to cancel): " rmenu
    if [ "$rmenu" = "y" ]; then
      back_func
    else
      continue
    fi

  elif [[ $REPLY =~ ^[e]$ ]]; then
    clear
    echo "Exiting and Returning"
    sleep 2
    clear
    cd ~/
    exit

  else
    clear
    echo "err: Please type a number."
    menu
  fi
}

#main
dir_check
clear
menu
