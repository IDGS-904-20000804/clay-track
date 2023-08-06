using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class UserCredentials
    {
        [Required]
        [EmailAddress]
        public string Email { get; set;}

        [Required]
        public string Password { get; set; }
    }
}
