                            
							
							--SQL SCRIPT - SUPPLY CHAIN MANAGEMENT - GROUP A: Mudaiheg,Doaa ; Da Silva,Elaine ; Yetman,Mitchell ; Parsana,Dhruv ; Ngo, Hang

----------------------------------------------------CREATE DATABASE ----------------------------------------------------------------------------------------------------

CREATE DATABASE SupplyChain2;
Go

Use SupplyChain;

-----------------------------------------------------CREATE TABLES ----------------------------------------------------------------------------------------------------
-- Create table Customer
CREATE TABLE Product(
    pro_id INT IDENTITY(1,1) PRIMARY KEY,
    pro_name VARCHAR(255) NOT NULL,
    pro_description VARCHAR(255) NOT NULL,
    pro_unitPrice DECIMAL(18, 2)
);

-- Create table Supplier
CREATE TABLE Supplier(
    sup_id INT IDENTITY(1,1) PRIMARY KEY,
	sup_phone VARCHAR(255) NOT NULL,
	sup_email VARCHAR(255) NOT NULL,
	sup_address VARCHAR(255) NOT NULL,
	sup_city VARCHAR(255) NOT NULL,
	sup_province VARCHAR(255) CHECK (sup_province IN ('AB', 'BC', 'MB', 'NB', 'NS', 'NL', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT')) NOT NULL,
	sup_postalCode VARCHAR(255) NOT NULL,
    sup_fName VARCHAR(255) NOT NULL,
	sup_lName VARCHAR(255) NOT NULL 
);

-- Create table Customer
CREATE TABLE Customer(
    cust_id INT IDENTITY(1,1) PRIMARY KEY,
	cust_phone VARCHAR(255) NOT NULL,
	cust_email VARCHAR (255) NOT NULL,
	cust_address VARCHAR(255) NOT NULL,
	cust_city VARCHAR(255) NOT NULL,
	cust_province VARCHAR(255) CHECK (cust_province IN ('AB', 'BC', 'MB', 'NB', 'NS', 'NL', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT')) NOT NULL,
	cust_postalCode VARCHAR(255) NOT NULL,
	cust_fName VARCHAR(255)NOT NULL,
    cust_lName VARCHAR(255)NOT NULL
);

-- Create table Inventory
CREATE TABLE Inventory(
    inv_id INT IDENTITY(1,1) PRIMARY KEY,
    inv_quantityOnHand INT NOT NULL,
	pro_id_fk INT NOT NULL,--FK
);

-- Create table PurchaseOrder
CREATE TABLE PurchaseOrder(
	purchOrd_id INT IDENTITY(1,1) PRIMARY KEY,
	purchOrd_orderDate DATE NOT NULL,
	purchOrd_quantity INT NOT NULL,
    sup_id_fk INT NOT NULL,--FK
	pro_id_fk INT NOT NULL,--FK
);

-- Create table SalesOrder
CREATE TABLE SalesOrder(
    saleOrd_id INT IDENTITY(1,1) PRIMARY KEY,
	saleOrd_quantity INT NOT NULL,
	saleOrd_orderDate DATE NOT NULL,
    cust_id_fk INT NOT NULL,--FK
	pro_id_fk INT NOT NULL,--FK
);

-- Create table Shipment
CREATE TABLE Shipment(
    ship_id INT IDENTITY(1,1) PRIMARY KEY,
    saleOrd_id_fk INT NOT NULL, --FK
    ship_date DATE NOT NULL,
    ship_quantity INT NOT NULL,
    ship_status VARCHAR(255) NOT NULL,
	ship_address VARCHAR(255) NOT NULL,
	ship_city VARCHAR(255) NOT NULL,
	ship_province VARCHAR(255) CHECK (ship_province IN ('AB', 'BC', 'MB', 'NB', 'NS', 'NL', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT')) NOT NULL,
	ship_postalCode VARCHAR(255) NOT NULL,
);

-------------------------------------------------ALTER TABLE TO ADD FOREIGN KEYS ----------------------------------------------------------------------------------------------------

-- Add foreign key (pro_id_fk) to table Inventory

	ALTER TABLE Inventory ADD CONSTRAINT [FK_product_id] FOREIGN KEY([pro_id_fk])
REFERENCES Product(pro_id)
ON DELETE CASCADE;



-- Add foreign key (pro_id_fk) AND (sup_id_fk)  to table PurchaseOrder

	ALTER TABLE PurchaseOrder ADD CONSTRAINT [FK_productId_PurchaseOrder] FOREIGN KEY([pro_id_fk])
REFERENCES Product(pro_id)
ON DELETE CASCADE;

ALTER TABLE PurchaseOrder ADD CONSTRAINT [FK_supplier_id] FOREIGN KEY([sup_id_fk])
REFERENCES Supplier(sup_id)
ON DELETE CASCADE;



-- Add foreign key (pro_id_fk) AND (cust_id_fk) to table SalesOrder

ALTER TABLE SalesOrder
ADD CONSTRAINT FK_productiD_Salesorder FOREIGN KEY (pro_id_fk ) --FK
	REFERENCES Product(pro_id) ON DELETE CASCADE;

ALTER TABLE SalesOrder
ADD CONSTRAINT FK_customer_id FOREIGN KEY (cust_id_fk ) --FK
	REFERENCES Customer(cust_id) ON DELETE CASCADE;



-- Add foreign key (pro_id_fk) AND (cust_id_fk) to table Shipment
ALTER TABLE Shipment
ADD CONSTRAINT FK_saleOrderId_Shipment FOREIGN KEY (saleOrd_id_fk ) --FK
	REFERENCES SalesOrder(saleOrd_id) ON DELETE CASCADE;


--------------------------------------------------------------INSERT DATA INTO TABLES---------------------------------------------------------------------------------------------------------

-- Insert data into Supplier table
INSERT INTO Supplier (sup_fName, sup_lName, sup_phone, sup_email, sup_city, sup_address, sup_province, sup_postalCode)
VALUES
('Tech Supply Co.', 'John Jumpson', '1094867990', 'john.jumpson@techsupply.com','5660 Spring Garden', 'Halifax', 'NS', '3J8 6H8'),
('ElectroTech Solutions', 'Emily Smith', '6876343573', 'emily.smith@electrotech.com','80 Willet St', 'Halifax', 'NS', '3M2 3L7');


-- Insert data into Customer table
INSERT INTO Customer(cust_fName, cust_lName, cust_phone, cust_email, cust_address, cust_city, cust_province, cust_postalCode)
VALUES
('Tom', 'Thomas','1094867422', 'Tom.Thomas235@gmail.com', '456 North Park st', 'Halifax', 'NS', '3C6 7D4'),
('Bob', 'Smith', '5095667990','BothSmith234@gmail.com', '24 Terresa st', 'Halifax', 'NS', '4H6 2C5'),
('Joe', 'Brown', '8092454408','Joe_Browns289@gmail.com','36 Main st', 'Halifax', 'NS', '34K6 8D9');

-- Insert data into Product table
INSERT INTO Product(pro_name, pro_description, pro_unitPrice)
VALUES
('Laptop1', 'laptop with SSD', 899.99),
('Smartphone2', 'advanced features', 599.99),
('Tablet1', 'Lightweight tablet ', 349.99),
('Desktop PC33', 'Powerful desktop ', 1299.99);


-- Insert data into Inventory table
INSERT INTO Inventory (inv_quantityOnHand, pro_id_fk )
VALUES
(70, 2),  -- Product with Pro_ProductId 2 has 70 units on hand
(30, 1),  -- Product with Pro_ProductId 1 has 30 units on hand
(65, 3);  -- Product with Pro_ProductId 3 has 65 units on hand



-- Insert data into SaleOrder table
INSERT INTO SalesOrder(pro_id_fk, cust_id_fk, saleOrd_orderDate, saleOrd_quantity)
VALUES
(1, 1, convert(date,'2023-01-15',23), 50),
(2, 2, convert(date,'2023-02-20',23), 30),
(3, 3, convert(date,'2023-03-25',23), 25);

-- Insert data into Shipment table
INSERT INTO Shipment (saleOrd_id_fk, ship_date, ship_quantity, ship_status, ship_address, ship_city, ship_province, ship_postalCode)
VALUES
(1, convert(date,'2023-07-2',23), 150, 'Shipped', '870 Dresden st', 'Halifax', 'NS', '3H6 7D8'),
(2, convert(date,'2023-04-5',23), 330, 'Shipped', '450 Spring Garden', 'Halifax', 'NS', '8H5 4S6'),
(3, convert(date,'2023-02-3',23), 245, 'Pending', '350 Duke St', 'Halifax', 'AB', '4J8 6H9');

-- Insert data into PurchaseOrder table
INSERT INTO PurchaseOrder(pro_id_fk, sup_id_fk, purchOrd_orderDate, purchOrd_quantity)
VALUES
(1, 1, convert(date,'2023-01-15',23), 50),
(2, 2, convert(date,'2023-02-20',23), 30),
(3, 1, convert(date,'2023-03-25',23), 25);

--------------------------------------------------------------VIEW DATA IN TABLES---------------------------------------------------------------------------------------------------
Select * from SalesOrder;
Select * from Customer;
Select * from Product;
Select * from Supplier;
Select * From Inventory;
Select * From PurchaseOrder;
Select * From Shipment;