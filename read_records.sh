#!/bin/bash

# Set the LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib

sql_query="SELECT * FROM $1;"

result=$(echo "$sql_query" | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))")

echo "Records for $1:"
echo "$result"