using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace API_ClayTrack.Models
{
    public class DetailRecipeColor
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idDetailRecipeColor { get; set; }

        [Required]
        [ForeignKey("Recipe")]
        public int fkCatRecipe { get; set; }

        [Required]
        [ForeignKey("Color")]
        public int fkCatColor { get; set; }

        // Relaciones de llave foránea
        public CatRecipe Recipe { get; set; }
        public CatColor Color { get; set; }
    }
}
