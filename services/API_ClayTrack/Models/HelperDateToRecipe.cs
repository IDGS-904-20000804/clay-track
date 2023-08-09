using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class HelperDateToRecipe
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idHelperDatesToRecipe { get; set; }

        [Required]
        public int quantity { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [ForeignKey("Recipe")]
        public int? fkCatRecipe { get; set; }

        // Relaciones de llave foránea
        public CatRecipe Recipe { get; set; }
    }
}
