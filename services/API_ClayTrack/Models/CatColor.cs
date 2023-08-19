using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatColor
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatColor { get; set; }

        [Required]
        [StringLength(255)]
        public string description { get; set; }

        [Required]
        [StringLength(255)]
        public string hexadecimal { get; set; }

        [Required]
        public bool status { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }
    }
}
