using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatShipment
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatShipment { get; set; }

        [Required]
        public bool delivered { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

        [Required]
        [ForeignKey("Sale")]
        public int fkCatSale { get; set; }

        [ForeignKey("Employee")]
        public int? fkCatEmployee { get; set; }

        // Relaciones de llave foránea
        public CatSale Sale { get; set; }
        public CatEmployee Employee { get; set; }
    }
}
