using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatWarehouse
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatWarehouse { get; set; }

        [Required]
        public int quantity { get; set; }

        [Required]
        public bool status { get; set; } = true;

        [Required]
        public DateTime creationDate { get; set; } = DateTime.Now;

        [Required]
        public DateTime updateDate { get; set; } = DateTime.Now;

        [Required]
        [ForeignKey("RawMaterial")]
        public int fkCatRawMaterial { get; set; }

        // Relaciones de llave foránea
        public CatRawMaterial RawMaterial { get; set; }
    }
}
