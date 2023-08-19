using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.DTOs
{
    public class ShipmentDto
    {
        //Shipment
        public int idCatShipment { get; set; }
        public bool delivered { get; set; }
        public DateTime creationDate { get; set; }
        public DateTime updateDate { get; set; }

        //Sale
        public int fkCatSale { get; set; }
        public float total { get; set; }

        //Employee
        public int? fkCatEmployee { get; set; }
        public string EmployeeName { get; set; }
        public string EmployeelastName { get; set; }
        public string EmployeePhone { get; set; }
        public string EmployeeEmail { get; set; }

        //Client        
        public int fkCatClient { get; set; }
        public string ClientName { get; set; }
        public string ClientlastName { get; set; }
        public string ClientPhone { get; set; }
        public string ClientEmail { get; set; }
        public int postalCode { get; set; }
        public string streetNumber { get; set; }
        public string? apartmentNumber { get; set; }
        public string street { get; set; }
        public string neighborhood { get; set; }
    }
}
