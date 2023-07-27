﻿using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class s : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    SecurityStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "bit", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "bit", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "CatPerson",
                columns: table => new
                {
                    idCatPerson = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    lastName = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    middleName = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    phone = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    postalCode = table.Column<int>(type: "int", nullable: false),
                    streetNumber = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    apartmentNumber = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    street = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    neighborhood = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatPerson", x => x.idCatPerson);
                });

            migrationBuilder.CreateTable(
                name: "CatRecipe",
                columns: table => new
                {
                    idCatRecipe = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    price = table.Column<float>(type: "real", nullable: false),
                    imagePath = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatRecipe", x => x.idCatRecipe);
                });

            migrationBuilder.CreateTable(
                name: "CatUnitMeasure",
                columns: table => new
                {
                    idCatUnitMeasure = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    description = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatUnitMeasure", x => x.idCatUnitMeasure);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ProviderKey = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    LoginProvider = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Value = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatClient",
                columns: table => new
                {
                    idCatClient = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    fkCatPerson = table.Column<int>(type: "int", nullable: false),
                    fkUser = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatClient", x => x.idCatClient);
                    table.ForeignKey(
                        name: "FK_CatClient_AspNetUsers_fkUser",
                        column: x => x.fkUser,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CatClient_CatPerson_fkCatPerson",
                        column: x => x.fkCatPerson,
                        principalTable: "CatPerson",
                        principalColumn: "idCatPerson",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatEmployee",
                columns: table => new
                {
                    idCatEmployee = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    fkCatPerson = table.Column<int>(type: "int", nullable: false),
                    fkUser = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatEmployee", x => x.idCatEmployee);
                    table.ForeignKey(
                        name: "FK_CatEmployee_AspNetUsers_fkUser",
                        column: x => x.fkUser,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CatEmployee_CatPerson_fkCatPerson",
                        column: x => x.fkCatPerson,
                        principalTable: "CatPerson",
                        principalColumn: "idCatPerson",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatSupplier",
                columns: table => new
                {
                    idCatSupplier = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    email = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    fkCatPerson = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatSupplier", x => x.idCatSupplier);
                    table.ForeignKey(
                        name: "FK_CatSupplier_CatPerson_fkCatPerson",
                        column: x => x.fkCatPerson,
                        principalTable: "CatPerson",
                        principalColumn: "idCatPerson",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatStock",
                columns: table => new
                {
                    idCatStock = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    price = table.Column<float>(type: "real", nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    fkCatRecipe = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatStock", x => x.idCatStock);
                    table.ForeignKey(
                        name: "FK_CatStock_CatRecipe_fkCatRecipe",
                        column: x => x.fkCatRecipe,
                        principalTable: "CatRecipe",
                        principalColumn: "idCatRecipe",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatRawMaterial",
                columns: table => new
                {
                    idCatRawMaterial = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    quantityWarehouse = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    fkCatUnitMeasure = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatRawMaterial", x => x.idCatRawMaterial);
                    table.ForeignKey(
                        name: "FK_CatRawMaterial_CatUnitMeasure_fkCatUnitMeasure",
                        column: x => x.fkCatUnitMeasure,
                        principalTable: "CatUnitMeasure",
                        principalColumn: "idCatUnitMeasure",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatSale",
                columns: table => new
                {
                    idCatSale = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    total = table.Column<float>(type: "real", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    fkCatClient = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatSale", x => x.idCatSale);
                    table.ForeignKey(
                        name: "FK_CatSale_CatClient_fkCatClient",
                        column: x => x.fkCatClient,
                        principalTable: "CatClient",
                        principalColumn: "idCatClient",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatPurchase",
                columns: table => new
                {
                    idCatPurchase = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    total = table.Column<float>(type: "real", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    fkCatSupplier = table.Column<int>(type: "int", nullable: false),
                    fkCatEmployee = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatPurchase", x => x.idCatPurchase);
                    table.ForeignKey(
                        name: "FK_CatPurchase_CatEmployee_fkCatEmployee",
                        column: x => x.fkCatEmployee,
                        principalTable: "CatEmployee",
                        principalColumn: "idCatEmployee");
                    table.ForeignKey(
                        name: "FK_CatPurchase_CatSupplier_fkCatSupplier",
                        column: x => x.fkCatSupplier,
                        principalTable: "CatSupplier",
                        principalColumn: "idCatSupplier");
                });

            migrationBuilder.CreateTable(
                name: "CatWarehouse",
                columns: table => new
                {
                    idCatWarehouse = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    fkCatRawMaterial = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatWarehouse", x => x.idCatWarehouse);
                    table.ForeignKey(
                        name: "FK_CatWarehouse_CatRawMaterial_fkCatRawMaterial",
                        column: x => x.fkCatRawMaterial,
                        principalTable: "CatRawMaterial",
                        principalColumn: "idCatRawMaterial",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DetailRecipeRawMaterial",
                columns: table => new
                {
                    idDetailRecipeRawMaterial = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<float>(type: "real", nullable: false),
                    fkCatRecipe = table.Column<int>(type: "int", nullable: false),
                    fkCatRawMaterial = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailRecipeRawMaterial", x => x.idDetailRecipeRawMaterial);
                    table.ForeignKey(
                        name: "FK_DetailRecipeRawMaterial_CatRawMaterial_fkCatRawMaterial",
                        column: x => x.fkCatRawMaterial,
                        principalTable: "CatRawMaterial",
                        principalColumn: "idCatRawMaterial",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DetailRecipeRawMaterial_CatRecipe_fkCatRecipe",
                        column: x => x.fkCatRecipe,
                        principalTable: "CatRecipe",
                        principalColumn: "idCatRecipe",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CatShipment",
                columns: table => new
                {
                    idCatShipment = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    delivered = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    fkCatSale = table.Column<int>(type: "int", nullable: false),
                    fkCatEmployee = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatShipment", x => x.idCatShipment);
                    table.ForeignKey(
                        name: "FK_CatShipment_CatEmployee_fkCatEmployee",
                        column: x => x.fkCatEmployee,
                        principalTable: "CatEmployee",
                        principalColumn: "idCatEmployee");
                    table.ForeignKey(
                        name: "FK_CatShipment_CatSale_fkCatSale",
                        column: x => x.fkCatSale,
                        principalTable: "CatSale",
                        principalColumn: "idCatSale");
                });

            migrationBuilder.CreateTable(
                name: "DetailSale",
                columns: table => new
                {
                    idDetailSale = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<float>(type: "real", nullable: false),
                    price = table.Column<float>(type: "real", nullable: false),
                    fkCatStock = table.Column<int>(type: "int", nullable: false),
                    fkCatSale = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailSale", x => x.idDetailSale);
                    table.ForeignKey(
                        name: "FK_DetailSale_CatSale_fkCatSale",
                        column: x => x.fkCatSale,
                        principalTable: "CatSale",
                        principalColumn: "idCatSale",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DetailSale_CatStock_fkCatStock",
                        column: x => x.fkCatStock,
                        principalTable: "CatStock",
                        principalColumn: "idCatStock",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DetailPurchase",
                columns: table => new
                {
                    idDetailPurchase = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<float>(type: "real", nullable: false),
                    price = table.Column<float>(type: "real", nullable: false),
                    fkCatWarehouse = table.Column<int>(type: "int", nullable: false),
                    fkCatPurchase = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailPurchase", x => x.idDetailPurchase);
                    table.ForeignKey(
                        name: "FK_DetailPurchase_CatPurchase_fkCatPurchase",
                        column: x => x.fkCatPurchase,
                        principalTable: "CatPurchase",
                        principalColumn: "idCatPurchase",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DetailPurchase_CatWarehouse_fkCatWarehouse",
                        column: x => x.fkCatWarehouse,
                        principalTable: "CatWarehouse",
                        principalColumn: "idCatWarehouse",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true,
                filter: "[NormalizedName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true,
                filter: "[NormalizedUserName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_CatClient_fkCatPerson",
                table: "CatClient",
                column: "fkCatPerson");

            migrationBuilder.CreateIndex(
                name: "IX_CatClient_fkUser",
                table: "CatClient",
                column: "fkUser");

            migrationBuilder.CreateIndex(
                name: "IX_CatEmployee_fkCatPerson",
                table: "CatEmployee",
                column: "fkCatPerson");

            migrationBuilder.CreateIndex(
                name: "IX_CatEmployee_fkUser",
                table: "CatEmployee",
                column: "fkUser");

            migrationBuilder.CreateIndex(
                name: "IX_CatPurchase_fkCatEmployee",
                table: "CatPurchase",
                column: "fkCatEmployee");

            migrationBuilder.CreateIndex(
                name: "IX_CatPurchase_fkCatSupplier",
                table: "CatPurchase",
                column: "fkCatSupplier");

            migrationBuilder.CreateIndex(
                name: "IX_CatRawMaterial_fkCatUnitMeasure",
                table: "CatRawMaterial",
                column: "fkCatUnitMeasure");

            migrationBuilder.CreateIndex(
                name: "IX_CatSale_fkCatClient",
                table: "CatSale",
                column: "fkCatClient");

            migrationBuilder.CreateIndex(
                name: "IX_CatShipment_fkCatEmployee",
                table: "CatShipment",
                column: "fkCatEmployee");

            migrationBuilder.CreateIndex(
                name: "IX_CatShipment_fkCatSale",
                table: "CatShipment",
                column: "fkCatSale");

            migrationBuilder.CreateIndex(
                name: "IX_CatStock_fkCatRecipe",
                table: "CatStock",
                column: "fkCatRecipe");

            migrationBuilder.CreateIndex(
                name: "IX_CatSupplier_fkCatPerson",
                table: "CatSupplier",
                column: "fkCatPerson");

            migrationBuilder.CreateIndex(
                name: "IX_CatWarehouse_fkCatRawMaterial",
                table: "CatWarehouse",
                column: "fkCatRawMaterial");

            migrationBuilder.CreateIndex(
                name: "IX_DetailPurchase_fkCatPurchase",
                table: "DetailPurchase",
                column: "fkCatPurchase");

            migrationBuilder.CreateIndex(
                name: "IX_DetailPurchase_fkCatWarehouse",
                table: "DetailPurchase",
                column: "fkCatWarehouse");

            migrationBuilder.CreateIndex(
                name: "IX_DetailRecipeRawMaterial_fkCatRawMaterial",
                table: "DetailRecipeRawMaterial",
                column: "fkCatRawMaterial");

            migrationBuilder.CreateIndex(
                name: "IX_DetailRecipeRawMaterial_fkCatRecipe",
                table: "DetailRecipeRawMaterial",
                column: "fkCatRecipe");

            migrationBuilder.CreateIndex(
                name: "IX_DetailSale_fkCatSale",
                table: "DetailSale",
                column: "fkCatSale");

            migrationBuilder.CreateIndex(
                name: "IX_DetailSale_fkCatStock",
                table: "DetailSale",
                column: "fkCatStock");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "CatShipment");

            migrationBuilder.DropTable(
                name: "DetailPurchase");

            migrationBuilder.DropTable(
                name: "DetailRecipeRawMaterial");

            migrationBuilder.DropTable(
                name: "DetailSale");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "CatPurchase");

            migrationBuilder.DropTable(
                name: "CatWarehouse");

            migrationBuilder.DropTable(
                name: "CatSale");

            migrationBuilder.DropTable(
                name: "CatStock");

            migrationBuilder.DropTable(
                name: "CatEmployee");

            migrationBuilder.DropTable(
                name: "CatSupplier");

            migrationBuilder.DropTable(
                name: "CatRawMaterial");

            migrationBuilder.DropTable(
                name: "CatClient");

            migrationBuilder.DropTable(
                name: "CatRecipe");

            migrationBuilder.DropTable(
                name: "CatUnitMeasure");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "CatPerson");
        }
    }
}
