using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class HelperDateToRecipe : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "HelperDateToRecipe",
                columns: table => new
                {
                    idHelperDatesToRecipe = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    creationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    fkCatRecipe = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HelperDateToRecipe", x => x.idHelperDatesToRecipe);
                    table.ForeignKey(
                        name: "FK_HelperDateToRecipe_CatRecipe_fkCatRecipe",
                        column: x => x.fkCatRecipe,
                        principalTable: "CatRecipe",
                        principalColumn: "idCatRecipe");
                });

            migrationBuilder.CreateIndex(
                name: "IX_HelperDateToRecipe_fkCatRecipe",
                table: "HelperDateToRecipe",
                column: "fkCatRecipe");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "HelperDateToRecipe");
        }
    }
}
