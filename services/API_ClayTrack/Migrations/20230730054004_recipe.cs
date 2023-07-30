using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class recipe : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<float>(
                name: "price",
                table: "CatRecipe",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<int>(
                name: "quantityStock",
                table: "CatRecipe",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "price",
                table: "CatRecipe");

            migrationBuilder.DropColumn(
                name: "quantityStock",
                table: "CatRecipe");
        }
    }
}
