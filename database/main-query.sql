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


CREATE TABLE __EFMigrationsHistory (
  MigrationId nvarchar(150) COLLATE Modern_Spanish_CI_AS PRIMARY KEY NOT NULL,
  ProductVersion nvarchar(32) COLLATE Modern_Spanish_CI_AS NOT NULL
)

INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES (N'20230729021656_Start', N'7.0.9')
INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES (N'20230730054004_recipe', N'7.0.9')
INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES (N'20230730055028_deliteCatSock', N'7.0.9')

CREATE TABLE AspNetRoleClaims (
  Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  RoleId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  ClaimType nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  ClaimValue nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL
)

CREATE TABLE AspNetRoles (
  Id nvarchar(450) COLLATE Modern_Spanish_CI_AS PRIMARY KEY NOT NULL,
  Name nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  NormalizedName nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  ConcurrencyStamp nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL
)

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES (N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e', N'Client', N'CLIENT', N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e')
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES (N'c309fa92-2123-47be-b397-a1c77adb502c', N'Admin', N'ADMIN', N'c309fa92-2123-47be-b397-a1c77adb502c')
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES (N'c309fa92-2123-47be-b397-adfdgdfg3344', N'Employee', N'EMPLOYEE', N'c309fa92-2123-47be-b397-adfdgdfg3344')

CREATE TABLE AspNetUserClaims (
  Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  UserId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  ClaimType nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  ClaimValue nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL
)

CREATE TABLE AspNetUserLogins (
  LoginProvider nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  ProviderKey nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  ProviderDisplayName nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  UserId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
)

CREATE TABLE AspNetUserRoles (
  UserId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  RoleId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
)

CREATE TABLE AspNetUsers (
  Id nvarchar(450) COLLATE Modern_Spanish_CI_AS PRIMARY KEY NOT NULL,
  UserName nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  NormalizedUserName nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  Email nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  NormalizedEmail nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL,
  EmailConfirmed bit NOT NULL,
  PasswordHash nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  SecurityStamp nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  ConcurrencyStamp nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  PhoneNumber nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL,
  PhoneNumberConfirmed bit NOT NULL,
  TwoFactorEnabled bit NOT NULL,
  LockoutEnd datetimeoffset(7) NULL,
  LockoutEnabled bit NOT NULL,
  AccessFailedCount int NOT NULL
)

CREATE TABLE AspNetUserTokens (
  UserId nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  LoginProvider nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  Name nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  Value nvarchar(max) COLLATE Modern_Spanish_CI_AS NULL
)


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
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE CatClient (
  idCatClient INT IDENTITY(1,1) PRIMARY KEY,
  status BIT DEFAULT 1 NOT NULL,
  fkCatPerson INT NOT NULL,
  fkRol nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  fkUser nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
);
GO
CREATE TABLE CatSupplier (
  idCatSupplier INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  fkCatPerson INT NOT NULL
);
GO
CREATE TABLE CatEmployee (
  idCatEmployee INT IDENTITY(1,1) PRIMARY KEY,
  status BIT DEFAULT 1 NOT NULL,
  fkCatPerson INT NOT NULL,
  fkRol nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL,
  fkUser nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
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
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSize INT NOT NULL,
  fkCatImage INT
);
GO
CREATE TABLE HelperDateToRecipe (
  idHelperDatesToRecipe INT IDENTITY(1,1) PRIMARY KEY,
  quantity INT NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatRecipe INT NOT NULL
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
CREATE TABLE CatImage(
	IdCatImage int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FileName nvarchar(max) NOT NULL,
	FileExtension nvarchar(max) NOT NULL,
	FileSizeInBytes bigint NOT NULL,
	FilePath nvarchar(max) NOT NULL
);
GO

ALTER TABLE CatRawMaterial ADD CONSTRAINT FK_CatRawMaterial_CatUnitMeasure FOREIGN KEY (fkCatUnitMeasure) REFERENCES CatUnitMeasure(idCatUnitMeasure);
ALTER TABLE CatClient ADD CONSTRAINT FK_CatClient_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatSupplier ADD CONSTRAINT FK_CatSupplier_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatEmployee ADD CONSTRAINT FK_CatEmployee_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
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
ALTER TABLE HelperDateToRecipe ADD CONSTRAINT FK_HelperDateToRecipe_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);

GO
ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [FK_CatClient_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [FK_CatClient_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [FK_CatEmployee_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [FK_CatEmployee_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[AspNetRoleClaims] ADD CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider], [ProviderKey])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId], [RoleId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED ([UserId], [LoginProvider], [Name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

ALTER TABLE CatRecipe ADD CONSTRAINT FK_CatRecipe_CatImage FOREIGN KEY (fkCatImage) REFERENCES CatImage(IdCatImage);
GO
