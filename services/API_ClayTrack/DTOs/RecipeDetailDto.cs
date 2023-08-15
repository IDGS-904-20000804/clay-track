using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class RecipeDetailDto
    {
        public int IdCatRecipe { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public int? FkCatImage { get; set; }
        public int FkCatSize { get; set; }
        public List<CatColor> Colors { get; set; }
        public List<RawMaterialSimpleDto> RawMaterials { get; set; }
        public List<DetailRecipeRawMaterialSimpleDto> RawMaterialDetails { get; set; }
    }
}
