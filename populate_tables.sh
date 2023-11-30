#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

-- CarCategory Table
INSERT INTO CarCategory (CategoryName, DailyRate, MaxSeats, LateFee)
VALUES ('Compact', 50.00, 4, 5.00);

INSERT INTO CarCategory (CategoryName, DailyRate, MaxSeats, LateFee)
VALUES ('SUV', 80.00, 7, 8.00);

INSERT INTO CarCategory (CategoryName, DailyRate, MaxSeats, LateFee)
VALUES ('Luxury', 120.00, 5, 15.00);

-- Discounts Table
INSERT INTO Discounts (DiscountCode, DiscountExpiry, PercentOff)
VALUES ('DISC10', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 10);

INSERT INTO Discounts (DiscountCode, DiscountExpiry, PercentOff)
VALUES ('DISC20', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 20);

INSERT INTO Discounts (DiscountCode, DiscountExpiry, PercentOff)
VALUES ('DISC30', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 30);

-- Insurance Table
INSERT INTO Insurance (InsuranceID, InsuranceType, CoverageDetails, CostPerDay)
VALUES ('INS001', 'Basic', 'Basic coverage', 5);

INSERT INTO Insurance (InsuranceID, InsuranceType, CoverageDetails, CostPerDay)
VALUES ('INS002', 'Premium', 'Comprehensive coverage', 10);

INSERT INTO Insurance (InsuranceID, InsuranceType, CoverageDetails, CostPerDay)
VALUES ('INS003', 'Full', 'Full coverage', 15);

-- Car Table
INSERT INTO Car (VIN, Model, Brand, Type, AvailabilityStatus, Color, OdometerReading, Year, LicensePlate, CategoryName)
VALUES ('ABC12345678900001', 'Toyota Corolla', 'Toyota', 'Sedan', 'Available', 'Blue', 30000, 2022, 'ABC123', 'Compact');

INSERT INTO Car (VIN, Model, Brand, Type, AvailabilityStatus, Color, OdometerReading, Year, LicensePlate, CategoryName)
VALUES ('DEF98765432100002', 'Ford Explorer', 'Ford', 'SUV', 'Available', 'Black', 25000, 2021, 'XYZ789', 'SUV');

INSERT INTO Car (VIN, Model, Brand, Type, AvailabilityStatus, Color, OdometerReading, Year, LicensePlate, CategoryName)
VALUES ('GHI11122233344455', 'BMW 7 Series', 'BMW', 'Luxury Sedan', 'Available', 'Silver', 15000, 2023, 'BMW456', 'Luxury');

-- AddressInfo Table
INSERT INTO AddressInfo (AddressID, AddressZipCode, AddressStreet, AddressCity, AddressProvince)
VALUES ('ADDR001', 'L6R4A9', 'Main St', 'Cityville', 'Ontario');

INSERT INTO AddressInfo (AddressID, AddressZipCode, AddressStreet, AddressCity, AddressProvince)
VALUES ('ADDR002', 'L6P304', 'Oak St', 'Townsville', 'Quebec');

INSERT INTO AddressInfo (AddressID, AddressZipCode, AddressStreet, AddressCity, AddressProvince)
VALUES ('ADDR003', 'L65PO6', 'Maple St', 'Villageton', 'Alberta');

-- CardInfo Table
INSERT INTO CardInfo (CardNumber, CardExpiry, CardSecurityCode)
VALUES (1234567890123456, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 123);

INSERT INTO CardInfo (CardNumber, CardExpiry, CardSecurityCode)
VALUES (9876543210987654, TO_DATE('2024-06-30', 'YYYY-MM-DD'), 456);

INSERT INTO CardInfo (CardNumber, CardExpiry, CardSecurityCode)
VALUES (3876543210987686, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 108);

-- Payment Table
INSERT INTO Payment (PaymentID, PayMethod, CardNumber)
VALUES ('PAY001', 'CreditCard', 1234567890123456);

INSERT INTO Payment (PaymentID, PayMethod, CardNumber)
VALUES ('PAY002', 'DebitCard', 9876543210987654);

INSERT INTO Payment (PaymentID, PayMethod, CardNumber)
VALUES ('PAY003', 'DebitCard', 3876543210987686); 

-- Billing Table
INSERT INTO Billing (BillID, BillDate, BillStatus, TaxAmount, DiscCode, TotalAmount, TotalLateFee, BillPayment)
VALUES ('BILL001', SYSDATE, 'Paid', 10, 'DISC10', 90, 0, 'PAY001');

INSERT INTO Billing (BillID, BillDate, BillStatus, TaxAmount, DiscCode, TotalAmount, TotalLateFee, BillPayment)
VALUES ('BILL002', SYSDATE, 'Pending', 15, 'DISC20', 85, 5, 'PAY002');

INSERT INTO Billing (BillID, BillDate, BillStatus, TaxAmount, DiscCode, TotalAmount, TotalLateFee, BillPayment)
VALUES ('BILL003', SYSDATE, 'Paid', 12, 'DISC30', 88, 2, 'PAY003');

-- Customer Table
INSERT INTO Customer (DriversLicenseID, FirstName, LastName, PhoneNumber, Email, AddressID, BillID)
VALUES ('DL001', 'John', 'Doe', '123-456-7890', 'john.doe@email.com', 'ADDR001', 'BILL001');

INSERT INTO Customer (DriversLicenseID, FirstName, LastName, PhoneNumber, Email, AddressID, BillID)
VALUES ('DL002', 'Jane', 'Smith', '987-654-3210', 'jane.smith@email.com', 'ADDR002', 'BILL002');

INSERT INTO Customer (DriversLicenseID, FirstName, LastName, PhoneNumber, Email, AddressID, BillID)
VALUES ('DL003', 'Bob', 'Johnson', '555-123-4567', 'bob.johnson@email.com', 'ADDR003' , 'BILL003');

-- Rental Table
INSERT INTO Rental (RentalID, PickupDate, DropoffDate, DriversLicenseID, VIN, TotalCost, CategoryName)
VALUES (123, SYSDATE, SYSDATE+7, 'DL001', 'ABC12345678900001', 400.00, 'Compact');

INSERT INTO Rental (RentalID, PickupDate, DropoffDate, DriversLicenseID, VIN, TotalCost, CategoryName)
VALUES (456, SYSDATE, SYSDATE+5, 'DL002', 'DEF98765432100002', 480.00, 'SUV');

INSERT INTO Rental (RentalID, PickupDate, DropoffDate, DriversLicenseID, VIN, TotalCost, CategoryName)
VALUES (789, SYSDATE, SYSDATE+3, 'DL003', 'GHI11122233344455', 600.00, 'Luxury');

-- LocAddInfo Table
INSERT INTO LocAddInfo (LocAddID, LocationZipCode, LocationStreet, LocationCity, LocationProv)
VALUES (1, '54321', 'Broadway St', 'Metroville', 'Ontario');

INSERT INTO LocAddInfo (LocAddID, LocationZipCode, LocationStreet, LocationCity, LocationProv)
VALUES (2, '98765', 'Pine St', 'Suburbia', 'Quebec');

INSERT INTO LocAddInfo (LocAddID, LocationZipCode, LocationStreet, LocationCity, LocationProv)
VALUES (3, '12345', 'Market St', 'Villageton', 'Alberta');

-- Location Table
INSERT INTO Location (LocationID, LotNumber, LocPickUp, VehicleID, LocAddID, RentalID )
VALUES ('LOC001', 1, SYSDATE, 'ABC12345678900001', 1, 123);

INSERT INTO Location (LocationID, LotNumber, LocPickUp, VehicleID, LocAddID, RentalID )
VALUES ('LOC002', 2, SYSDATE, 'DEF98765432100002', 2, 456);

INSERT INTO Location (LocationID, LotNumber, LocPickUp, VehicleID, LocAddID, RentalID)
VALUES ('LOC003', 3, SYSDATE, 'GHI11122233344455', 3, 789);

exit;
EOF