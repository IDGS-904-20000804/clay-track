using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class PurchaseDto
    {
        public int idCatPurchase { get; set; }

        public float total { get; set; }
        
        //Supplier
        public int fkCatSupplier { get; set; }
        public string email { get; set; }
        //Person-Supplier
        public int idCatPersonSupplier { get; set; }
        public string nameSupplier { get; set; }
        public string lastNameSupplier { get; set; }
        public string? middleNameSupplier { get; set; }
        public string phoneSupplier { get; set; }

        //Employee
        public int fkCatEmployee { get; set; }

        //Person - Employee
        public int idCatPersonEmployee { get; set; }
        public string nameEmployee { get; set; }
        public string lastNameEmployee { get; set; }
        public string? middleNameEmployee { get; set; }
        public string phoneEmployee { get; set; }

        public List<DetailPurchaseDto> Details { get; set; }
    }
}
