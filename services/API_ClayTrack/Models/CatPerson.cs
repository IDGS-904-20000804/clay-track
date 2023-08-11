using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.InteropServices;

namespace API_ClayTrack.Models
{
    public class CatPerson
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatPerson { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        [Required]
        [StringLength(255)]
        public string lastName { get; set; }

        [StringLength(255)]
        public string? middleName { get; set; }

        [Required]
        [StringLength(255)]
        public string phone { get; set; }

        [Required]
        public int postalCode { get; set; }

        [Required]
        [StringLength(255)]
        public string streetNumber { get; set; }

        [StringLength(255)]
        public string? apartmentNumber { get; set; }

        [Required]
        [StringLength(255)]
        public string street { get; set; }

        [Required]
        [StringLength(255)]
        public string neighborhood { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }

    }
}
