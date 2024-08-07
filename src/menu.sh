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
[2] Stop vpn
-
[3] Start static
[4] Stop static
-
[5] Back
[9] Exit
"
}

back_func() {
    cd ~/ # return home
    cd ~/Android-stuff && install.sh # change back and re-run install.sh
    # should do a directory check when 'install.sh' is ran
}

menu() {
banner
echo -e '┌─[number] - [User-Input]'
read -p "└─────> " -n 1 -r

if [[ $REPLY =~ ^[1]$ ]]; then
    echo '2 works' 
elif [[ $REPLY =~ ^[2]$ ]]; then
    echo '2 works'
elif [[ $REPLY =~ ^[3]$ ]]; then
    echo '3 works'
elif [[ $REPLY =~ ^[4]$ ]]; then
        echo '4 works'
elif [[ $REPLY =~ ^[5]$ ]]; then
        echo ""
        read -p "Back to Installation menu? (y/press enter to cancel): " rmenu
        if [ "$rmenu" = "y" ]; then
            back_func
        else
            contenue
        fi


elif [[ $REPLY =~ ^[9]$ ]]; then
        clear
        echo "Stopping software"
            sleep 2
            clear
            cd ~/
            exit
        
else
    clear
    echo "err: Please type a number."
fi
}

#main
dir_check
menu
