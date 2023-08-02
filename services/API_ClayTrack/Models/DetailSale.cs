using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class DetailSale
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idDetailSale { get; set; }

        [Required]
        public int quantity { get; set; }

        [Required]
        public float price { get; set; }

        [Required]
        [ForeignKey("Stock")]
        public int fkCatRecipe { get; set; }

        [Required]
        [ForeignKey("Sale")]
        public int fkCatSale { get; set; }

        // Relaciones de llave foránea
        public CatRecipe Recipe { get; set; }
        public CatSale Sale { get; set; }
    }
}
