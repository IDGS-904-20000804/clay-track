using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class DetailPurchase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idDetailPurchase { get; set; }

        [Required]
        public float quantity { get; set; }

        [Required]
        public float price { get; set; }

        [Required]
        [ForeignKey("Warehouse")]
        public int fkCatWarehouse { get; set; }

        [Required]
        [ForeignKey("Purchase")]
        public int fkCatPurchase { get; set; }

        // Relaciones de llave foránea
        public CatWarehouse Warehouse { get; set; }
        public CatPurchase Purchase { get; set; }
    }
}
