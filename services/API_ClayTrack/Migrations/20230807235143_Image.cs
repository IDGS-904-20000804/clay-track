using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class Image : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CatRecipe_CatImage_fkCatImage",
                table: "CatRecipe");

            migrationBuilder.AlterColumn<int>(
                name: "fkCatImage",
                table: "CatRecipe",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_CatRecipe_CatImage_fkCatImage",
                table: "CatRecipe",
                column: "fkCatImage",
                principalTable: "CatImage",
                principalColumn: "IdCatImage");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CatRecipe_CatImage_fkCatImage",
                table: "CatRecipe");

            migrationBuilder.AlterColumn<int>(
                name: "fkCatImage",
                table: "CatRecipe",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_CatRecipe_CatImage_fkCatImage",
                table: "CatRecipe",
                column: "fkCatImage",
                principalTable: "CatImage",
                principalColumn: "IdCatImage",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
