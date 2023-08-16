using Microsoft.AspNetCore.Identity;

namespace API_ClayTrack.Repositories.Password
{
    /*public class PasswordHashingService
    {
        private readonly IPasswordHasher<IdentityUser> passwordHasher;

        public PasswordHashingService(IPasswordHasher<IdentityUser> passwordHasher)
        {
            this.passwordHasher = passwordHasher;
        }

        public Dictionary<string, string> HashPasswords(Dictionary<string, string> unhashedPasswords)
        {
            var hashedPasswords = new Dictionary<string, string>();

            foreach (var pair in unhashedPasswords)
            {
                var hashedPassword = passwordHasher.HashPassword(null, pair.Value);
                hashedPasswords[pair.Key] = hashedPassword;
            }

            return hashedPasswords;
        }
    }*/
}
