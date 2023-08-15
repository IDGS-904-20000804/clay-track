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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin,Client")]
    public class SaleController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public SaleController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        /*[HttpPost]
        [Route("AddSales")]
        public async Task<IActionResult> AddSales([FromBody] DetailSaleDto detailSaleDto)
        {
            var recipe = dbContext.CatRecipe.Find(detailSaleDto.fkCatRecipe);
            if (recipe == null)
            {
                return BadRequest("The recipe is invalid.");
            }

            if (recipe.quantityStock < detailSaleDto.quantity || detailSaleDto.quantity <= 0)
            {
                return BadRequest("Insufficient stock or invalid quantity.");
            }

            float totalForSale = recipe.price * detailSaleDto.quantity;

            var sale = new CatSale
            {
                total = totalForSale,
                fkCatClient = detailSaleDto.fkCatClient
            };
            dbContext.CatSale.Add(sale);

            await dbContext.SaveChangesAsync();

            var detailSale = new DetailSale
            {
                quantity = detailSaleDto.quantity,
                price = recipe.price,
                fkCatRecipe = detailSaleDto.fkCatRecipe,
                fkCatSale = sale.idCatSale
            };
            dbContext.DetailSale.Add(detailSale);

            recipe.quantityStock -= detailSaleDto.quantity;

            if (recipe.quantityStock == 0)
            {
                recipe.status = false;
            }

            await dbContext.SaveChangesAsync();

            var catSaleToUpdate = dbContext.CatSale.Find(sale.idCatSale);
            if (catSaleToUpdate != null)
            {
                catSaleToUpdate.total = dbContext.DetailSale
                    .Where(ds => ds.fkCatSale == sale.idCatSale)
                    .Sum(ds => ds.quantity * ds.price);
                await dbContext.SaveChangesAsync();
            }

            var shipment = new CatShipment
            {
                delivered = false,
                fkCatSale = sale.idCatSale
            };
            var randomEmployeeId = GetRandomEmployeeId();
            shipment.fkCatEmployee = randomEmployeeId;

            dbContext.CatShipment.Add(shipment);

            await dbContext.SaveChangesAsync();

            return Ok("Sale added successfully.");
        }*/

        [HttpPost]
        [Route("AddSales")]
        public async Task<IActionResult> AddSales([FromBody] SaleDto saleDto)
        {
            // Crear la venta
            var sale = new CatSale
            {
                total = 0, // Set the total to 0 for now, will be calculated later
                fkCatClient = saleDto.fkCatClient,
                creationDate = DateTime.Now, // Set the creation date
                updateDate = DateTime.Now // Set the update date
            };
            dbContext.CatSale.Add(sale);
            await dbContext.SaveChangesAsync();

            float totalForSale = 0;

            foreach (var detailSaleDto in saleDto.DetailSales)
            {
                var recipe = dbContext.CatRecipe.Find(detailSaleDto.fkCatRecipe);
                if (recipe == null)
                {
                    return BadRequest("Recipe not found.");
                }

                if (recipe.quantityStock < detailSaleDto.quantity || detailSaleDto.quantity <= 0)
                {
                    return BadRequest("Insufficient stock or invalid quantity for recipe.");
                }

                var detailSale = new DetailSale
                {
                    quantity = detailSaleDto.quantity,
                    price = recipe.price,
                    fkCatRecipe = detailSaleDto.fkCatRecipe,
                    fkCatSale = sale.idCatSale
                };
                dbContext.DetailSale.Add(detailSale);

                totalForSale += recipe.price * detailSaleDto.quantity;

                recipe.quantityStock -= detailSaleDto.quantity;

                if (recipe.quantityStock == 0)
                {
                    recipe.status = false;
                }
            }

            sale.total = totalForSale;

            await dbContext.SaveChangesAsync();

            var catSaleToUpdate = dbContext.CatSale.Find(sale.idCatSale);
            if (catSaleToUpdate != null)
            {
                catSaleToUpdate.total = dbContext.DetailSale
                    .Where(ds => ds.fkCatSale == sale.idCatSale)
                    .Sum(ds => ds.quantity * ds.price);
                await dbContext.SaveChangesAsync();
            }

            var shipment = new CatShipment
            {
                delivered = false,
                fkCatSale = sale.idCatSale
            };
            var randomEmployeeId = GetRandomEmployeeId();
            shipment.fkCatEmployee = randomEmployeeId;

            dbContext.CatShipment.Add(shipment);

            await dbContext.SaveChangesAsync();

            return Ok("Sale added successfully.");
        }




        private int GetRandomEmployeeId()
        {
            var employeeIds = dbContext.CatEmployee.Select(e => e.idCatEmployee).ToList();

            var random = new Random();
            var randomIndex = random.Next(0, employeeIds.Count);

            return employeeIds[randomIndex];
        }
    }
}
