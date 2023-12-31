﻿using API_ClayTrack.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.DataBase
{
    public class ClayTrackDbContext : IdentityDbContext
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //Rol
            var AdminRoleId = "c309fa92-2123-47be-b397-a1c77adb502c";
            var ClientRoleId = "a71a55d6-99d7-4123-b4e0-1218ecb90e3e";
            var EmployeeRoleId = "c309fa92-2123-47be-b397-adfdgdfg3344";

            var roles = new List<IdentityRole>
            {
                new IdentityRole
                {
                    Id = AdminRoleId,
                    ConcurrencyStamp = AdminRoleId,
                    Name = "Admin",
                    NormalizedName = "Admin".ToUpper()
                },
                new IdentityRole
                {
                    Id = ClientRoleId,
                    ConcurrencyStamp = ClientRoleId,
                    Name = "Client",
                    NormalizedName = "Client".ToUpper()
                },
                new IdentityRole
                {
                    Id = EmployeeRoleId,
                    ConcurrencyStamp = EmployeeRoleId,
                    Name = "Employee",
                    NormalizedName = "Employee".ToUpper()
                }
            };

            modelBuilder.Entity<IdentityRole>().HasData(roles);

            //CatPurchase fkCatSupplier and fkCatEmployee
            modelBuilder.Entity<CatPurchase>()
                .HasOne(p => p.Supplier)
                .WithMany()
                .HasForeignKey(p => p.fkCatSupplier)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<CatPurchase>()
                .HasOne(p => p.Employee)
                .WithMany()
                .HasForeignKey(p => p.fkCatEmployee)
                .OnDelete(DeleteBehavior.NoAction);

            //CatPurchase fkCatSale and fkCatEmployee
            modelBuilder.Entity<CatShipment>()
                .HasOne(p => p.Sale)
                .WithMany()
                .HasForeignKey(p => p.fkCatSale)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<CatShipment>()
                .HasOne(p => p.Employee)
                .WithMany()
                .HasForeignKey(p => p.fkCatEmployee)
                .OnDelete(DeleteBehavior.NoAction);

            //CatSize status, creationDate and updateDate
            modelBuilder.Entity<CatSize>()
                .Property(s => s.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatSize>()
                .Property(s => s.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatSize>()
                .Property(s => s.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatColor status, creationDate and updateDate
            modelBuilder.Entity<CatColor>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatColor>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatColor>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatEmployee, CatClient, CatSupplier status
            modelBuilder.Entity<CatEmployee>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatClient>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatSupplier>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            //CatPerson status, creationDate and updateDate
            modelBuilder.Entity<CatPerson>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatPerson>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatPurchase creationDate and updateDate
            modelBuilder.Entity<CatPurchase>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatPurchase>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatRawMaterial status, creationDate and updateDate
            modelBuilder.Entity<CatRawMaterial>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatRawMaterial>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatRawMaterial>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatRecipe status, creationDate and updateDate
            modelBuilder.Entity<CatRecipe>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatRecipe>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatRecipe>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatRecipe>()
                .Property(s => s.quantityStock)
                .HasDefaultValue(0);

            //CatSale status, creationDate and updateDate
            modelBuilder.Entity<CatSale>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatSale>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatShipment status, creationDate and updateDate
            modelBuilder.Entity<CatShipment>()
                .Property(b => b.delivered)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatShipment>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatShipment>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatUnitMeasure status, creationDate and updateDate
            modelBuilder.Entity<CatUnitMeasure>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatUnitMeasure>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatUnitMeasure>()
                .Property(c => c.updateDate)
                .HasDefaultValueSql("GETDATE()");

            //CatRawMaterial campo quantityWarehouse defaul 0
            modelBuilder.Entity<CatRawMaterial>()
            .Property(p => p.quantityWarehouse)
            .HasDefaultValue(0);

            //CatShipment campo delivered defaul false
            modelBuilder.Entity<CatShipment>()
            .Property(p => p.delivered)
            .HasDefaultValue(false);

            base.OnModelCreating(modelBuilder);
        }

        public ClayTrackDbContext(DbContextOptions<ClayTrackDbContext> dbContextOptions) : base(dbContextOptions)
        {

        }

        public DbSet<CatClient> CatClient { get; set; }
        public DbSet<CatEmployee> CatEmployee { get; set; }
        public DbSet<CatPerson> CatPerson { get; set; }
        public DbSet<CatRawMaterial> CatRawMaterial { get; set; }
        public DbSet<CatRecipe> CatRecipe { get; set; }
        public DbSet<CatSale> CatSale { get; set; }
        public DbSet<CatShipment> CatShipment { get; set; }
        public DbSet<CatSupplier> CatSupplier { get; set; }
        public DbSet<CatUnitMeasure> CatUnitMeasure { get; set; }
        public DbSet<CatSize> CatSize { get; set; }
        public DbSet<DetailPurchase> DetailPurchase { get; set; }
        public DbSet<DetailRecipeRawMaterial> DetailRecipeRawMaterial { get; set; }
        public DbSet<DetailSale> DetailSale { get; set; }
        public DbSet<CatPurchase> CatPurchase { get; set; }
        public DbSet<CatColor> CatColor { get; set; }
        public DbSet<DetailRecipeColor> DetailRecipeColor { get; set; }
        public DbSet<CatImage> CatImage { get; set; }
        public DbSet<HelperDateToRecipe> HelperDateToRecipe { get; set; }

    }
}
