IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [CatColor] (
    [idCatColor] int NOT NULL IDENTITY,
    [description] nvarchar(255) NOT NULL,
    [hexadecimal] nvarchar(255) NOT NULL,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CatColor] PRIMARY KEY ([idCatColor])
);
GO

CREATE TABLE [CatImage] (
    [IdCatImage] int NOT NULL IDENTITY,
    [FileName] nvarchar(max) NOT NULL,
    [FileExtension] nvarchar(max) NOT NULL,
    [FileSizeInBytes] bigint NOT NULL,
    [FilePath] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_CatImage] PRIMARY KEY ([IdCatImage])
);
GO

CREATE TABLE [CatPerson] (
    [idCatPerson] int NOT NULL IDENTITY,
    [name] nvarchar(255) NOT NULL,
    [lastName] nvarchar(255) NOT NULL,
    [middleName] nvarchar(255) NULL,
    [phone] nvarchar(255) NOT NULL,
    [postalCode] int NOT NULL,
    [streetNumber] nvarchar(255) NOT NULL,
    [apartmentNumber] nvarchar(255) NULL,
    [street] nvarchar(255) NOT NULL,
    [neighborhood] nvarchar(255) NOT NULL,
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CatPerson] PRIMARY KEY ([idCatPerson])
);
GO

CREATE TABLE [CatSize] (
    [idCatSize] int NOT NULL IDENTITY,
    [description] nvarchar(255) NOT NULL,
    [abbreviation] nvarchar(255) NOT NULL,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CatSize] PRIMARY KEY ([idCatSize])
);
GO

CREATE TABLE [CatUnitMeasure] (
    [idCatUnitMeasure] int NOT NULL IDENTITY,
    [description] nvarchar(255) NOT NULL,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CatUnitMeasure] PRIMARY KEY ([idCatUnitMeasure])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatClient] (
    [idCatClient] int NOT NULL IDENTITY,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [fkCatPerson] int NOT NULL,
    [fkUser] nvarchar(450) NOT NULL,
    [fkRol] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_CatClient] PRIMARY KEY ([idCatClient]),
    CONSTRAINT [FK_CatClient_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CatClient_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CatClient_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [CatPerson] ([idCatPerson]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatEmployee] (
    [idCatEmployee] int NOT NULL IDENTITY,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [fkCatPerson] int NOT NULL,
    [fkUser] nvarchar(450) NOT NULL,
    [fkRol] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_CatEmployee] PRIMARY KEY ([idCatEmployee]),
    CONSTRAINT [FK_CatEmployee_AspNetRoles_fkRol] FOREIGN KEY ([fkRol]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CatEmployee_AspNetUsers_fkUser] FOREIGN KEY ([fkUser]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CatEmployee_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [CatPerson] ([idCatPerson]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatSupplier] (
    [idCatSupplier] int NOT NULL IDENTITY,
    [email] nvarchar(255) NOT NULL,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [fkCatPerson] int NOT NULL,
    CONSTRAINT [PK_CatSupplier] PRIMARY KEY ([idCatSupplier]),
    CONSTRAINT [FK_CatSupplier_CatPerson_fkCatPerson] FOREIGN KEY ([fkCatPerson]) REFERENCES [CatPerson] ([idCatPerson]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatRecipe] (
    [idCatRecipe] int NOT NULL IDENTITY,
    [name] nvarchar(255) NOT NULL,
    [price] real NOT NULL,
    [quantityStock] int NOT NULL DEFAULT 0,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [fkCatSize] int NOT NULL,
    [fkCatImage] int NULL,
    CONSTRAINT [PK_CatRecipe] PRIMARY KEY ([idCatRecipe]),
    CONSTRAINT [FK_CatRecipe_CatImage_fkCatImage] FOREIGN KEY ([fkCatImage]) REFERENCES [CatImage] ([IdCatImage]),
    CONSTRAINT [FK_CatRecipe_CatSize_fkCatSize] FOREIGN KEY ([fkCatSize]) REFERENCES [CatSize] ([idCatSize]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatRawMaterial] (
    [idCatRawMaterial] int NOT NULL IDENTITY,
    [name] nvarchar(255) NOT NULL,
    [quantityWarehouse] int NOT NULL DEFAULT 0,
    [quantityPackage] int NOT NULL,
    [status] bit NOT NULL DEFAULT CAST(1 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [fkCatUnitMeasure] int NOT NULL,
    CONSTRAINT [PK_CatRawMaterial] PRIMARY KEY ([idCatRawMaterial]),
    CONSTRAINT [FK_CatRawMaterial_CatUnitMeasure_fkCatUnitMeasure] FOREIGN KEY ([fkCatUnitMeasure]) REFERENCES [CatUnitMeasure] ([idCatUnitMeasure]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatSale] (
    [idCatSale] int NOT NULL IDENTITY,
    [total] real NOT NULL,
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [fkCatClient] int NOT NULL,
    CONSTRAINT [PK_CatSale] PRIMARY KEY ([idCatSale]),
    CONSTRAINT [FK_CatSale_CatClient_fkCatClient] FOREIGN KEY ([fkCatClient]) REFERENCES [CatClient] ([idCatClient]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatPurchase] (
    [idCatPurchase] int NOT NULL IDENTITY,
    [total] real NOT NULL,
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [fkCatSupplier] int NOT NULL,
    [fkCatEmployee] int NOT NULL,
    CONSTRAINT [PK_CatPurchase] PRIMARY KEY ([idCatPurchase]),
    CONSTRAINT [FK_CatPurchase_CatEmployee_fkCatEmployee] FOREIGN KEY ([fkCatEmployee]) REFERENCES [CatEmployee] ([idCatEmployee]),
    CONSTRAINT [FK_CatPurchase_CatSupplier_fkCatSupplier] FOREIGN KEY ([fkCatSupplier]) REFERENCES [CatSupplier] ([idCatSupplier])
);
GO

CREATE TABLE [DetailRecipeColor] (
    [idDetailRecipeColor] int NOT NULL IDENTITY,
    [fkCatRecipe] int NOT NULL,
    [fkCatColor] int NOT NULL,
    CONSTRAINT [PK_DetailRecipeColor] PRIMARY KEY ([idDetailRecipeColor]),
    CONSTRAINT [FK_DetailRecipeColor_CatColor_fkCatColor] FOREIGN KEY ([fkCatColor]) REFERENCES [CatColor] ([idCatColor]) ON DELETE CASCADE,
    CONSTRAINT [FK_DetailRecipeColor_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [CatRecipe] ([idCatRecipe]) ON DELETE CASCADE
);
GO

CREATE TABLE [HelperDateToRecipe] (
    [idHelperDatesToRecipe] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [creationDate] datetime2 NOT NULL,
    [fkCatRecipe] int NOT NULL,
    CONSTRAINT [PK_HelperDateToRecipe] PRIMARY KEY ([idHelperDatesToRecipe]),
    CONSTRAINT [FK_HelperDateToRecipe_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [CatRecipe] ([idCatRecipe]) ON DELETE CASCADE
);
GO

CREATE TABLE [DetailRecipeRawMaterial] (
    [idDetailRecipeRawMaterial] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [fkCatRecipe] int NOT NULL,
    [fkCatRawMaterial] int NOT NULL,
    CONSTRAINT [PK_DetailRecipeRawMaterial] PRIMARY KEY ([idDetailRecipeRawMaterial]),
    CONSTRAINT [FK_DetailRecipeRawMaterial_CatRawMaterial_fkCatRawMaterial] FOREIGN KEY ([fkCatRawMaterial]) REFERENCES [CatRawMaterial] ([idCatRawMaterial]) ON DELETE CASCADE,
    CONSTRAINT [FK_DetailRecipeRawMaterial_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [CatRecipe] ([idCatRecipe]) ON DELETE CASCADE
);
GO

CREATE TABLE [CatShipment] (
    [idCatShipment] int NOT NULL IDENTITY,
    [delivered] bit NOT NULL DEFAULT CAST(0 AS bit),
    [creationDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [updateDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [fkCatSale] int NOT NULL,
    [fkCatEmployee] int NOT NULL,
    CONSTRAINT [PK_CatShipment] PRIMARY KEY ([idCatShipment]),
    CONSTRAINT [FK_CatShipment_CatEmployee_fkCatEmployee] FOREIGN KEY ([fkCatEmployee]) REFERENCES [CatEmployee] ([idCatEmployee]),
    CONSTRAINT [FK_CatShipment_CatSale_fkCatSale] FOREIGN KEY ([fkCatSale]) REFERENCES [CatSale] ([idCatSale])
);
GO

CREATE TABLE [DetailSale] (
    [idDetailSale] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [price] real NOT NULL,
    [fkCatRecipe] int NOT NULL,
    [fkCatSale] int NOT NULL,
    CONSTRAINT [PK_DetailSale] PRIMARY KEY ([idDetailSale]),
    CONSTRAINT [FK_DetailSale_CatRecipe_fkCatRecipe] FOREIGN KEY ([fkCatRecipe]) REFERENCES [CatRecipe] ([idCatRecipe]) ON DELETE CASCADE,
    CONSTRAINT [FK_DetailSale_CatSale_fkCatSale] FOREIGN KEY ([fkCatSale]) REFERENCES [CatSale] ([idCatSale]) ON DELETE CASCADE
);
GO

CREATE TABLE [DetailPurchase] (
    [idDetailPurchase] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [price] real NOT NULL,
    [fkCatRawMaterial] int NOT NULL,
    [fkCatPurchase] int NOT NULL,
    CONSTRAINT [PK_DetailPurchase] PRIMARY KEY ([idDetailPurchase]),
    CONSTRAINT [FK_DetailPurchase_CatPurchase_fkCatPurchase] FOREIGN KEY ([fkCatPurchase]) REFERENCES [CatPurchase] ([idCatPurchase]) ON DELETE CASCADE,
    CONSTRAINT [FK_DetailPurchase_CatRawMaterial_fkCatRawMaterial] FOREIGN KEY ([fkCatRawMaterial]) REFERENCES [CatRawMaterial] ([idCatRawMaterial]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e', N'a71a55d6-99d7-4123-b4e0-1218ecb90e3e', N'Client', N'CLIENT'),
(N'c309fa92-2123-47be-b397-a1c77adb502c', N'c309fa92-2123-47be-b397-a1c77adb502c', N'Admin', N'ADMIN'),
(N'c309fa92-2123-47be-b397-adfdgdfg3344', N'c309fa92-2123-47be-b397-adfdgdfg3344', N'Employee', N'EMPLOYEE');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_CatClient_fkCatPerson] ON [CatClient] ([fkCatPerson]);
GO

CREATE INDEX [IX_CatClient_fkRol] ON [CatClient] ([fkRol]);
GO

CREATE INDEX [IX_CatClient_fkUser] ON [CatClient] ([fkUser]);
GO

CREATE INDEX [IX_CatEmployee_fkCatPerson] ON [CatEmployee] ([fkCatPerson]);
GO

CREATE INDEX [IX_CatEmployee_fkRol] ON [CatEmployee] ([fkRol]);
GO

CREATE INDEX [IX_CatEmployee_fkUser] ON [CatEmployee] ([fkUser]);
GO

CREATE INDEX [IX_CatPurchase_fkCatEmployee] ON [CatPurchase] ([fkCatEmployee]);
GO

CREATE INDEX [IX_CatPurchase_fkCatSupplier] ON [CatPurchase] ([fkCatSupplier]);
GO

CREATE INDEX [IX_CatRawMaterial_fkCatUnitMeasure] ON [CatRawMaterial] ([fkCatUnitMeasure]);
GO

CREATE INDEX [IX_CatRecipe_fkCatImage] ON [CatRecipe] ([fkCatImage]);
GO

CREATE INDEX [IX_CatRecipe_fkCatSize] ON [CatRecipe] ([fkCatSize]);
GO

CREATE INDEX [IX_CatSale_fkCatClient] ON [CatSale] ([fkCatClient]);
GO

CREATE INDEX [IX_CatShipment_fkCatEmployee] ON [CatShipment] ([fkCatEmployee]);
GO

CREATE INDEX [IX_CatShipment_fkCatSale] ON [CatShipment] ([fkCatSale]);
GO

CREATE INDEX [IX_CatSupplier_fkCatPerson] ON [CatSupplier] ([fkCatPerson]);
GO

CREATE INDEX [IX_DetailPurchase_fkCatPurchase] ON [DetailPurchase] ([fkCatPurchase]);
GO

CREATE INDEX [IX_DetailPurchase_fkCatRawMaterial] ON [DetailPurchase] ([fkCatRawMaterial]);
GO

CREATE INDEX [IX_DetailRecipeColor_fkCatColor] ON [DetailRecipeColor] ([fkCatColor]);
GO

CREATE INDEX [IX_DetailRecipeColor_fkCatRecipe] ON [DetailRecipeColor] ([fkCatRecipe]);
GO

CREATE INDEX [IX_DetailRecipeRawMaterial_fkCatRawMaterial] ON [DetailRecipeRawMaterial] ([fkCatRawMaterial]);
GO

CREATE INDEX [IX_DetailRecipeRawMaterial_fkCatRecipe] ON [DetailRecipeRawMaterial] ([fkCatRecipe]);
GO

CREATE INDEX [IX_DetailSale_fkCatRecipe] ON [DetailSale] ([fkCatRecipe]);
GO

CREATE INDEX [IX_DetailSale_fkCatSale] ON [DetailSale] ([fkCatSale]);
GO

CREATE INDEX [IX_HelperDateToRecipe_fkCatRecipe] ON [HelperDateToRecipe] ([fkCatRecipe]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230814043702_Start', N'7.0.10');
GO

COMMIT;
GO

