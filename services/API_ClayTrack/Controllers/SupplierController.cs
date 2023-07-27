using API_ClayTrack.DataBase;
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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Policy = "Employee")]
    public class SupplierController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public SupplierController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        public async Task<ActionResult<List<CatSupplier>>> GetAllSupplier()
        {
            return await dbContext.CatSupplier
                .Include(s => s.Person)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult> AddSupplier([FromBody] CatSupplier supplier)
        {

            dbContext.Add(supplier);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("{id:int}")]
        public async Task<ActionResult> UpdateSupplier(CatSupplier supplier, int id)
        {
            if (supplier.idCatSupplier != id)
            {
                return BadRequest("Supplier id different from URL id");
            }

            var exist = await dbContext.CatSupplier.AnyAsync(x => x.idCatSupplier == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(supplier);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<ActionResult> DeleteSupplier(int id)
        {
            var exist = await dbContext.CatSupplier.AnyAsync(x => x.idCatSupplier == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Remove(new CatSupplier() { idCatSupplier = id });
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
