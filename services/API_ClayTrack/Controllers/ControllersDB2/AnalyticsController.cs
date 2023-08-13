using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers.ControllersDB2
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnalyticsController : ControllerBase
    {
        private readonly ClayTrackAnalyticsDbContext dbContext;

        public AnalyticsController(ClayTrackAnalyticsDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAllSalesByClient")]
        public async Task<ActionResult<List<string>>> GetAllSalesByClient(DateTime targetDate)
        {
            var graphic = await dbContext.Graphic
                .Where(b => b.type == "SalesByClient" &&
                            b.date.HasValue &&
                            b.date.Value.Year == targetDate.Year &&
                            b.date.Value.Month == targetDate.Month)
                .Select(b => b.result)
                .ToListAsync();

            return graphic;
        }

        [HttpGet]
        [Route("GetAllPurchasesBySupplier")]
        public async Task<ActionResult<List<string>>> GetAllPurchasesBySupplier(DateTime targetDate)
        {
            var graphic = await dbContext.Graphic
                .Where(b => b.type == "PurchasesBySupplier" &&
                            b.date.HasValue &&
                            b.date.Value.Year == targetDate.Year &&
                            b.date.Value.Month == targetDate.Month)
                .Select(b => b.result)
                .ToListAsync();

            return graphic;
        }

        [HttpGet]
        [Route("GetAllRawMaterialsByRecipe")]
        public async Task<ActionResult<List<string>>> GetAllRawMaterialsByRecipe(DateTime targetDate)
        {
            var graphic = await dbContext.Graphic
                .Where(b => b.type == "RawMaterialsByRecipe" &&
                            b.date.HasValue &&
                            b.date.Value.Year == targetDate.Year &&
                            b.date.Value.Month == targetDate.Month)
                .Select(b => b.result)
                .ToListAsync();

            return graphic;
        }

        [HttpGet]
        [Route("GetAllRecipesBySale")]
        public async Task<ActionResult<List<string>>> GetAllRecipesBySale(DateTime targetDate)
        {
            var graphic = await dbContext.Graphic
                .Where(b => b.type == "RecipesBySale" &&
                            b.date.HasValue &&
                            b.date.Value.Year == targetDate.Year &&
                            b.date.Value.Month == targetDate.Month)
                .Select(b => b.result)
                .ToListAsync();

            return graphic;
        }
    }
}
