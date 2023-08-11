using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API_ClayTrack.Migrations
{
    /// <inheritdoc />
    public partial class statusEmployeeClient : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "status",
                table: "CatPerson");

            migrationBuilder.AddColumn<bool>(
                name: "status",
                table: "CatSupplier",
                type: "bit",
                nullable: false,
                defaultValue: true);

            migrationBuilder.AddColumn<bool>(
                name: "status",
                table: "CatEmployee",
                type: "bit",
                nullable: false,
                defaultValue: true);

            migrationBuilder.AddColumn<bool>(
                name: "status",
                table: "CatClient",
                type: "bit",
                nullable: false,
                defaultValue: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "status",
                table: "CatSupplier");

            migrationBuilder.DropColumn(
                name: "status",
                table: "CatEmployee");

            migrationBuilder.DropColumn(
                name: "status",
                table: "CatClient");

            migrationBuilder.AddColumn<bool>(
                name: "status",
                table: "CatPerson",
                type: "bit",
                nullable: false,
                defaultValue: true);
        }
    }
}
