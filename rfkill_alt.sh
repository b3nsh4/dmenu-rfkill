#!/bin/bash
interface_list=$(echo -e "Bluetooth\nWlan" | dmenu)
case $interface_list in
	Bluetooth)
		rf_stat_bt=$(rfkill -n | awk '/blue/  {print $4}' | dmenu -p "CURRENT STATUS::")
		blk=$(rfkill | awk '/blue/' | awk '{print $1}')
		if [[ $rf_stat_bt = "blocked" ]];
		then
			sudo rfkill unblock ${blk};

			printf "UNBLOCK SUCCESS !!" | dmenu
		
		else
			 sudo rfkill block ${blk};
			 printf "BLOCK SUCCESS !!" | dmenu
		fi
	;;
	Wlan)
		rf_stat_wifi=$(rfkill -n | awk '/wlan/  {print $4}' | dmenu -p "CURRENT STATUS::")
		blk=$(rfkill | awk '/wlan/' | awk '{print $1}')
		if [[ $rf_stat_wifi = "blocked" ]];
		then
			 sudo  rfkill unblock ${blk}
			 printf "UNBLOCK SUCCESS !!" | dmenu
		else
			 sudo rfkill block ${blk};
			 printf "BLOCK SUCCESS !!" | dmenu
		fi
	;;
	*)
esac

#############################################################
#ADD user to sudoers with NOPASSWD to remove passwd for rfkill
#or pass passwd as sudo stdin via echo | printf 
