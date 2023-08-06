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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class PurchaseController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public PurchaseController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatPurchase>>> GetAllSupplier()
        {
            return await dbContext.CatPurchase
                .Include(p => p.Supplier)
                .Include(p => p.Employee)
                .ToListAsync();
        }

        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {

            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("Update{id:int}")]
        public async Task<ActionResult> UpdatePurchase(CatPurchase purchase, int id)
        {
            if (purchase.idCatPurchase != id)
            {
                return BadRequest("Purchase id different from URL id");
            }

            var exist = await dbContext.CatPurchase.AnyAsync(x => x.idCatPurchase == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(purchase);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeletePurchase(int id)
        {
            var exist = await dbContext.CatPurchase.AnyAsync(x => x.idCatPurchase == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Remove(new CatPurchase() { idCatPurchase = id });
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
