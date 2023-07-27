using API_ClayTrack.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.DataBase
{
    public class ClayTrackDbContext : IdentityDbContext
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
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

            //CatPerson status, creationDate and updateDate
            modelBuilder.Entity<CatPerson>()
                .Property(b => b.status)
                .HasDefaultValue(true);

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

            //CatStock status, creationDate and updateDate
            modelBuilder.Entity<CatStock>()
                .Property(b => b.status)
                .HasDefaultValue(true);

            modelBuilder.Entity<CatStock>()
                .Property(c => c.creationDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CatStock>()
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

            base.OnModelCreating(modelBuilder);
        }
        public ClayTrackDbContext(DbContextOptions dbContextOptions): base(dbContextOptions) 
        {
            
        }

        public DbSet<CatClient> CatClient { get; set; }
        public DbSet<CatEmployee> CatEmployee { get; set; }
        public DbSet<CatPerson> CatPerson { get; set; }
        public DbSet<CatRawMaterial> CatRawMaterial { get; set; }
        public DbSet<CatRecipe> CatRecipe { get; set; }
        public DbSet<CatSale> CatSale { get; set; }
        public DbSet<CatShipment> CatShipment { get; set; }
        public DbSet<CatStock> CatStock { get; set; }
        public DbSet<CatSupplier> CatSupplier { get; set; }
        public DbSet<CatUnitMeasure> CatUnitMeasure { get; set; }
        public DbSet<CatSize> CatSize { get; set; }
        public DbSet<DetailPurchase> DetailPurchase { get; set; }
        public DbSet<DetailRecipeRawMaterial> DetailRecipeRawMaterial { get; set; }
        public DbSet<DetailSale> DetailSale { get; set; }
        public DbSet<CatPurchase> CatPurchase { get; set; }
        public DbSet<CatColor> CatColor { get; set; }
        public DbSet<DetailRawMaterialColor> DetailRawMaterialColor { get; set; }
        public DbSet<DetailRecipeColor> DetailRecipeColor { get; set; }

    }
}
