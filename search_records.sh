#!/bin/bash

# Set the LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib

read -p "Enter the attribute name to search: " ATTRIBUTE_NAME

read -p "Enter the value of the attribute to search: " search_value

sql_query="SELECT * FROM $1 WHERE $ATTRIBUTE_NAME = '$search_value';"

result=$(echo "$sql_query" | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))")

echo "Records for $1 with attribute '$ATTRIBUTE_NAME' equal to '$search_value':"
echo "$result"