#!/bin/sh

execute_query() {
   local table_name="$1"
   read -p "Write your query to update the $table_name Table: " query
   result=$(sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
   $query
EOF
   )
   if [ $? -eq 0 ]; then
      echo "Query result: $result"
      echo "$table_name updated successfully "
   else
      echo "Error updating $table_name Table. Error: $result"
   fi
}

while true; do
   echo "You are on the update a record page: "
   echo "Below are the tables you can update a record from "
   echo "Options: "
   echo " 1. Location Table "
   echo " 2. Rental Table "
   echo " 3. Customer Table "
   echo " 4. Billing Table "
   echo " 5. Payment Table "
   echo " 6. CardInfo Table "
   echo " 7. AddressInfo Table "
   echo " 8. Car Table "
   echo " 9. Insurance Table "
   echo " 10. Discounts Table "
   echo " 11. CarCategory Table "
   echo " 12. LocAddInfo Table "
   echo " E. Return to Menu"
   echo " "
   echo " Note that CardInfo Table is referenced by Customer Table "
   echo " Note that AddressInfo Table is referenced by Customer Table "
   echo " Note that LocAddInfo Table is referenced by Location Table "
   
   read -p "Enter the number of the table: " selected_table

   case $selected_table in
      1)
         echo "You selected Location Table"
         execute_query "Location"
         break
         ;;
      2)
         echo "You selected Rental Table"
         execute_query "Rental"
         break
         ;;
      3)
         echo "You selected Customer Table"
         execute_query "Customer"
         break
         ;;
      4)
         echo "You selected Billing Table"
         execute_query "Billing"
         break
         ;;
      5)
         echo "You selected Payment Table"
         execute_query "Payment"
         break
         ;;
      6)
         echo "You selected CardInfo Table"
         execute_query "CardInfo"
         break
         ;;
      7)
         echo "You selected AddressInfo Table"
         execute_query "AddressInfo"
         break
         ;;
      8)
         echo "You selected Car Table"
         execute_query "Car"
         break
         ;;
      9)
         echo "You selected Insurance Table"
         execute_query "Insurance"
         break
         ;;
      10)
         echo "You selected Discounts Table"
         execute_query "Discounts"
         break
         ;;
      11)
         echo "You selected CarCategory Table"
         execute_query "CarCategory"
         break
         ;;
      12)
         echo "You selected LocAddInfo Table"
         execute_query "LocAddInfo"
         break
         ;;
      [Ee])
         echo "Returning to the Main Menu..."
         exit
         ;;
      *)
         echo "Invalid selection. Please enter a valid table number. "
         ;;
   esac
done