using API_ClayTrack.Models;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class DetailSaleDto
    {
        
        public int quantity { get; set; }
        public int fkCatClient { get; set; }
        public int fkCatSale { get; set; }
        public int fkCatRecipe { get; set; }
    }
}
