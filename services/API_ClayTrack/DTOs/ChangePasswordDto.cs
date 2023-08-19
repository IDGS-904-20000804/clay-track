using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class ChangePasswordDto
    {
        [Required(ErrorMessage = "El correo electrónico es requerido.")]
        [EmailAddress(ErrorMessage = "Por favor, ingresa una dirección de correo electrónico válida.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "La nueva contraseña es requerida.")]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "Confirma la nueva contraseña.")]
        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage = "Las contraseñas no coinciden.")]
        public string ConfirmNewPassword { get; set; }
    }
}
