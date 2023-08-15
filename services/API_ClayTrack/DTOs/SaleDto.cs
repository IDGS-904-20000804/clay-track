namespace API_ClayTrack.DTOs
{
    public class SaleDto
    {
        public int fkCatClient { get; set; }
        public List<DetailSaleDto> DetailSales { get; set; }
    }
}
