using System.ComponentModel.DataAnnotations;
using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class StockDto
    {
        public string Name { get; set; }
        
        [StringLength(255)]
        public string ImagePath { get; set; }
        
        public int QuantityStock { get; set; }

        public CatSize Size { get; set; }

        public float Price { get; set; }
    }
}
