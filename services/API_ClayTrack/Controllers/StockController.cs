﻿using API_ClayTrack.DataBase;
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
                .Include(r => r.Image)
                .ToListAsync();
            //Poner solo que se muestre cuando receta sea 1 corrección
            var stockDto = stock.Select(r => new StockDto
            {
                Name = r.name,
                FkCatImage = r.fkCatImage,
                Price = r.price,
                QuantityStock = r.quantityStock,
                Size = r.Size
            }).ToList();

            return stockDto;
        }

        [HttpGet]
        [Route("GetOne{id:int}")]
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
        public async Task<ActionResult> DeleteStock(int id)
        {
            var stock = await dbContext.CatRecipe
                .Include(r => r.Size)
                .Include(r => r.Image)
                .FirstOrDefaultAsync(r => r.idCatRecipe == id);

            if (stock == null)
            {
                return NotFound();
            }

            stock.status = false;
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("InsertStock")]
        public IActionResult InsertStock(int idCatRecipe, int totalRecipes)
        {
            // Obtener la receta por su identificador
            var recipe = dbContext.CatRecipe.FirstOrDefault(r => r.idCatRecipe == idCatRecipe);

            if (recipe == null)
            {
                return NotFound();
            }

            // Verificar si hay suficiente materia prima para producir las recetas
            bool isEnough = CheckRawMaterialByRecipe(idCatRecipe, totalRecipes);

            if (isEnough)
            {
                // Realizar las actualizaciones en la base de datos
                UpdateRawMaterialQuantity(idCatRecipe, totalRecipes);
                UpdateRecipeStock(idCatRecipe, totalRecipes);

                // Guardar los cambios en la base de datos
                dbContext.SaveChanges();

                return Ok("Stock inserted successfully.");
            }

            return BadRequest("Not enough raw material to produce the recipes.");
        }

        private bool CheckRawMaterialByRecipe(int idCatRecipe, int totalRecipes)
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

                if (rawMaterial == null || rawMaterial.quantityWarehouse < recipeRawMaterial.RequiredQuantity)
                {
                    return false;
                }
            }

            return true;
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
                }
            }
        }


        private void UpdateRecipeStock(int idCatRecipe, int totalRecipes)
        {
            var recipe = dbContext.CatRecipe.FirstOrDefault(r => r.idCatRecipe == idCatRecipe);
            if (recipe != null)
            {
                recipe.quantityStock += totalRecipes;
            }
        }

    }
}