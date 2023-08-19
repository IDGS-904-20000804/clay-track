using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatRawMaterial
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatRawMaterial { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        [Required]
        public int quantityWarehouse { get; set; }

        [Required]
        public int quantityPackage { get; set; }

        [Required]
        public bool status { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

        [Required]
        [ForeignKey("UnitMeasure")]
        public int fkCatUnitMeasure { get; set; }

        // Relaciones de llave foránea
        public CatUnitMeasure UnitMeasure { get; set; }
    }
}
