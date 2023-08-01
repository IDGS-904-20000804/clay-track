using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class StockController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public StockController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<StockDto>>> GetAll()
        {
            var stock = await dbContext.CatRecipe
                .Include(r => r.Size)
                .ToListAsync();

            var stockDto = stock.Select(r => new StockDto
            {
                Name = r.name,
                ImagePath = r.imagePath,
                Price = r.price,
                QuantityStock = r.quantityStock,
                Size = r.Size
            }).ToList();

            return stockDto;
        }

        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddStock([FromBody] CatRecipe recipe)
        {
            dbContext.Add(recipe);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeleteStock(int id)
        {
            var stock = await dbContext.CatRecipe
                .Include(r => r.Size)
                .FirstOrDefaultAsync(r => r.idCatRecipe == id);

            if (stock == null)
            {
                return NotFound();
            }

            stock.status = false;
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
