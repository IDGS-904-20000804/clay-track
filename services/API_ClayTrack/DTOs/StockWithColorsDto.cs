namespace API_ClayTrack.DTOs
{
    public class StockWithColorsDto : StockDto
    {
        public List<int> ColorIds { get; set; }
        public List<string> ColorDescriptions { get; set; }
        public List<string> ColorHexadecimals { get; set; }
    }
}
