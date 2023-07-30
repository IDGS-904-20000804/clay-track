using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class StockDto
    {
        public string Name { get; set; }
        public int QuantityStock { get; set; }
        public CatSize Size { get; set; }
    }
}
