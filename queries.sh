#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

--Query 1: Updating the BillIDs for the customers
--  Uses UPDATE with a CASE expresson 
UPDATE Customer
SET BillID = 
    CASE 
        WHEN FirstName = 'John' THEN 'BILL001'
        WHEN FirstName = 'Jane' THEN 'BILL002'
        WHEN FirstName = 'Bob' THEN 'BILL003'
    END;

-- Query 2: Show all the FN, LN and DriversID for people who HAVE made a rental
-- Uses subquery in the WHERE EXISTS clause 
SELECT C.FirstName, C.LastName, C.DriversLicenseID
FROM Customer C
WHERE EXISTS (
    SELECT *
    FROM Rental R
    WHERE R.DriversLicenseID = C.DriversLicenseID
);

-- Query 3: Show FN and LN for Customers who are from Ontario or Alberta
-- Uses UNION operator to combine SELECT statements. Also uses JOIN and UNION. 
SELECT FirstName, LastName
FROM Customer
JOIN AddressInfo ON Customer.AddressID = AddressInfo.AddressID
WHERE AddressInfo.AddressProvince = 'Ontario'
UNION
    (SELECT FirstName, LastName
    FROM Customer
    JOIN AddressInfo ON Customer.AddressID = AddressInfo.AddressID
    WHERE AddressInfo.AddressProvince = 'Alberta');
    
--Query 4: Retrieve the car category with the highest rental count
-- Uses The use of the LEFT JOIN and the COUNT function with GROUP BY. Limits the result to the top row using ROWNUM.
SELECT CategoryName, RentalCount
FROM (
    SELECT Car.CategoryName, COUNT(Rental.PickupDate) AS RentalCount
    FROM Car
    LEFT JOIN Rental ON Car.VIN = Rental.VIN
    GROUP BY Car.CategoryName
    ORDER BY Count(Rental.PickupDate) DESC
)
WHERE ROWNUM <= 1;

--Query 5: Calculate the avg total cost and stddev for each car category name
-- It filters the results using HAVING with conditions on the calculated aggregates (AVG and STDDEV).
SELECT CategoryName, AVG(TotalCost) AS AverageCost, STDDEV(TotalCost) AS CostStdDev
FROM Rental
GROUP BY CategoryName
HAVING AVG(TotalCost) > 200 AND STDDEV(TotalCost) < 50;

--Query 6: Retrieve FN LN of customers who have made at least one rental
-- Uses EXISTS clause with a correlated subquery and GROUP BY and HAVING clauses are used to ensure that only distinct customers. 
SELECT Customer.FirstName, Customer.LastName
FROM Customer
WHERE EXISTS (
    SELECT 1
    FROM Rental
    WHERE Rental.DriversLicenseID = Customer.DriversLicenseID
)
GROUP BY Customer.FirstName, Customer.LastName
HAVING COUNT(*) >= 1;

exit;
EOF