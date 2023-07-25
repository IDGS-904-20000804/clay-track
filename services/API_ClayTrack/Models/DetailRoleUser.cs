using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class DetailRoleUser
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatUser { get; set; }

        [Required]
        [ForeignKey("User")]
        public int fkCatUser { get; set; }

        [Required]
        [ForeignKey("Role")]
        public int fkCatRole { get; set; }

        // Relaciones de llave foránea
        public CatUser User { get; set; }
        public CatRole Role { get; set; }
    }
}
