#!/bin/sh

delete_record() {
   local table_name="$1"
   read -p "Write your query to delete from the $table_name Table: " query

   # Execute the deletion query
   result=$(sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
   whenever sqlerror exit sql.sqlcode;
   $query
EOF
   )

   sql_error_code=$?

   # Check for foreign key constraint violation
   if [ $sql_error_code -eq 2292 ]; then
      echo "Cannot delete record(s) from $table_name due to existing references in other tables (foreign key constraint)."
   elif [ $sql_error_code -ne 0 ]; then
      echo "Error deleting record(s) from $table_name Table. Error code: $sql_error_code"
   else
      echo "Record(s) deleted successfully"
   fi 
}

while true; do
    echo "You are on the delete a record page: "
    echo "Below are the tables you can delete a record from "
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
    echo " Note that you can NOT delete a record with foreign keys due to constraints! "
    read -p "Enter the number of the table: " selected_table

    case $selected_table in
      1)
        echo "You selected Location Table"
        delete_record "Location"
        break
        ;;
      2)
        echo "You selected Rental Table"
        delete_record "Rental"
        break
        ;;
      3)
        echo "You selected Customer Table"
        delete_record "Customer"
        break
        ;;
      4)
        echo "You selected Billing Table"
        delete_record "Billing"
        break
        ;;
      5)
        echo "You selected Payment Table"
        delete_record "Payment"
        break
        ;;
      6)
        echo "You selected CardInfo Table"
        delete_record "CardInfo"
        break
        ;;
      7)
        echo "You selected AddressInfo Table"
        delete_record "AddressInfo"
        break
        ;;
      8)
        echo "You selected Car Table"
        delete_record "Car"
        break
        ;;
      9)
        echo "You selected Insurance Table"
        delete_record "Insurance"
        break
        ;;
      10)
        echo "You selected Discounts Table"
        delete_record "Discounts"
        break
        ;;
      11)
        echo "You selected CarCategory Table"
        delete_record "CarCategory"
        break
        ;;
      12)
        echo "You selected LocAddInfo Table"
        delete_record "LocAddInfo"
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