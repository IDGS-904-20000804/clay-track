using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatPurchase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatPurchase { get; set; }

        [Required]
        public float total { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

        [Required]
        [ForeignKey("Supplier")]
        public int fkCatSupplier { get; set; }

        [Required]
        [ForeignKey("Employee")]
        public int fkCatEmployee { get; set; }

        // Relaciones de llave foránea
        public CatSupplier Supplier { get; set; }
        public CatEmployee Employee { get; set; }
    }
}
