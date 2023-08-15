using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using com.sun.org.glassfish.gmbal;
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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class StockController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public StockController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        [AllowAnonymous]
        public async Task<ActionResult<List<StockWithColorsDto>>> GetAllStock()
        {
            var stock = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .ToListAsync();

            var stockWithColorsDto = new List<StockWithColorsDto>();

            foreach (var recipe in stock)
            {
                var stockDto = new StockWithColorsDto
                {
                    //Recipe
                    idCatRecipe = recipe.idCatRecipe,
                    Name = recipe.name,
                    Price = recipe.price,
                    QuantityStock = recipe.quantityStock,
                    status = recipe.status,

                    //Image
                    FkCatImage = recipe.fkCatImage,
                    FilePath = recipe.Image.FilePath,

                    //Size
                    FKCatSize = recipe.fkCatSize,
                    Description = recipe.Size.description,
                    Abbreviation = recipe.Size.abbreviation
                };

                // Get colors for the current recipe
                var detailColors = await dbContext.DetailRecipeColor
                    .Include(d => d.Color)
                    .Where(d => d.fkCatRecipe == recipe.idCatRecipe)
                    .Select(d => d.Color.idCatColor)
                    .ToListAsync();

                stockDto.ColorIds = detailColors;
                stockWithColorsDto.Add(stockDto);
            }

            return stockWithColorsDto;
        }



        [HttpGet]
        [Route("GetOne{id:int}")]
        [AllowAnonymous]
        public async Task<ActionResult<CatRecipe>> GetStock(int id)
        {
            var stock = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .FirstOrDefaultAsync(s => s.idCatRecipe == id);

            if (stock == null)
            {
                return NotFound();
            }

            return Ok(stock);
        }

        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeleteRecipe(int id)
        {
            var recipe = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .FirstOrDefaultAsync(r => r.idCatRecipe == id);

            if (recipe == null)
            {
                return NotFound();
            }

            recipe.status = false;
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("InsertStock")]
        public IActionResult InsertStock(int idCatRecipe, int totalRecipes)
        {
            var recipe = dbContext.CatRecipe.FirstOrDefault(r => r.idCatRecipe == idCatRecipe);

            if (recipe == null)
            {
                return NotFound();
            }

            var (isEnough, shortageDetails) = CheckRawMaterialByRecipe(idCatRecipe, totalRecipes);

            if (isEnough)
            {
                UpdateRawMaterialQuantity(idCatRecipe, totalRecipes);
                UpdateRecipeStock(idCatRecipe, totalRecipes);

                dbContext.SaveChanges();

                return Ok("Stock inserted successfully.");
            }
            else
            {
                var shortageMessage = GetShortageMessage(shortageDetails);
                return BadRequest($"Not enough raw material to produce the recipes. {shortageMessage}");
            }
        }

        private (bool isEnough, Dictionary<string, int> shortageDetails) CheckRawMaterialByRecipe(int idCatRecipe, int totalRecipes)
        {
            var recipeRawMaterials = dbContext.DetailRecipeRawMaterial
                .Where(drrm => drrm.fkCatRecipe == idCatRecipe)
                .Select(drrm => new
                {
                    drrm.fkCatRawMaterial,
                    RequiredQuantity = drrm.quantity * totalRecipes
                })
                .ToList();

            var shortageDetails = new Dictionary<string, int>();

            foreach (var recipeRawMaterial in recipeRawMaterials)
            {
                var rawMaterial = dbContext.CatRawMaterial
                    .FirstOrDefault(rm => rm.idCatRawMaterial == recipeRawMaterial.fkCatRawMaterial);

                if (rawMaterial == null || rawMaterial.quantityWarehouse < recipeRawMaterial.RequiredQuantity)
                {
                    if (rawMaterial != null)
                    {
                        var shortageQuantity = recipeRawMaterial.RequiredQuantity - rawMaterial.quantityWarehouse;
                        shortageDetails.Add(rawMaterial.name, shortageQuantity);
                    }
                    return (false, shortageDetails);
                }
            }

            return (true, shortageDetails);
        }

        private string GetShortageMessage(Dictionary<string, int> shortageDetails)
        {
            if (shortageDetails.Count == 0)
            {
                return "No shortage details available.";
            }

            var shortageMessage = "Shortage details: ";
            foreach (var shortageDetail in shortageDetails)
            {
                shortageMessage += $"{shortageDetail.Key} ({shortageDetail.Value} units), ";
            }
            shortageMessage = shortageMessage.TrimEnd(',', ' ');

            return shortageMessage;
        }

        private void UpdateRawMaterialQuantity(int idCatRecipe, int totalRecipes)
        {
            var recipeRawMaterials = dbContext.DetailRecipeRawMaterial
                .Where(drrm => drrm.fkCatRecipe == idCatRecipe)
                .Select(drrm => new
                {
                    drrm.fkCatRawMaterial,
                    RequiredQuantity = drrm.quantity * totalRecipes
                })
                .ToList();

            foreach (var recipeRawMaterial in recipeRawMaterials)
            {
                var rawMaterial = dbContext.CatRawMaterial
                    .FirstOrDefault(rm => rm.idCatRawMaterial == recipeRawMaterial.fkCatRawMaterial);

                if (rawMaterial != null)
                {
                    rawMaterial.quantityWarehouse -= recipeRawMaterial.RequiredQuantity;
                    if (rawMaterial.quantityWarehouse <= 0)
                    {
                        rawMaterial.status = false;
                    }
                }
            }
        }

        private void UpdateRecipeStock(int idCatRecipe, int totalRecipes)
        {
            var recipe = dbContext.CatRecipe.FirstOrDefault(r => r.idCatRecipe == idCatRecipe);
            if (recipe != null)
            {
                recipe.quantityStock += totalRecipes;

                if (!recipe.status)
                {
                    recipe.status = true;
                }
            }
        }

    }
}
