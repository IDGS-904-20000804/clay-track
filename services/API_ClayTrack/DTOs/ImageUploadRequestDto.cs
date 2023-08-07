using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class ImageUploadRequestDto
    {
        [Required]
        public IFormFile File { get; set; }

        [Required]
        public string FileName { get; set; }
    }
}
