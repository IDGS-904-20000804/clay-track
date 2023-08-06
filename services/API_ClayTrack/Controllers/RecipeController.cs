using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin,Employee")]
    public partial class RecipeController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public RecipeController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpPost]
        [Route("InsertRecipe")]
        public async Task<IActionResult> InsertRecipe([FromBody] RecipeJsonDto recipeJson)
        {
            // Check if the recipe JSON is valid
            if (recipeJson == null)
            {
                return BadRequest("The recipe JSON is invalid or empty.");
            }

            // Insert the recipe
            var recipe = new CatRecipe
            {
                name = recipeJson.Name,
                price = recipeJson.Price,
                imagePath = recipeJson.ImagePath,
                fkCatSize = recipeJson.FkCatSize
            };

            dbContext.CatRecipe.Add(recipe);
            await dbContext.SaveChangesAsync();

            // Get the identifier of the inserted recipe
            int idCatRecipe = recipe.idCatRecipe;

            // Insert color details
            if (recipeJson.ColorIds != null && recipeJson.ColorIds.Count > 0)
            {
                var colorJson = new ColorJsonDto
                {
                    IdCatalog = idCatRecipe,
                    ColorIds = recipeJson.ColorIds
                };

                await InsertDetailColors(colorJson);
            }

            // Insert raw material details
            if (recipeJson.RawMaterials != null && recipeJson.RawMaterials.Count > 0)
            {
                var rawMaterialJsonList = new List<RawMaterialJsonDto>();
                foreach (var rawMaterial in recipeJson.RawMaterials)
                {
                    rawMaterialJsonList.Add(new RawMaterialJsonDto
                    {
                        IdCatalog = idCatRecipe,
                        Quantity = rawMaterial.Quantity,
                        FkCatRawMaterial = rawMaterial.FkCatRawMaterial
                    });
                }

                await InsertDetailRawMaterial(rawMaterialJsonList);
            }

            return Ok("Recipe inserted successfully.");
        }


        [HttpPost]
        [Route("InsertDetailColors")]
        public async Task<IActionResult> InsertDetailColors([FromBody] ColorJsonDto colorJson)
        {
            // Check if the catalog exists
            var catalog = await dbContext.CatRecipe.FirstOrDefaultAsync(c => c.idCatRecipe == colorJson.IdCatalog);
            if (catalog == null)
            {
                return NotFound("Catalog not found.");
            }

            // Validate if there are colors to insert
            if (colorJson?.ColorIds == null || !colorJson.ColorIds.Any())
            {
                return BadRequest("The color JSON is invalid or empty.");
            }

            // Insert color details
            foreach (int colorId in colorJson.ColorIds)
            {
                var color = await dbContext.CatColor.FirstOrDefaultAsync(c => c.idCatColor == colorId);
                if (color != null)
                {
                    var detailColor = new DetailRecipeColor
                    {
                        fkCatRecipe = colorJson.IdCatalog,
                        fkCatColor = colorId
                    };
                    dbContext.DetailRecipeColor.Add(detailColor);
                }
            }

            await dbContext.SaveChangesAsync();

            return Ok("Color details inserted correctly.");
        }


        [HttpPost]
        [Route("InsertDetailRawMaterial")]
        public async Task<IActionResult> InsertDetailRawMaterial([FromBody] List<RawMaterialJsonDto> rawMaterialJsonList)
        {
            // Check if the catalog exists
            int idCatalog = rawMaterialJsonList.FirstOrDefault()?.IdCatalog ?? 0;
            var catalog = await dbContext.CatRecipe.FirstOrDefaultAsync(c => c.idCatRecipe == idCatalog);
            if (catalog == null)
            {
                return NotFound("Catalog not found.");
            }

            // Validation of existing materials
            if (rawMaterialJsonList == null || rawMaterialJsonList.Count == 0)
            {
                return BadRequest("The raw materials JSON is invalid or empty.");
            }

            // Insert detailRawMaterial
            foreach (var rawMaterialJson in rawMaterialJsonList)
            {
                var rawMaterial = await dbContext.CatRawMaterial.FirstOrDefaultAsync(r => r.idCatRawMaterial == rawMaterialJson.FkCatRawMaterial);
                if (rawMaterial != null)
                {
                    var detailRawMaterial = new DetailRecipeRawMaterial
                    {
                        fkCatRecipe = idCatalog,
                        quantity = rawMaterialJson.Quantity,
                        fkCatRawMaterial = rawMaterialJson.FkCatRawMaterial
                    };
                    dbContext.DetailRecipeRawMaterial.Add(detailRawMaterial);
                }
            }

            await dbContext.SaveChangesAsync();

            return Ok("Details of raw materials inserted correctly.");
        }


    }
}