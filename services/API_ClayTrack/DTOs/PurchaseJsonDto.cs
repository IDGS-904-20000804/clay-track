namespace API_ClayTrack.DTOs
{
    public class PurchaseJsonDto
    {
        public int idCatPurchase { get; set; }
        public float total { get; set; }
        public int fkCatSupplier { get; set; }
        public int fkCatEmployee { get; set; }
        public List<RawMaterialJsonDto> RawMaterials { get; set; }
    }
}
