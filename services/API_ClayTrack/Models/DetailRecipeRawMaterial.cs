using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class DetailRecipeRawMaterial
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idDetailRecipeRawMaterial { get; set; }

        [Required]
        public float quantity { get; set; }

        [Required]
        [ForeignKey("Recipe")]
        public int fkCatRecipe { get; set; }

        [Required]
        [ForeignKey("RawMaterial")]
        public int fkCatRawMaterial { get; set; }

        // Relaciones de llave foránea
        public CatRecipe Recipe { get; set; }
        public CatRawMaterial RawMaterial { get; set; }
    }
}
