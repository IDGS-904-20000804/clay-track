using System.ComponentModel.DataAnnotations;
using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class StockDto
    {
        public int idCatRecipe { get; set; }
        public string Name { get; set; }

        public int? FkCatImage { get; set; }

        public int QuantityStock { get; set; }

        public CatSize Size { get; set; }

        public float Price { get; set; }
        public bool status { get; set; }
        public string FilePath { get; set; }
    }
}
