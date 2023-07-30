using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class deliteCatSock : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailSale_CatStock_fkCatStock",
                table: "DetailSale");

            migrationBuilder.DropTable(
                name: "CatStock");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailSale_CatRecipe_fkCatStock",
                table: "DetailSale",
                column: "fkCatStock",
                principalTable: "CatRecipe",
                principalColumn: "idCatRecipe",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailSale_CatRecipe_fkCatStock",
                table: "DetailSale");

            migrationBuilder.CreateTable(
                name: "CatStock",
                columns: table => new
                {
                    idCatStock = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    fkCatRecipe = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    updateDate = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
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

            migrationBuilder.CreateIndex(
                name: "IX_CatStock_fkCatRecipe",
                table: "CatStock",
                column: "fkCatRecipe");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailSale_CatStock_fkCatStock",
                table: "DetailSale",
                column: "fkCatStock",
                principalTable: "CatStock",
                principalColumn: "idCatStock",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
