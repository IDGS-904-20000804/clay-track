namespace API_ClayTrack.DTOs
{
    public class DetailPurchaseDto
    {
        public int idDetailPurchase { get; set; }
        public int quantity { get; set; }
        public float price { get; set; }
        public int fkCatRawMaterial { get; set; }
        public string rawMaterialName { get; set; }
    }
}
