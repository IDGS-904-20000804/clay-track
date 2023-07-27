using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace API_ClayTrack.Models
{
    public class CatClient
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatClient { get; set; }
        
        [Required]
        [ForeignKey("Person")]
        public int fkCatPerson { get; set; }

        [Required]
        [ForeignKey("User")]
        public string fkUser { get; set; }

        // Relaciones de llave foránea
        public CatPerson Person { get; set; }
        public IdentityUser User { get; set; }
        
    }
}
