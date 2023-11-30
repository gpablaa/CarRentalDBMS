#!/bin/sh
MainMenu()
{
  while [ "$CHOICE" != "START" ]
  do
    clear
    echo "================================================================="
    echo "| Oracle All Inclusive Tool|"
    echo "| Main Menu - Select Desired Operation(s):|"
    echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt>|"
    echo "-----------------------------------------------------------------"
    echo " $IS_SELECTEDM M) View Manual"
    echo " "
    echo " $IS_SELECTED1 1) Drop Tables"
    echo " $IS_SELECTED2 2) Create Tables"
    echo " $IS_SELECTED3 3) Populate Tables"
    echo " $IS_SELECTED4 4) Query Tables"
    echo " $IS_SELECTED5 5) Read Records"
    echo " $IS_SELECTED5 6) Update Records"
    echo " $IS_SELECTED5 7) Delete Records"
    echo " $IS_SELECTED5 8) Search Records"
    echo " "
    echo " $IS_SELECTEDX X) Force/Stop/Kill Oracle DB"
    echo " "
    echo " $IS_SELECTEDE E) End/Exit"
    echo "Choose: "
    read CHOICE
    if [ "$CHOICE" == "0" ]
    then
        echo "Nothing Here"
    elif [ "$CHOICE" == "1" ]
    then
        bash drop_tables.sh
        sleep 5
    elif [ "$CHOICE" == "2" ]
    then
        bash create_tables.sh
        sleep 5
    elif [ "$CHOICE" == "3" ]
    then
        bash populate_tables.sh
        sleep 5
    elif [ "$CHOICE" == "4" ]
    then
        bash queries.sh
        sleep 5
    elif [ "$CHOICE" == "5" ]
    then
	         echo "You are on the read a record page: "
        echo "Below are the tables you can read a record from "
        echo "Options: "
        echo " Location "
        echo " Rental "
        echo " Customer "
        echo " Billing "
        echo " Payment "
        echo " CardInfo "
        echo " AddressInfo "
        echo " Car "
        echo " Insurance "
        echo " Discounts "
        echo " CarCategory "
        echo " LocAddInfo "
        echo " "
        echo "Enter the Table Name:"
        read TABLE_NAME
        bash read_records.sh "$TABLE_NAME"
        sleep 7
	echo "Enter the table:"
	read TABLE_NAME
    	if [ "$TABLE_NAME" = "E" ]; then
        	echo "Returning to the main page..."
		sleep 5
    	else
        	bash read_records.sh "$TABLE_NAME"
        	sleep 5
    	fi
    elif [ "$CHOICE" == "6" ]
    then
        bash update_records.sh
        sleep 7
    elif [ "$CHOICE" == "7" ]
    then
        bash delete_records.sh
        sleep 7
    elif [ "$CHOICE" == "8" ]
    then
	echo "You are on the search records page: "
        echo "Below are the tables you can search records from "
        echo "Options: "
        echo " Location "
        echo " Rental "
        echo " Customer "
        echo " Billing "
        echo " Payment "
        echo " CardInfo "
        echo " AddressInfo "
        echo " Car "
        echo " Insurance "
        echo " Discounts "
        echo " CarCategory "
        echo " LocAddInfo "
        echo " "
	echo "Enter the Table Name (or 'E' to return to the main menu):"
        read TABLE_NAME
	if [ "$TABLE_NAME" = "E" ]; then
        	echo "Returning to the main page..."
        	sleep 5
    	else
        	bash search_records.sh "$TABLE_NAME"
        	sleep 7
    	fi
        	sleep 7
    elif [ "$CHOICE" == "E" ]
    then
        exit
    fi
    done
}

#--COMMENTS BLOCK--
# Main Program
#--COMMENTS BLOCK--

ProgramStart()
{
    StartMessage
    while [ 1 ]
    do
        MainMenu
    done
}
ProgramStart