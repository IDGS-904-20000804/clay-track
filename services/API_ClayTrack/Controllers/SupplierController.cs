using API_ClayTrack.DataBase;
using API_ClayTrack.Models;
using java.util.function;
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

        [HttpGet]
        [Route("GetOne{id:int}")]
        public async Task<ActionResult<CatSupplier>> GetSupplier(int id)
        {
            var supplier = await dbContext.CatSupplier
                .Include(s => s.Person)
                .FirstOrDefaultAsync(s => s.idCatSupplier == id);

            if (supplier == null)
            {
                return NotFound();
            }

            return Ok(supplier);
        }


        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddSupplier([FromBody] CatSupplier supplier)
        {

            dbContext.Add(supplier);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("Update{id:int}")]
        public async Task<ActionResult> UpdateSupplier(CatSupplier supplier, int id)
        {
            if (supplier.idCatSupplier != id)
            {
                return BadRequest("Supplier id different from URL id");
            }

            var exist = await dbContext.CatSupplier
                .Include(s => s.Person)
                .AnyAsync(x => x.idCatSupplier == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(supplier);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeleteSupplier(int id)
        {
            var supplier = await dbContext.CatSupplier
                .Include(e => e.Person)
                .FirstOrDefaultAsync(e => e.idCatSupplier == id);

            if (supplier == null)
            {
                return NotFound();
            }

            supplier.Person.status = false;

            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
