
-- ----------------------------
-- Table structure for __EFMigrationsHistory
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[__EFMigrationsHistory]') AND type IN ('U'))
	DROP TABLE [dbo].[__EFMigrationsHistory]
GO

CREATE TABLE [dbo].[__EFMigrationsHistory] (
  [MigrationId] nvarchar(150) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ProductVersion] nvarchar(32) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[__EFMigrationsHistory] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of __EFMigrationsHistory
-- ----------------------------
INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230729021656_Start', N'7.0.9')
GO

INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230730054004_recipe', N'7.0.9')
GO

INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230730055028_deliteCatSock', N'7.0.9')
GO


-- ----------------------------
-- Table structure for AspNetRoleClaims
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetRoleClaims]
GO

CREATE TABLE [dbo].[AspNetRoleClaims] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [RoleId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ClaimType] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ClaimValue] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[AspNetRoleClaims] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetRoleClaims
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AspNetRoleClaims] ON
GO

SET IDENTITY_INSERT [dbo].[AspNetRoleClaims] OFF
GO


-- ----------------------------
-- Table structure for AspNetRoles
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetRoles]
GO

CREATE TABLE [dbo].[AspNetRoles] (
  [Id] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Name] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [ConcurrencyStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[AspNetRoles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetRoles
-- ----------------------------
INSERT INTO [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e', N'Client', N'CLIENT', N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e')
GO

INSERT INTO [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'c309fa92-2123-47be-b397-a1c77adb502c', N'Admin', N'ADMIN', N'c309fa92-2123-47be-b397-a1c77adb502c')
GO

INSERT INTO [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'c309fa92-2123-47be-b397-adfdgdfg3344', N'Employee', N'EMPLOYEE', N'c309fa92-2123-47be-b397-adfdgdfg3344')
GO


-- ----------------------------
-- Table structure for AspNetUserClaims
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetUserClaims]
GO

CREATE TABLE [dbo].[AspNetUserClaims] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ClaimType] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ClaimValue] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[AspNetUserClaims] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetUserClaims
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AspNetUserClaims] ON
GO

SET IDENTITY_INSERT [dbo].[AspNetUserClaims] OFF
GO


-- ----------------------------
-- Table structure for AspNetUserLogins
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetUserLogins]
GO

CREATE TABLE [dbo].[AspNetUserLogins] (
  [LoginProvider] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ProviderKey] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ProviderDisplayName] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[AspNetUserLogins] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetUserLogins
-- ----------------------------

-- ----------------------------
-- Table structure for AspNetUserRoles
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetUserRoles]
GO

CREATE TABLE [dbo].[AspNetUserRoles] (
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [RoleId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[AspNetUserRoles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetUserRoles
-- ----------------------------

-- ----------------------------
-- Table structure for AspNetUsers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetUsers]
GO

CREATE TABLE [dbo].[AspNetUsers] (
  [Id] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [UserName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedUserName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [Email] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedEmail] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [EmailConfirmed] bit  NOT NULL,
  [PasswordHash] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [SecurityStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ConcurrencyStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [PhoneNumber] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [PhoneNumberConfirmed] bit  NOT NULL,
  [TwoFactorEnabled] bit  NOT NULL,
  [LockoutEnd] datetimeoffset(7)  NULL,
  [LockoutEnabled] bit  NOT NULL,
  [AccessFailedCount] int  NOT NULL
)
GO

ALTER TABLE [dbo].[AspNetUsers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetUsers
-- ----------------------------

-- ----------------------------
-- Table structure for AspNetUserTokens
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserTokens]') AND type IN ('U'))
	DROP TABLE [dbo].[AspNetUserTokens]
GO

CREATE TABLE [dbo].[AspNetUserTokens] (
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [LoginProvider] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Name] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Value] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[AspNetUserTokens] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of AspNetUserTokens
-- ----------------------------

-- ----------------------------
-- Table structure for CatClient
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatClient]') AND type IN ('U'))
	DROP TABLE [dbo].[CatClient]
GO

CREATE TABLE [dbo].[CatClient] (
  [idCatClient] int  IDENTITY(1,1) NOT NULL,
  [fkCatPerson] int  NOT NULL,
  [fkUser] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [fkRol] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[CatClient] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatClient
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatClient] ON
GO

SET IDENTITY_INSERT [dbo].[CatClient] OFF
GO


-- ----------------------------
-- Table structure for CatColor
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatColor]') AND type IN ('U'))
	DROP TABLE [dbo].[CatColor]
GO

CREATE TABLE [dbo].[CatColor] (
  [idCatColor] int  IDENTITY(1,1) NOT NULL,
  [description] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [hexadecimal] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL
)
GO

ALTER TABLE [dbo].[CatColor] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatColor
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatColor] ON
GO

SET IDENTITY_INSERT [dbo].[CatColor] OFF
GO


-- ----------------------------
-- Table structure for CatEmployee
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatEmployee]') AND type IN ('U'))
	DROP TABLE [dbo].[CatEmployee]
GO

CREATE TABLE [dbo].[CatEmployee] (
  [idCatEmployee] int  IDENTITY(1,1) NOT NULL,
  [fkCatPerson] int  NOT NULL,
  [fkUser] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [fkRol] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[CatEmployee] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatEmployee
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatEmployee] ON
GO

SET IDENTITY_INSERT [dbo].[CatEmployee] OFF
GO


-- ----------------------------
-- Table structure for CatPerson
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatPerson]') AND type IN ('U'))
	DROP TABLE [dbo].[CatPerson]
GO

CREATE TABLE [dbo].[CatPerson] (
  [idCatPerson] int  IDENTITY(1,1) NOT NULL,
  [name] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [lastName] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [middleName] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NULL,
  [phone] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [postalCode] int  NOT NULL,
  [streetNumber] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [apartmentNumber] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NULL,
  [street] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [neighborhood] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL
)
GO

ALTER TABLE [dbo].[CatPerson] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatPerson
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatPerson] ON
GO

SET IDENTITY_INSERT [dbo].[CatPerson] OFF
GO


-- ----------------------------
-- Table structure for CatPurchase
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatPurchase]') AND type IN ('U'))
	DROP TABLE [dbo].[CatPurchase]
GO

CREATE TABLE [dbo].[CatPurchase] (
  [idCatPurchase] int  IDENTITY(1,1) NOT NULL,
  [total] real  NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [fkCatSupplier] int  NOT NULL,
  [fkCatEmployee] int  NOT NULL
)
GO

ALTER TABLE [dbo].[CatPurchase] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatPurchase
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatPurchase] ON
GO

SET IDENTITY_INSERT [dbo].[CatPurchase] OFF
GO


-- ----------------------------
-- Table structure for CatRawMaterial
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatRawMaterial]') AND type IN ('U'))
	DROP TABLE [dbo].[CatRawMaterial]
GO

CREATE TABLE [dbo].[CatRawMaterial] (
  [idCatRawMaterial] int  IDENTITY(1,1) NOT NULL,
  [name] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [quantityWarehouse] int DEFAULT 0 NOT NULL,
  [quantityPackage] int  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [fkCatUnitMeasure] int  NOT NULL
)
GO

ALTER TABLE [dbo].[CatRawMaterial] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatRawMaterial
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatRawMaterial] ON
GO

SET IDENTITY_INSERT [dbo].[CatRawMaterial] OFF
GO


-- ----------------------------
-- Table structure for CatRecipe
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatRecipe]') AND type IN ('U'))
	DROP TABLE [dbo].[CatRecipe]
GO

CREATE TABLE [dbo].[CatRecipe] (
  [idCatRecipe] int  IDENTITY(1,1) NOT NULL,
  [name] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [imagePath] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [fkCatSize] int  NOT NULL,
  [price] real DEFAULT CONVERT([real],(0)) NOT NULL,
  [quantityStock] int DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[CatRecipe] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatRecipe
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatRecipe] ON
GO

SET IDENTITY_INSERT [dbo].[CatRecipe] OFF
GO


-- ----------------------------
-- Table structure for CatSale
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSale]') AND type IN ('U'))
	DROP TABLE [dbo].[CatSale]
GO

CREATE TABLE [dbo].[CatSale] (
  [idCatSale] int  IDENTITY(1,1) NOT NULL,
  [total] real  NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [fkCatClient] int  NOT NULL
)
GO

ALTER TABLE [dbo].[CatSale] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatSale
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatSale] ON
GO

SET IDENTITY_INSERT [dbo].[CatSale] OFF
GO


-- ----------------------------
-- Table structure for CatShipment
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatShipment]') AND type IN ('U'))
	DROP TABLE [dbo].[CatShipment]
GO

CREATE TABLE [dbo].[CatShipment] (
  [idCatShipment] int  IDENTITY(1,1) NOT NULL,
  [delivered] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [fkCatSale] int  NOT NULL,
  [fkCatEmployee] int  NOT NULL
)
GO

ALTER TABLE [dbo].[CatShipment] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatShipment
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatShipment] ON
GO

SET IDENTITY_INSERT [dbo].[CatShipment] OFF
GO


-- ----------------------------
-- Table structure for CatSize
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSize]') AND type IN ('U'))
	DROP TABLE [dbo].[CatSize]
GO

CREATE TABLE [dbo].[CatSize] (
  [idCatSize] int  IDENTITY(1,1) NOT NULL,
  [description] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [abbreviation] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL
)
GO

ALTER TABLE [dbo].[CatSize] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatSize
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatSize] ON
GO

SET IDENTITY_INSERT [dbo].[CatSize] OFF
GO


-- ----------------------------
-- Table structure for CatSupplier
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSupplier]') AND type IN ('U'))
	DROP TABLE [dbo].[CatSupplier]
GO

CREATE TABLE [dbo].[CatSupplier] (
  [idCatSupplier] int  IDENTITY(1,1) NOT NULL,
  [email] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [fkCatPerson] int  NOT NULL
)
GO

ALTER TABLE [dbo].[CatSupplier] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatSupplier
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatSupplier] ON
GO

SET IDENTITY_INSERT [dbo].[CatSupplier] OFF
GO


-- ----------------------------
-- Table structure for CatUnitMeasure
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CatUnitMeasure]') AND type IN ('U'))
	DROP TABLE [dbo].[CatUnitMeasure]
GO

CREATE TABLE [dbo].[CatUnitMeasure] (
  [idCatUnitMeasure] int  IDENTITY(1,1) NOT NULL,
  [description] nvarchar(255) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [status] bit DEFAULT CONVERT([bit],(1)) NOT NULL,
  [creationDate] datetime2(7) DEFAULT getdate() NOT NULL,
  [updateDate] datetime2(7) DEFAULT getdate() NOT NULL
)
GO

ALTER TABLE [dbo].[CatUnitMeasure] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of CatUnitMeasure
-- ----------------------------
SET IDENTITY_INSERT [dbo].[CatUnitMeasure] ON
GO

SET IDENTITY_INSERT [dbo].[CatUnitMeasure] OFF
GO


-- ----------------------------
-- Table structure for DetailPurchase
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[DetailPurchase]') AND type IN ('U'))
	DROP TABLE [dbo].[DetailPurchase]
GO

CREATE TABLE [dbo].[DetailPurchase] (
  [idDetailPurchase] int  IDENTITY(1,1) NOT NULL,
  [quantity] int  NOT NULL,
  [price] real  NOT NULL,
  [fkCatRawMaterial] int  NOT NULL,
  [fkCatPurchase] int  NOT NULL
)
GO

ALTER TABLE [dbo].[DetailPurchase] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of DetailPurchase
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DetailPurchase] ON
GO

SET IDENTITY_INSERT [dbo].[DetailPurchase] OFF
GO


-- ----------------------------
-- Table structure for DetailRecipeColor
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[DetailRecipeColor]') AND type IN ('U'))
	DROP TABLE [dbo].[DetailRecipeColor]
GO

CREATE TABLE [dbo].[DetailRecipeColor] (
  [idDetailRecipeColor] int  IDENTITY(1,1) NOT NULL,
  [fkCatRecipe] int  NOT NULL,
  [fkCatColor] int  NOT NULL
)
GO

ALTER TABLE [dbo].[DetailRecipeColor] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of DetailRecipeColor
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DetailRecipeColor] ON
GO

SET IDENTITY_INSERT [dbo].[DetailRecipeColor] OFF
GO


-- ----------------------------
-- Table structure for DetailRecipeRawMaterial
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[DetailRecipeRawMaterial]') AND type IN ('U'))
	DROP TABLE [dbo].[DetailRecipeRawMaterial]
GO

CREATE TABLE [dbo].[DetailRecipeRawMaterial] (
  [idDetailRecipeRawMaterial] int  IDENTITY(1,1) NOT NULL,
  [quantity] int  NOT NULL,
  [fkCatRecipe] int  NOT NULL,
  [fkCatRawMaterial] int  NOT NULL
)
GO

ALTER TABLE [dbo].[DetailRecipeRawMaterial] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of DetailRecipeRawMaterial
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DetailRecipeRawMaterial] ON
GO

SET IDENTITY_INSERT [dbo].[DetailRecipeRawMaterial] OFF
GO


-- ----------------------------
-- Table structure for DetailSale
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[DetailSale]') AND type IN ('U'))
	DROP TABLE [dbo].[DetailSale]
GO

CREATE TABLE [dbo].[DetailSale] (
  [idDetailSale] int  IDENTITY(1,1) NOT NULL,
  [quantity] int  NOT NULL,
  [price] real  NOT NULL,
  [fkCatStock] int  NOT NULL,
  [fkCatSale] int  NOT NULL
)
GO

ALTER TABLE [dbo].[DetailSale] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of DetailSale
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DetailSale] ON
GO

SET IDENTITY_INSERT [dbo].[DetailSale] OFF
GO


-- ----------------------------
-- Primary Key structure for table __EFMigrationsHistory
-- ----------------------------
ALTER TABLE [dbo].[__EFMigrationsHistory] ADD CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for AspNetRoleClaims
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[AspNetRoleClaims]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table AspNetRoleClaims
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId]
ON [dbo].[AspNetRoleClaims] (
  [RoleId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table AspNetRoleClaims
-- ----------------------------
ALTER TABLE [dbo].[AspNetRoleClaims] ADD CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table AspNetRoles
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
ON [dbo].[AspNetRoles] (
  [NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
GO


-- ----------------------------
-- Primary Key structure for table AspNetRoles
-- ----------------------------
ALTER TABLE [dbo].[AspNetRoles] ADD CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for AspNetUserClaims
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[AspNetUserClaims]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table AspNetUserClaims
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId]
ON [dbo].[AspNetUserClaims] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table AspNetUserClaims
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table AspNetUserLogins
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId]
ON [dbo].[AspNetUserLogins] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table AspNetUserLogins
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider], [ProviderKey])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table AspNetUserRoles
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId]
ON [dbo].[AspNetUserRoles] (
  [RoleId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table AspNetUserRoles
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId], [RoleId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table AspNetUsers
-- ----------------------------
CREATE NONCLUSTERED INDEX [EmailIndex]
ON [dbo].[AspNetUsers] (
  [NormalizedEmail] ASC
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
ON [dbo].[AspNetUsers] (
  [NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
GO


-- ----------------------------
-- Primary Key structure for table AspNetUsers
-- ----------------------------
ALTER TABLE [dbo].[AspNetUsers] ADD CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table AspNetUserTokens
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED ([UserId], [LoginProvider], [Name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatClient
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatClient]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatClient
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatClient_fkCatPerson]
ON [dbo].[CatClient] (
  [fkCatPerson] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatClient_fkRol]
ON [dbo].[CatClient] (
  [fkRol] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatClient_fkUser]
ON [dbo].[CatClient] (
  [fkUser] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatClient
-- ----------------------------
ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [PK_CatClient] PRIMARY KEY CLUSTERED ([idCatClient])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatColor
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatColor]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table CatColor
-- ----------------------------
ALTER TABLE [dbo].[CatColor] ADD CONSTRAINT [PK_CatColor] PRIMARY KEY CLUSTERED ([idCatColor])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatEmployee
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatEmployee]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatEmployee
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatEmployee_fkCatPerson]
ON [dbo].[CatEmployee] (
  [fkCatPerson] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatEmployee_fkRol]
ON [dbo].[CatEmployee] (
  [fkRol] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatEmployee_fkUser]
ON [dbo].[CatEmployee] (
  [fkUser] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatEmployee
-- ----------------------------
ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [PK_CatEmployee] PRIMARY KEY CLUSTERED ([idCatEmployee])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatPerson
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatPerson]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table CatPerson
-- ----------------------------
ALTER TABLE [dbo].[CatPerson] ADD CONSTRAINT [PK_CatPerson] PRIMARY KEY CLUSTERED ([idCatPerson])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatPurchase
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatPurchase]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatPurchase
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatPurchase_fkCatEmployee]
ON [dbo].[CatPurchase] (
  [fkCatEmployee] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatPurchase_fkCatSupplier]
ON [dbo].[CatPurchase] (
  [fkCatSupplier] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatPurchase
-- ----------------------------
ALTER TABLE [dbo].[CatPurchase] ADD CONSTRAINT [PK_CatPurchase] PRIMARY KEY CLUSTERED ([idCatPurchase])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatRawMaterial
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatRawMaterial]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatRawMaterial
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatRawMaterial_fkCatUnitMeasure]
ON [dbo].[CatRawMaterial] (
  [fkCatUnitMeasure] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatRawMaterial
-- ----------------------------
ALTER TABLE [dbo].[CatRawMaterial] ADD CONSTRAINT [PK_CatRawMaterial] PRIMARY KEY CLUSTERED ([idCatRawMaterial])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatRecipe
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatRecipe]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatRecipe
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatRecipe_fkCatSize]
ON [dbo].[CatRecipe] (
  [fkCatSize] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatRecipe
-- ----------------------------
ALTER TABLE [dbo].[CatRecipe] ADD CONSTRAINT [PK_CatRecipe] PRIMARY KEY CLUSTERED ([idCatRecipe])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatSale
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatSale]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatSale
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatSale_fkCatClient]
ON [dbo].[CatSale] (
  [fkCatClient] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatSale
-- ----------------------------
ALTER TABLE [dbo].[CatSale] ADD CONSTRAINT [PK_CatSale] PRIMARY KEY CLUSTERED ([idCatSale])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatShipment
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatShipment]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatShipment
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatShipment_fkCatEmployee]
ON [dbo].[CatShipment] (
  [fkCatEmployee] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_CatShipment_fkCatSale]
ON [dbo].[CatShipment] (
  [fkCatSale] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatShipment
-- ----------------------------
ALTER TABLE [dbo].[CatShipment] ADD CONSTRAINT [PK_CatShipment] PRIMARY KEY CLUSTERED ([idCatShipment])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatSize
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatSize]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table CatSize
-- ----------------------------
ALTER TABLE [dbo].[CatSize] ADD CONSTRAINT [PK_CatSize] PRIMARY KEY CLUSTERED ([idCatSize])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatSupplier
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatSupplier]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CatSupplier
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CatSupplier_fkCatPerson]
ON [dbo].[CatSupplier] (
  [fkCatPerson] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CatSupplier
-- ----------------------------
ALTER TABLE [dbo].[CatSupplier] ADD CONSTRAINT [PK_CatSupplier] PRIMARY KEY CLUSTERED ([idCatSupplier])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CatUnitMeasure
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CatUnitMeasure]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table CatUnitMeasure
-- ----------------------------
ALTER TABLE [dbo].[CatUnitMeasure] ADD CONSTRAINT [PK_CatUnitMeasure] PRIMARY KEY CLUSTERED ([idCatUnitMeasure])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for DetailPurchase
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[DetailPurchase]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table DetailPurchase
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_DetailPurchase_fkCatPurchase]
ON [dbo].[DetailPurchase] (
  [fkCatPurchase] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_DetailPurchase_fkCatRawMaterial]
ON [dbo].[DetailPurchase] (
  [fkCatRawMaterial] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table DetailPurchase
-- ----------------------------
ALTER TABLE [dbo].[DetailPurchase] ADD CONSTRAINT [PK_DetailPurchase] PRIMARY KEY CLUSTERED ([idDetailPurchase])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for DetailRecipeColor
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[DetailRecipeColor]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table DetailRecipeColor
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_DetailRecipeColor_fkCatColor]
ON [dbo].[DetailRecipeColor] (
  [fkCatColor] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_DetailRecipeColor_fkCatRecipe]
ON [dbo].[DetailRecipeColor] (
  [fkCatRecipe] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table DetailRecipeColor
-- ----------------------------
ALTER TABLE [dbo].[DetailRecipeColor] ADD CONSTRAINT [PK_DetailRecipeColor] PRIMARY KEY CLUSTERED ([idDetailRecipeColor])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for DetailRecipeRawMaterial
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[DetailRecipeRawMaterial]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table DetailRecipeRawMaterial
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_DetailRecipeRawMaterial_fkCatRawMaterial]
ON [dbo].[DetailRecipeRawMaterial] (
  [fkCatRawMaterial] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_DetailRecipeRawMaterial_fkCatRecipe]
ON [dbo].[DetailRecipeRawMaterial] (
  [fkCatRecipe] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table DetailRecipeRawMaterial
-- ----------------------------
ALTER TABLE [dbo].[DetailRecipeRawMaterial] ADD CONSTRAINT [PK_DetailRecipeRawMaterial] PRIMARY KEY CLUSTERED ([idDetailRecipeRawMaterial])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for DetailSale
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[DetailSale]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table DetailSale
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_DetailSale_fkCatSale]
ON [dbo].[DetailSale] (
  [fkCatSale] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_DetailSale_fkCatStock]
ON [dbo].[DetailSale] (
  [fkCatStock] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table DetailSale
-- ----------------------------
ALTER TABLE [dbo].[DetailSale] ADD CONSTRAINT [PK_DetailSale] PRIMARY KEY CLUSTERED ([idDetailSale])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table AspNetRoleClaims
-- ----------------------------
ALTER TABLE [dbo].[AspNetRoleClaims] ADD CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table AspNetUserClaims
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table AspNetUserLogins
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table AspNetUserRoles
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table AspNetUserTokens
-- ----------------------------
ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatClient
-- ----------------------------
ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [FK_CatClient_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [FK_CatClient_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatClient] ADD CONSTRAINT [FK_CatClient_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [dbo].[CatPerson] ([idCatPerson]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatEmployee
-- ----------------------------
ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [FK_CatEmployee_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [FK_CatEmployee_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatEmployee] ADD CONSTRAINT [FK_CatEmployee_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [dbo].[CatPerson] ([idCatPerson]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatPurchase
-- ----------------------------
ALTER TABLE [dbo].[CatPurchase] ADD CONSTRAINT [FK_CatPurchase_CatSupplier_fkCatSupplier] FOREIGN KEY ([fkCatSupplier]) REFERENCES [dbo].[CatSupplier] ([idCatSupplier]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatPurchase] ADD CONSTRAINT [FK_CatPurchase_CatEmployee_fkCatEmployee] FOREIGN KEY ([fkCatEmployee]) REFERENCES [dbo].[CatEmployee] ([idCatEmployee]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatRawMaterial
-- ----------------------------
ALTER TABLE [dbo].[CatRawMaterial] ADD CONSTRAINT [FK_CatRawMaterial_CatUnitMeasure_fkCatUnitMeasure] FOREIGN KEY ([fkCatUnitMeasure]) REFERENCES [dbo].[CatUnitMeasure] ([idCatUnitMeasure]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatRecipe
-- ----------------------------
ALTER TABLE [dbo].[CatRecipe] ADD CONSTRAINT [FK_CatRecipe_CatSize_fkCatSize] FOREIGN KEY ([fkCatSize]) REFERENCES [dbo].[CatSize] ([idCatSize]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatSale
-- ----------------------------
ALTER TABLE [dbo].[CatSale] ADD CONSTRAINT [FK_CatSale_CatClient_fkCatClient] FOREIGN KEY ([fkCatClient]) REFERENCES [dbo].[CatClient] ([idCatClient]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatShipment
-- ----------------------------
ALTER TABLE [dbo].[CatShipment] ADD CONSTRAINT [FK_CatShipment_CatEmployee_fkCatEmployee] FOREIGN KEY ([fkCatEmployee]) REFERENCES [dbo].[CatEmployee] ([idCatEmployee]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[CatShipment] ADD CONSTRAINT [FK_CatShipment_CatSale_fkCatSale] FOREIGN KEY ([fkCatSale]) REFERENCES [dbo].[CatSale] ([idCatSale]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CatSupplier
-- ----------------------------
ALTER TABLE [dbo].[CatSupplier] ADD CONSTRAINT [FK_CatSupplier_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [dbo].[CatPerson] ([idCatPerson]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table DetailPurchase
-- ----------------------------
ALTER TABLE [dbo].[DetailPurchase] ADD CONSTRAINT [FK_DetailPurchase_CatPurchase_fkCatPurchase] FOREIGN KEY ([fkCatPurchase]) REFERENCES [dbo].[CatPurchase] ([idCatPurchase]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[DetailPurchase] ADD CONSTRAINT [FK_DetailPurchase_CatRawMaterial_fkCatRawMaterial] FOREIGN KEY ([fkCatRawMaterial]) REFERENCES [dbo].[CatRawMaterial] ([idCatRawMaterial]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table DetailRecipeColor
-- ----------------------------
ALTER TABLE [dbo].[DetailRecipeColor] ADD CONSTRAINT [FK_DetailRecipeColor_CatColor_fkCatColor] FOREIGN KEY ([fkCatColor]) REFERENCES [dbo].[CatColor] ([idCatColor]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[DetailRecipeColor] ADD CONSTRAINT [FK_DetailRecipeColor_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [dbo].[CatRecipe] ([idCatRecipe]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table DetailRecipeRawMaterial
-- ----------------------------
ALTER TABLE [dbo].[DetailRecipeRawMaterial] ADD CONSTRAINT [FK_DetailRecipeRawMaterial_CatRawMaterial_fkCatRawMaterial] FOREIGN KEY ([fkCatRawMaterial]) REFERENCES [dbo].[CatRawMaterial] ([idCatRawMaterial]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[DetailRecipeRawMaterial] ADD CONSTRAINT [FK_DetailRecipeRawMaterial_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [dbo].[CatRecipe] ([idCatRecipe]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table DetailSale
-- ----------------------------
ALTER TABLE [dbo].[DetailSale] ADD CONSTRAINT [FK_DetailSale_CatSale_fkCatSale] FOREIGN KEY ([fkCatSale]) REFERENCES [dbo].[CatSale] ([idCatSale]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[DetailSale] ADD CONSTRAINT [FK_DetailSale_CatRecipe_fkCatStock] FOREIGN KEY ([fkCatStock]) REFERENCES [dbo].[CatRecipe] ([idCatRecipe]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

