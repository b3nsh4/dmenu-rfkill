#!/bin/bash
interface_list=$(echo -e "Bluetooth\nWlan" | dmenu)
case $interface_list in
	Bluetooth)
		#sel_1=$(echo -e "Block\nUnblock" | dmenu -p  "target")
		rf_stat_bt=$(rfkill -n | awk '/blue/  {print $4}' | dmenu -p "CURRENT STATUS::")
		if [[ $rf_stat_bt = "blocked" ]];
		then
			#ADD user to sudoers with NOPASSWD to remove passwd for rfkill
			#or pass passwd as sudo stdin via echo | printf 
			sudo rfkill unblock 3;
			 printf "UNBLOCK SUCCESS !!" | dmenu
		else
			 sudo rfkill block 3;
			 printf "BLOCK SUCCESS !!" | dmenu
		fi
	;;
	Wlan)
		#sel_2=$(echo -e "Block\nUnblock" | dmenu -p "target")
		rf_stat_wifi=$(rfkill -n | awk '/wlan/  {print $4}' | dmenu -p "CURRENT STATUS::")
		if [[ $rf_stat_wifi = "blocked" ]];
		then
			 sudo  rfkill unblock 1;
			 printf "UNBLOCK SUCCESS !!" | dmenu
		else
			 sudo rfkill block 1;
			 printf "BLOCK SUCCESS !!" | dmenu
		fi
	;;
	*)
esac
