using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class ShipmentController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public ShipmentController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        
    }
}
/*[HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatShipment>>> GetAll()
        {
            var rawMaterials = await dbContext.CatRawMaterial
                .Include(rm => rm.UnitMeasure)
                .ToListAsync();

            var rawMaterialsDto = rawMaterials.Select(rm => new CatRawMaterialDto
            {
                Name = rm.name,
                QuantityWarehouse = rm.quantityWarehouse,
                UnitMeasure = rm.UnitMeasure
            }).ToList();

            return rawMaterials;
        }*/