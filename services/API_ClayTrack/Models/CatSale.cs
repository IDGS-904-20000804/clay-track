using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatSale
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatSale { get; set; }

        [Required]
        public float total { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

        [Required]
        [ForeignKey("Client")]
        public int fkCatClient { get; set; }

        // Relaciones de llave foránea
        public CatClient Client { get; set; }
    }
}
