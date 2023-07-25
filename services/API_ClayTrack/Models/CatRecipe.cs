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
        [StringLength(255)]
        public string imagePath { get; set; }

        [Required]
        public bool status { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }
    }
}
