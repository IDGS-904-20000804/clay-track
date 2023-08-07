using Microsoft.AspNetCore.Identity;

namespace API_ClayTrack.Repositories.Token
{
    public interface ITokenRepository
    {
        string CreateJWTToken(IdentityUser user, List<string> roles);
    }
}
