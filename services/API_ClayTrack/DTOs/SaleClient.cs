using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class SaleClient
    {
        //Shipment
        public int idCatShipment { get; set; }
        public bool delivered { get; set; }
        public DateTime creationDate { get; set; }

        //Sale
        public int fkCatSale { get; set; }
        public float total { get; set; }

        //DetailSale
        public List<DetailSale> DetailSale { get; set; }

        //Client        
        public int fkCatClient { get; set; }
        public string ClientName { get; set; }
        public string ClientLastName { get; set; }
        public string ClientMiddleName { get; set; }
        public string ClientPhone { get; set; }
        public string ClientEmail { get; set; }
        public int postalCode { get; set; }
        public string streetNumber { get; set; }
        public string? apartmentNumber { get; set; }
        public string street { get; set; }
        public string neighborhood { get; set; }
    }
}
