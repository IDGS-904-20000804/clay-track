using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class RawMaterialController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public RawMaterialController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatRawMaterial>>> GetAll()
        {
            var rawMaterials = await dbContext.CatRawMaterial
                .Include(rm => rm.UnitMeasure)
                .ToListAsync();

            return rawMaterials;
        }

        [HttpGet]
        [Route("GetOne{id:int}")]
        [AllowAnonymous]
        public async Task<ActionResult<CatRawMaterial>> GetRawMaterial(int id)
        {
            var rawMaterial = await dbContext.CatRawMaterial
                .Include(rm => rm.UnitMeasure)
                .FirstOrDefaultAsync(s => s.idCatRawMaterial == id);

            if (rawMaterial == null)
            {
                return NotFound();
            }

            return Ok(rawMaterial);
        }


        [HttpPost]
        public async Task<ActionResult> AddRawMaterial([FromBody] CatRawMaterial rawMaterial)
        {
            dbContext.Add(rawMaterial);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("{id:int}")]
        public async Task<ActionResult> UpdateRawMaterial(CatRawMaterial rawMaterial, int id)
        {
            if (rawMaterial.idCatRawMaterial != id)
            {
                return BadRequest("RawMaterial id different from URL id");
            }

            var exist = await dbContext.CatRawMaterial
                .Include(rm => rm.UnitMeasure)
                .AnyAsync(x => x.idCatRawMaterial == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(rawMaterial);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> Delete(int id)
        {
            var rawMaterial = await dbContext.CatRawMaterial
                .FirstOrDefaultAsync(e => e.idCatRawMaterial == id);

            if (rawMaterial == null)
            {
                return NotFound();
            }

            dbContext.Remove(rawMaterial);
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
