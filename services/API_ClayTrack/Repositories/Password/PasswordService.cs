using Microsoft.AspNetCore.Identity;

namespace API_ClayTrack.Repositories.Password
{
    public class PasswordService : IPasswordService
    {
        private readonly UserManager<IdentityUser> _userManager;

        public PasswordService(UserManager<IdentityUser> userManager)
        {
            _userManager = userManager;
        }

        public async Task<bool> ChangePasswordAsync(string email, string newPassword)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                // Usuario no encontrado
                return false;
            }

            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            var result = await _userManager.ResetPasswordAsync(user, token, newPassword);
            return result.Succeeded;
        }
    }
}
