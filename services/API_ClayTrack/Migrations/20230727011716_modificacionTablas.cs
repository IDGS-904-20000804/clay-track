using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class modificacionTablas : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailPurchase_CatWarehouse_fkCatWarehouse",
                table: "DetailPurchase");

            migrationBuilder.DropTable(
                name: "CatWarehouse");

            migrationBuilder.RenameColumn(
                name: "fkCatWarehouse",
                table: "DetailPurchase",
                newName: "fkCatRawMaterial");

            migrationBuilder.RenameIndex(
                name: "IX_DetailPurchase_fkCatWarehouse",
                table: "DetailPurchase",
                newName: "IX_DetailPurchase_fkCatRawMaterial");

            migrationBuilder.AddColumn<int>(
                name: "fkCatSize",
                table: "CatRecipe",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<int>(
                name: "quantityWarehouse",
                table: "CatRawMaterial",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateTable(
                name: "CatColor",
                columns: table => new
                {
                    idCatColor = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatColor", x => x.idCatColor);
                });

            migrationBuilder.CreateTable(
                name: "CatSize",
                columns: table => new
                {
                    idCatSize = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CatSize", x => x.idCatSize);
                });

            migrationBuilder.CreateTable(
                name: "DetailRawMaterialColor",
                columns: table => new
                {
                    idDetailRawMaterialColor = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailRawMaterialColor", x => x.idDetailRawMaterialColor);
                });

            migrationBuilder.CreateTable(
                name: "DetailRecipeColor",
                columns: table => new
                {
                    idDetailRecipeColor = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailRecipeColor", x => x.idDetailRecipeColor);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CatRecipe_fkCatSize",
                table: "CatRecipe",
                column: "fkCatSize");

            migrationBuilder.AddForeignKey(
                name: "FK_CatRecipe_CatSize_fkCatSize",
                table: "CatRecipe",
                column: "fkCatSize",
                principalTable: "CatSize",
                principalColumn: "idCatSize",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DetailPurchase_CatRawMaterial_fkCatRawMaterial",
                table: "DetailPurchase",
                column: "fkCatRawMaterial",
                principalTable: "CatRawMaterial",
                principalColumn: "idCatRawMaterial",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CatRecipe_CatSize_fkCatSize",
                table: "CatRecipe");

            migrationBuilder.DropForeignKey(
                name: "FK_DetailPurchase_CatRawMaterial_fkCatRawMaterial",
                table: "DetailPurchase");

            migrationBuilder.DropTable(
                name: "CatColor");

            migrationBuilder.DropTable(
                name: "CatSize");

            migrationBuilder.DropTable(
                name: "DetailRawMaterialColor");

            migrationBuilder.DropTable(
                name: "DetailRecipeColor");

            migrationBuilder.DropIndex(
                name: "IX_CatRecipe_fkCatSize",
                table: "CatRecipe");

            migrationBuilder.DropColumn(
                name: "fkCatSize",
                table: "CatRecipe");

            migrationBuilder.RenameColumn(
                name: "fkCatRawMaterial",
                table: "DetailPurchase",
                newName: "fkCatWarehouse");

            migrationBuilder.RenameIndex(
                name: "IX_DetailPurchase_fkCatRawMaterial",
                table: "DetailPurchase",
                newName: "IX_DetailPurchase_fkCatWarehouse");

            migrationBuilder.AlterColumn<int>(
                name: "quantityWarehouse",
                table: "CatRawMaterial",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 0);

            migrationBuilder.CreateTable(
                name: "CatWarehouse",
                columns: table => new
                {
                    idCatWarehouse = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    fkCatRawMaterial = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false)
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

            migrationBuilder.CreateIndex(
                name: "IX_CatWarehouse_fkCatRawMaterial",
                table: "CatWarehouse",
                column: "fkCatRawMaterial");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailPurchase_CatWarehouse_fkCatWarehouse",
                table: "DetailPurchase",
                column: "fkCatWarehouse",
                principalTable: "CatWarehouse",
                principalColumn: "idCatWarehouse",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
