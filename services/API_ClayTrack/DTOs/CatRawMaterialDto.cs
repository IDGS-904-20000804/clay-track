using API_ClayTrack.Models;

namespace API_ClayTrack.DTOs
{
    public class CatRawMaterialDto
    {
        public string Name { get; set; }
        public int QuantityWarehouse { get; set; }
        public CatUnitMeasure UnitMeasure { get; set; }
    }
}
