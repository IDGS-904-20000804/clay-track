USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = N'ClayTrack') DROP DATABASE ClayTrack;

CREATE DATABASE ClayTrack;
GO

USE ClayTrack;
GO

CREATE TABLE CatUnitMeasure (
  idCatUnitMeasure INT IDENTITY(1,1) PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE CatRawMaterial (
  idCatRawMaterial INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatUnitMeasure INT NOT NULL
);
GO

CREATE TABLE CatRole (
  idCatRole INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE CatUser (
  idCatUser INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE DetailRoleUser (
  idDetailRoleUser INT IDENTITY(1,1) PRIMARY KEY,
  fkCatUser INT NOT NULL,
  fkCatRole INT NOT NULL
);
GO

CREATE TABLE CatPerson (
  idCatPerson INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  middleName VARCHAR(255),
  phone VARCHAR(255) NOT NULL,
  postalCode INT NOT NULL,
  streetNumber VARCHAR(255) NOT NULL,
  apartmentNumber VARCHAR(255),
  street VARCHAR(255) NOT NULL,
  neighborhood VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE CatClient (
  idCatClient INT IDENTITY(1,1) PRIMARY KEY,
  fkCatPerson INT NOT NULL,
  fkCatUser INT NOT NULL
);
GO

CREATE TABLE CatSupplier (
  idCatSupplier INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  fkCatPerson INT NOT NULL
);
GO

CREATE TABLE CatEmployee (
  idCatEmployee INT IDENTITY(1,1) PRIMARY KEY,
  fkCatPerson INT NOT NULL,
  fkCatUser INT NOT NULL
);
GO

CREATE TABLE CatPurchase (
  idCatPurchase INT IDENTITY(1,1) PRIMARY KEY,
  total FLOAT NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSupplier INT NOT NULL,
  fkCatEmployee INT NOT NULL
);
GO

CREATE TABLE DetailPurchase (
  idDetailPurchase INT IDENTITY(1,1) PRIMARY KEY,
  quantity FLOAT NOT NULL,
  price FLOAT NOT NULL,
  fkCatWarehouse INT NOT NULL,
  fkCatPurchase INT NOT NULL
);
GO

CREATE TABLE CatWarehouse (
  idCatWarehouse INT IDENTITY(1,1) PRIMARY KEY,
  quantity INT NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatRawMaterial INT NOT NULL
);
GO

CREATE TABLE CatRecipe (
  idCatRecipe INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  imagePath VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE DetailRecipeRawMaterial (
  idDetailRecipeRawMaterial INT IDENTITY(1,1) PRIMARY KEY,
  fkCatRecipe INT NOT NULL,
  quantity FLOAT NOT NULL,
  fkCatRawMaterial INT NOT NULL
);
GO

CREATE TABLE CatStock (
  idCatStock INT IDENTITY(1,1) PRIMARY KEY,
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatRecipe INT NOT NULL
);
GO

CREATE TABLE CatSale (
  idCatSale INT IDENTITY(1,1) PRIMARY KEY,
  total FLOAT NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatClient INT NOT NULL
);
GO

CREATE TABLE DetailSale (
  idDetailSale INT IDENTITY(1,1) PRIMARY KEY,
  quantity FLOAT NOT NULL,
  price FLOAT NOT NULL,
  fkCatStock INT NOT NULL,
  fkCatSale INT NOT NULL
);
GO

CREATE TABLE CatShipment (
  idCatShipment INT IDENTITY(1,1) PRIMARY KEY,
  delivered BIT NOT NULL DEFAULT 0,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSale INT NOT NULL,
  fkCatEmployee INT
);
GO

INSERT INTO CatUnitMeasure (description) VALUES ('Pieces'), ('Kilograms'), ('Liters');
INSERT INTO CatRawMaterial (name, fkCatUnitMeasure) VALUES ('Clay', 1), ('Glaze', 2), ('Pigment', 3);
INSERT INTO CatRole (name) VALUES ('Administrator'), ('Manager'), ('Employee');
INSERT INTO CatUser (email, password) VALUES ('admin@craftedclay.com', 'admin123'), ('manager@craftedclay.com', 'manager123'), ('employee@craftedclay.com', 'employee123');
INSERT INTO DetailRoleUser (fkCatUser, fkCatRole) VALUES (1, 1), (2, 2), (3, 3);
INSERT INTO CatPerson (name, lastName, phone, postalCode, streetNumber, street, neighborhood) VALUES
('John', 'Doe', '1234567890', 12345, '1A', 'Main Street', 'Downtown'),
('Jane', 'Smith', '9876543210', 54321, '2B', 'Park Avenue', 'Suburb');
INSERT INTO CatClient (fkCatPerson, fkCatUser) VALUES (1, 1), (2, 2);
INSERT INTO CatSupplier (email, fkCatPerson) VALUES ('supplier1@craftedclay.com', 1), ('supplier2@craftedclay.com', 2);
INSERT INTO CatEmployee (fkCatPerson, fkCatUser) VALUES (1, 3), (2, 3), (3, 3), (4, 3), (5, 3);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (100.00, 1, 1), (200.00, 2, 2), (150.00, 1, 3);
INSERT INTO DetailPurchase (quantity, price, fkCatWarehouse, fkCatPurchase) VALUES (10, 5.00, 1, 1), (5, 8.00, 2, 1), (8, 3.50, 3, 2);
INSERT INTO CatWarehouse (quantity, fkCatRawMaterial) VALUES (20, 1), (30, 2), (15, 3);
INSERT INTO CatRecipe (name, price, imagePath) VALUES ('Mug', 15.00, 'mug.jpg'), ('Bowl', 10.00, 'bowl.jpg');
INSERT INTO DetailRecipeRawMaterial (quantity, fkCatRecipe, fkCatRawMaterial) VALUES (1.5, 1, 1), (0.75, 1, 2), (0.5, 2, 1);
INSERT INTO CatStock (quantity, price, fkCatRecipe) VALUES (10, 15.00, 1), (20, 10.00, 2), (15, 12.00, 3);
INSERT INTO CatSale (total, fkCatClient) VALUES (50.00, 1), (100.00, 2);
INSERT INTO DetailSale (quantity, price, fkCatStock, fkCatSale) VALUES (2, 15.00, 1, 1), (1, 10.00, 2, 1), (3, 12.00, 3, 2);
INSERT INTO CatShipment (delivered, fkCatSale, fkCatEmployee) VALUES (1, 1, 3), (0, 2, 4);
UPDATE CatWarehouse SET quantity = quantity - 2 WHERE idCatWarehouse = 1;
UPDATE CatStock SET quantity = quantity - 2 WHERE idCatStock = 1;
