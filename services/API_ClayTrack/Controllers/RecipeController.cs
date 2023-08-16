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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin,Employee")]
    public partial class RecipeController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public RecipeController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatRecipe>>> GetAllRecipe()
        {
            return await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .ToListAsync();
        }

        /*[HttpGet]
        [Route("GetOne{id:int}")]
        [AllowAnonymous]
        public async Task<ActionResult<CatRecipe>> GetRecipe(int id)
        {
            var recipe = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .FirstOrDefaultAsync(s => s.idCatRecipe == id);

            if (recipe == null)
            {
                return NotFound();
            }

            return Ok(recipe);
        }*/
        [HttpGet]
        [Route("GetOne/{id:int}")]
        [AllowAnonymous]
        public async Task<ActionResult<RecipeDetailDto>> GetRecipe(int id)
        {
            var recipe = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .FirstOrDefaultAsync(s => s.idCatRecipe == id);

            if (recipe == null)
            {
                return NotFound();
            }

            var colorIds = await dbContext.DetailRecipeColor
                .Where(d => d.fkCatRecipe == id)
                .Select(d => d.fkCatColor)
                .ToListAsync();

            var colors = await dbContext.CatColor
                .Where(c => colorIds.Contains(c.idCatColor))
                .ToListAsync();

            var rawMaterialDetails = await dbContext.DetailRecipeRawMaterial
                .Where(dr => dr.fkCatRecipe == id)
                .ToListAsync();

            var rawMaterialIds = rawMaterialDetails.Select(dr => dr.fkCatRawMaterial).ToList();

            var rawMaterials = await dbContext.CatRawMaterial
                .Where(rm => rawMaterialIds.Contains(rm.idCatRawMaterial))
                .ToListAsync();

            var rawMaterialDtos = rawMaterials.Select(rm => new RawMaterialSimpleDto
            {
                IdCatRawMaterial = rm.idCatRawMaterial,
                Name = rm.name
            }).ToList();

            var rawMaterialDetailsDto = rawMaterialDetails.Select(rm => new DetailRecipeRawMaterialSimpleDto
            {
                fkRawMaterial = rm.fkCatRawMaterial,
                Quantity = rm.quantity
            }).ToList();

            var recipeDetailsDto = new RecipeDetailDto
            {
                IdCatRecipe = recipe.idCatRecipe,
                Name = recipe.name,
                Price = recipe.price,
                FkCatImage = recipe.fkCatImage,
                FkCatSize = recipe.fkCatSize,
                Colors = colors,
                RawMaterials = rawMaterialDtos,
                RawMaterialDetails = rawMaterialDetailsDto
            };

            return Ok(recipeDetailsDto);
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
                fkCatImage = recipeJson.FkCatImage,
                fkCatSize = recipeJson.FkCatSize
            };

            dbContext.CatRecipe.Add(recipe);
            await dbContext.SaveChangesAsync();


            // Insert color details
            if (recipeJson.ColorIds != null && recipeJson.ColorIds.Count > 0)
            {
                var colorJson = new ColorJsonDto
                {
                    IdCatalog = recipe.idCatRecipe,
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
                        IdCatalog = recipe.idCatRecipe,
                        Quantity = rawMaterial.Quantity,
                        FkCatRawMaterial = rawMaterial.FkCatRawMaterial
                    });
                }

                await InsertDetailRawMaterial(rawMaterialJsonList);
            }

            return Ok("Recipe inserted successfully.");
        }

        [HttpPut]
        [Route("Update/{idCatRecipe:int}")]
        public async Task<IActionResult> Update(int idCatRecipe, [FromBody] RecipeJsonDto recipeJson)
        {
            // Check if the recipe JSON is valid
            if (recipeJson == null)
            {
                return BadRequest("The recipe JSON is invalid or empty.");
            }

            // Check if the provided idCatRecipe exists
            var existingRecipe = await dbContext.CatRecipe.FirstOrDefaultAsync(r => r.idCatRecipe == idCatRecipe);
            if (existingRecipe == null)
            {
                return NotFound("Recipe not found.");
            }

            // Update the existing recipe properties
            existingRecipe.name = recipeJson.Name;
            existingRecipe.price = recipeJson.Price;
            existingRecipe.fkCatImage = recipeJson.FkCatImage;
            existingRecipe.fkCatSize = recipeJson.FkCatSize;

            // Save the changes to the database
            await dbContext.SaveChangesAsync();

            // Update color details
            if (recipeJson.ColorIds != null)
            {
                // Get existing color details for the recipe
                var existingDetailColors = await dbContext.DetailRecipeColor
                    .Where(d => d.fkCatRecipe == idCatRecipe)
                    .ToListAsync();

                var existingColorIds = existingDetailColors.Select(dc => dc.fkCatColor).ToList();
                var newColorIds = recipeJson.ColorIds;

                // Calculate color IDs to add and remove
                var colorsToAdd = newColorIds.Except(existingColorIds).ToList();
                var colorsToRemove = existingColorIds.Except(newColorIds).ToList();

                // Add new color details
                foreach (var colorId in colorsToAdd)
                {
                    var detailColor = new DetailRecipeColor
                    {
                        fkCatRecipe = idCatRecipe,
                        fkCatColor = colorId
                    };
                    dbContext.DetailRecipeColor.Add(detailColor);
                }

                // Remove color details that are not selected anymore
                var detailsToRemove = existingDetailColors.Where(dc => colorsToRemove.Contains(dc.fkCatColor)).ToList();
                dbContext.DetailRecipeColor.RemoveRange(detailsToRemove);

                await dbContext.SaveChangesAsync();
            }

            // Insert raw material details
            if (recipeJson.RawMaterials != null)
            {
                // Get existing raw material details for the recipe
                var existingDetailRawMaterials = await dbContext.DetailRecipeRawMaterial
                    .Where(d => d.fkCatRecipe == idCatRecipe)
                    .ToListAsync();

                var existingRawMaterialIds = existingDetailRawMaterials.Select(dr => dr.fkCatRawMaterial).ToList();
                var newRawMaterials = recipeJson.RawMaterials;

                // Calculate raw material IDs to add and remove
                var rawMaterialsToAdd = newRawMaterials
                    .Where(newMaterial => !existingRawMaterialIds.Contains(newMaterial.FkCatRawMaterial))
                    .ToList();
                var rawMaterialsToRemove = existingRawMaterialIds
                    .Where(existingId => !newRawMaterials.Any(newMaterial => newMaterial.FkCatRawMaterial == existingId))
                    .ToList();

                // Add new raw material details
                foreach (var rawMaterial in rawMaterialsToAdd)
                {
                    var detailRawMaterial = new DetailRecipeRawMaterial
                    {
                        fkCatRecipe = idCatRecipe,
                        fkCatRawMaterial = rawMaterial.FkCatRawMaterial,
                        quantity = rawMaterial.Quantity
                    };
                    dbContext.DetailRecipeRawMaterial.Add(detailRawMaterial);
                }

                // Remove raw material details that are not selected anymore
                var detailsToRemove = existingDetailRawMaterials
                    .Where(dr => rawMaterialsToRemove.Contains(dr.fkCatRawMaterial))
                    .ToList();
                dbContext.DetailRecipeRawMaterial.RemoveRange(detailsToRemove);
            }

            return Ok("Recipe updated successfully.");
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