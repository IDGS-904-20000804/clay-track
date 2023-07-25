using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatSupplier
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatSupplier { get; set; }

        [Required]
        [StringLength(255)]
        public string email { get; set; }

        [Required]
        [ForeignKey("Person")]
        public int fkCatPerson { get; set; }

        // Relaciones de llave foránea
        public CatPerson Person { get; set; }
    }
}
