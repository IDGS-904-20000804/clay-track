USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'ClayTrack')
BEGIN
    ALTER DATABASE [ClayTrack]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ClayTrack
END;
GO
CREATE DATABASE ClayTrack;
GO
USE ClayTrack;
GO
CREATE TABLE CatSize (
  idCatSize INT IDENTITY(1,1) PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  abbreviation VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
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
  quantityWarehouse INT DEFAULT 0 NOT NULL,
  quantityPackage INT NOT NULL,
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
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  fkCatRawMaterial INT NOT NULL,
  fkCatPurchase INT NOT NULL
);
GO
CREATE TABLE CatRecipe (
  idCatRecipe INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  quantityStock INT NOT NULL DEFAULT 0,
  imagePath VARCHAR(255),
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSize INT NOT NULL
);
GO
CREATE TABLE DetailRecipeRawMaterial (
  idDetailRecipeRawMaterial INT IDENTITY(1,1) PRIMARY KEY,
  fkCatRecipe INT NOT NULL,
  quantity INT NOT NULL,
  fkCatRawMaterial INT NOT NULL
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
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  fkCatRecipe INT NOT NULL,
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
CREATE TABLE DetailRecipeColor (
  idDetailRecipeColor INT IDENTITY(1,1) PRIMARY KEY,
  fkCatRecipe INT NOT NULL,
  fkCatColor INT NOT NULL
);
GO
CREATE TABLE CatColor (
  idCatColor INT IDENTITY(1,1) PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  hexadecimal VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO


ALTER TABLE CatRawMaterial ADD CONSTRAINT FK_CatRawMaterial_CatUnitMeasure FOREIGN KEY (fkCatUnitMeasure) REFERENCES CatUnitMeasure(idCatUnitMeasure);
ALTER TABLE DetailRoleUser ADD CONSTRAINT FK_DetailRoleUser_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE DetailRoleUser ADD CONSTRAINT FK_DetailRoleUser_CatRole FOREIGN KEY (fkCatRole) REFERENCES CatRole(idCatRole);
ALTER TABLE CatClient ADD CONSTRAINT FK_CatClient_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatClient ADD CONSTRAINT FK_CatClient_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE CatSupplier ADD CONSTRAINT FK_CatSupplier_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatEmployee ADD CONSTRAINT FK_CatEmployee_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatEmployee ADD CONSTRAINT FK_CatEmployee_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE CatPurchase ADD CONSTRAINT FK_CatPurchase_CatSupplier FOREIGN KEY (fkCatSupplier) REFERENCES CatSupplier(idCatSupplier);
ALTER TABLE CatPurchase ADD CONSTRAINT FK_CatPurchase_CatEmployee FOREIGN KEY (fkCatEmployee) REFERENCES CatEmployee(idCatEmployee);
ALTER TABLE DetailPurchase ADD CONSTRAINT FK_DetailPurchase_CatRawMaterial FOREIGN KEY (fkCatRawMaterial) REFERENCES CatRawMaterial(idCatRawMaterial);
ALTER TABLE DetailPurchase ADD CONSTRAINT FK_DetailPurchase_CatPurchase FOREIGN KEY (fkCatPurchase) REFERENCES CatPurchase(idCatPurchase);
ALTER TABLE DetailRecipeRawMaterial ADD CONSTRAINT FK_DetailRecipeRawMaterial_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);
ALTER TABLE DetailRecipeRawMaterial ADD CONSTRAINT FK_DetailRecipeRawMaterial_CatRawMaterial FOREIGN KEY (fkCatRawMaterial) REFERENCES CatRawMaterial(idCatRawMaterial);
ALTER TABLE DetailSale ADD CONSTRAINT FK_DetailSale_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);
ALTER TABLE DetailSale ADD CONSTRAINT FK_DetailSale_CatSale FOREIGN KEY (fkCatSale) REFERENCES CatSale(idCatSale);
ALTER TABLE CatSale ADD CONSTRAINT FK_CatSale_CatClient FOREIGN KEY (fkCatClient) REFERENCES CatClient(idCatClient);
ALTER TABLE CatShipment ADD CONSTRAINT FK_CatShipment_CatSale FOREIGN KEY (fkCatSale) REFERENCES CatSale(idCatSale);
ALTER TABLE CatShipment ADD CONSTRAINT FK_CatShipment_CatEmployee FOREIGN KEY (fkCatEmployee) REFERENCES CatEmployee(idCatEmployee);
ALTER TABLE CatRecipe ADD CONSTRAINT FK_CatRecipe_CatSize FOREIGN KEY (fkCatSize) REFERENCES CatSize(idCatSize);
ALTER TABLE DetailRecipeColor ADD CONSTRAINT FK_DetailRecipeColor_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);
ALTER TABLE DetailRecipeColor ADD CONSTRAINT FK_DetailRecipeColor_CatColor FOREIGN KEY (fkCatColor) REFERENCES CatColor(idCatColor);
GO


