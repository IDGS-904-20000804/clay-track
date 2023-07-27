using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class updateCatEmployee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "fkRol",
                table: "CatEmployee",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_CatEmployee_fkRol",
                table: "CatEmployee",
                column: "fkRol");

            migrationBuilder.AddForeignKey(
                name: "FK_CatEmployee_AspNetRoles_fkRol",
                table: "CatEmployee",
                column: "fkRol",
                principalTable: "AspNetRoles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CatEmployee_AspNetRoles_fkRol",
                table: "CatEmployee");

            migrationBuilder.DropIndex(
                name: "IX_CatEmployee_fkRol",
                table: "CatEmployee");

            migrationBuilder.DropColumn(
                name: "fkRol",
                table: "CatEmployee");
        }
    }
}
