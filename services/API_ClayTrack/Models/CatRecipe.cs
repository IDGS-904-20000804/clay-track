using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatRecipe
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatRecipe { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        [Required]
        public float price { get; set; }

        [Required]
        public int quantityStock { get; set; }

        [Required]
        public bool status { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

        [Required]
        [ForeignKey("Size")]
        public int fkCatSize { get; set; }

        [ForeignKey("Image")]
        public int? fkCatImage { get; set; }

        // Relaciones de llave foránea
        public CatSize Size { get; set; }
        public CatImage Image { get; set; }
    }
}
