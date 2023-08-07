namespace API_ClayTrack.DTOs
{
    public class RecipeJsonDto
    {
        public string Name { get; set; }
        public float Price { get; set; }
        public int FkCatSize { get; set; }
        public int FkCatImage { get; set; }
        public List<int> ColorIds { get; set; }
        public List<RawMaterialJsonDto> RawMaterials { get; set; }
    }
}
