using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class HelperDateToRecipeNotNull : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_HelperDateToRecipe_CatRecipe_fkCatRecipe",
                table: "HelperDateToRecipe");

            migrationBuilder.AlterColumn<int>(
                name: "fkCatRecipe",
                table: "HelperDateToRecipe",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_HelperDateToRecipe_CatRecipe_fkCatRecipe",
                table: "HelperDateToRecipe",
                column: "fkCatRecipe",
                principalTable: "CatRecipe",
                principalColumn: "idCatRecipe",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_HelperDateToRecipe_CatRecipe_fkCatRecipe",
                table: "HelperDateToRecipe");

            migrationBuilder.AlterColumn<int>(
                name: "fkCatRecipe",
                table: "HelperDateToRecipe",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_HelperDateToRecipe_CatRecipe_fkCatRecipe",
                table: "HelperDateToRecipe",
                column: "fkCatRecipe",
                principalTable: "CatRecipe",
                principalColumn: "idCatRecipe");
        }
    }
}
