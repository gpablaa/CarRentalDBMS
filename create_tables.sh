#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

-- Create the CarCategory table
CREATE TABLE CarCategory (
   CategoryName VARCHAR2(50) PRIMARY KEY,
   DailyRate DECIMAL(10, 2) NOT NULL, 
   MaxSeats INT NOT NULL, 
   LateFee DECIMAL(10, 2) NOT NULL 
);

-- Create Discount table
CREATE TABLE Discounts (
   DiscountCode VARCHAR2(10) PRIMARY KEY,
   DiscountExpiry DATE,
   PercentOff INT
);

-- Create Insurance table
CREATE TABLE Insurance (
   InsuranceID VARCHAR2(10) PRIMARY KEY,
   InsuranceType VARCHAR2(20) NOT NULL,
   CoverageDetails VARCHAR2(100) NOT NULL,
   CostPerDay INT NOT NULL
);

-- Create the Car table
CREATE TABLE Car (
   VIN VARCHAR2(17) PRIMARY KEY,
   Model VARCHAR2(50) NOT NULL,
   Brand VARCHAR2(50) NOT NULL,
   Type VARCHAR2(50),
   AvailabilityStatus VARCHAR2(20) DEFAULT 'Available' NOT NULL,
   Color VARCHAR2(30),
   OdometerReading INT,
   Year INT,
   LicensePlate VARCHAR2(15) UNIQUE,
   CategoryName VARCHAR2(50) NOT NULL, 
   FOREIGN KEY (CategoryName) REFERENCES CarCategory(CategoryName)
);

-- Create the AddressInfo table
CREATE TABLE AddressInfo (
   AddressID VARCHAR(20) PRIMARY KEY,
   AddressZipCode VARCHAR2(6) NOT NULL,
   AddressStreet VARCHAR(255),
   AddressCity VARCHAR(100),
   AddressProvince VARCHAR(100)
);

-- Create the CardInfo Table
CREATE TABLE CardInfo (
   CardNumber INT PRIMARY KEY,
   CardExpiry DATE, 
   CardSecurityCode INT UNIQUE
);

-- Create the Payment Table
CREATE TABLE Payment (
   PaymentID VARCHAR2(10) PRIMARY KEY,
   PayMethod VARCHAR2(10) NOT NULL,
   CardNumber INT NOT NULL UNIQUE,
   FOREIGN KEY (CardNumber) REFERENCES CardInfo(CardNumber)
);

-- Create Billing table
CREATE TABLE Billing (
   BillID VARCHAR2(30) PRIMARY KEY,
   BillDate DATE,
   BillStatus VARCHAR2(10),
   TaxAmount INT,
   DiscCode VARCHAR2(10),
   TotalAmount INT,
   TotalLateFee INT,
   BillPayment VARCHAR2(10),
   FOREIGN KEY (DiscCode) REFERENCES Discounts(DiscountCode),
   FOREIGN KEY (BillPayment) REFERENCES Payment(PaymentID)
);

-- Create the Customer table
CREATE TABLE Customer (
   DriversLicenseID VARCHAR2(20) PRIMARY KEY,
   FirstName VARCHAR2(50) NOT NULL,
   LastName VARCHAR2(50) NOT NULL,
   PhoneNumber VARCHAR2(15),
   Email VARCHAR2(100) UNIQUE,
   AddressID VARCHAR2(20),
   BillID VARCHAR2(30),
   FOREIGN KEY (BillID) REFERENCES Billing(BillID),
   FOREIGN KEY (AddressID) REFERENCES AddressInfo(AddressID)
);

-- Create the Rental Table
CREATE TABLE Rental (
    RentalID INT PRIMARY KEY,
    PickupDate DATE NOT NULL,
    DropoffDate DATE NOT NULL,
    DriversLicenseID VARCHAR2(20) NOT NULL,
    VIN VARCHAR2(17) NOT NULL,
    TotalCost DECIMAL(10, 2),
    CategoryName VARCHAR2(50) NOT NULL,
    FOREIGN KEY (DriversLicenseID) REFERENCES Customer(DriversLicenseID),
    FOREIGN KEY (VIN) REFERENCES Car(VIN),
    FOREIGN KEY (CategoryName) REFERENCES CarCategory(CategoryName)
);
-- Create LocAddInfo table
CREATE TABLE LocAddInfo (
    LocAddID INT PRIMARY KEY,
    LocationZipCode VARCHAR2(10),
    LocationStreet VARCHAR2(30),
    LocationCity VARCHAR2(10),
    LocationProv VARCHAR2(30)
);

-- Create the Location Table
CREATE TABLE Location (
    LocationID VARCHAR2(30) PRIMARY KEY,
    LotNumber INT,
    LocPickUp DATE,
    VehicleID VARCHAR2(17),
    LocAddID INT NOT NULL,
    RentalID INT, 
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID),
    FOREIGN KEY (VehicleID) REFERENCES Car(VIN),
    FOREIGN KEY (LocAddID) REFERENCES LocAddInfo(LocAddID)
);

exit;
EOF