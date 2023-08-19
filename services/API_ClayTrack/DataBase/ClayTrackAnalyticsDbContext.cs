using API_ClayTrack.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.DataBase
{
    public class ClayTrackAnalyticsDbContext : IdentityDbContext
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Graphic>()
                .Property(r => r.date)
                .HasDefaultValueSql("GETDATE()");

            base.OnModelCreating(modelBuilder);
        }
        public ClayTrackAnalyticsDbContext(DbContextOptions<ClayTrackAnalyticsDbContext> dbContextOptions) : base(dbContextOptions)
        {

        }

        public DbSet<Graphic> Graphic { get; set; }
    }
}
