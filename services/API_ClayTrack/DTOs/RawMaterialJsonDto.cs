namespace API_ClayTrack.DTOs
{
    public class RawMaterialJsonDto
    {
        public int IdCatalog { get; set; }
        public int Quantity { get; set; }
        public float Price { get; set; }
        public int FkCatRawMaterial { get; set; }
    }
}
