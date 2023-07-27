using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class EditRolDTO
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}
