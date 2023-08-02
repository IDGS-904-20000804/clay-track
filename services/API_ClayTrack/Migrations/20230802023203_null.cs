using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class @null : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailSale_CatRecipe_fkCatStock",
                table: "DetailSale");

            migrationBuilder.DropIndex(
                name: "IX_DetailSale_fkCatStock",
                table: "DetailSale");

            migrationBuilder.RenameColumn(
                name: "fkCatStock",
                table: "DetailSale",
                newName: "fkCatRecipe");

            migrationBuilder.AddColumn<int>(
                name: "RecipeidCatRecipe",
                table: "DetailSale",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<bool>(
                name: "delivered",
                table: "CatShipment",
                type: "bit",
                nullable: false,
                defaultValue: false,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: true);

            migrationBuilder.AlterColumn<string>(
                name: "imagePath",
                table: "CatRecipe",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(255)",
                oldMaxLength: 255);

            migrationBuilder.CreateIndex(
                name: "IX_DetailSale_RecipeidCatRecipe",
                table: "DetailSale",
                column: "RecipeidCatRecipe");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailSale_CatRecipe_RecipeidCatRecipe",
                table: "DetailSale",
                column: "RecipeidCatRecipe",
                principalTable: "CatRecipe",
                principalColumn: "idCatRecipe",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailSale_CatRecipe_RecipeidCatRecipe",
                table: "DetailSale");

            migrationBuilder.DropIndex(
                name: "IX_DetailSale_RecipeidCatRecipe",
                table: "DetailSale");

            migrationBuilder.DropColumn(
                name: "RecipeidCatRecipe",
                table: "DetailSale");

            migrationBuilder.RenameColumn(
                name: "fkCatRecipe",
                table: "DetailSale",
                newName: "fkCatStock");

            migrationBuilder.AlterColumn<bool>(
                name: "delivered",
                table: "CatShipment",
                type: "bit",
                nullable: false,
                defaultValue: true,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: false);

            migrationBuilder.AlterColumn<string>(
                name: "imagePath",
                table: "CatRecipe",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(255)",
                oldMaxLength: 255,
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DetailSale_fkCatStock",
                table: "DetailSale",
                column: "fkCatStock");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailSale_CatRecipe_fkCatStock",
                table: "DetailSale",
                column: "fkCatStock",
                principalTable: "CatRecipe",
                principalColumn: "idCatRecipe",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
