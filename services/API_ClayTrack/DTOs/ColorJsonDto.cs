namespace API_ClayTrack.DTOs
{
    public class ColorJsonDto
    {
        public int IdCatalog { get; set; }
        public int TotalRecipes { get; set; }
        public List<int> ColorIds { get; set; }
    }
}
