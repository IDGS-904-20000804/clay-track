namespace API_ClayTrack.Repositories.Password
{
    public interface IPasswordService
    {
        Task<bool> ChangePasswordAsync(string email, string newPassword);
    }
}
