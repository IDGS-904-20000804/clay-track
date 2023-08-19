using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class Graphic
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        [Required]
        public string result { get; set; }

        public DateTime? date { get; set; }

        [Required]
        public string type { get; set; }
    }
}
