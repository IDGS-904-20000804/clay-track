using API_ClayTrack.Models;

namespace API_ClayTrack.Repositories.IImageRepository
{
    public interface IImageRepository
    {
        Task<CatImage> Upload(CatImage image);
    }
}
