using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatEmployee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatEmployee { get; set; }

        [Required]
        [ForeignKey("Person")]
        public int fkCatPerson { get; set; }

        [Required]
        [ForeignKey("User")]
        public int fkCatUser { get; set; }

        // Relaciones de llave foránea
        public CatPerson Person { get; set; }
        public CatUser User { get; set; }
    }
}
