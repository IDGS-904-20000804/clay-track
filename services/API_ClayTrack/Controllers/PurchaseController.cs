using System.Security.Claims;
using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using API_ClayTrack.Repositories.Token;
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
    public class PurchaseController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;
        private readonly UserManager<IdentityUser> userManager;
        private readonly ITokenRepository tokenRepository;

        public PurchaseController(ClayTrackDbContext dbContext, 
            UserManager<IdentityUser> userManager,
            ITokenRepository tokenRepository)
        {
            this.dbContext = dbContext;
            this.userManager = userManager;
            this.tokenRepository = tokenRepository;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<PurchaseDto>>> GetAllPurchase()
        {
            var purchases = await dbContext.CatPurchase
                .Include(p => p.Supplier.Person)
                .Include(p => p.Employee.Person)
                .ToListAsync();

            var purchaseDto = purchases.Select(p => new PurchaseDto
            {
                //Recipe
                idCatPurchase = p.idCatPurchase,
                total = p.total,

                //Supplier
                fkCatSupplier = p.fkCatSupplier,
                email = p.Supplier.email,
                nameSupplier = p.Supplier.Person.name,
                lastNameSupplier = p.Supplier.Person.lastName,
                middleNameSupplier = p.Supplier.Person.middleName,
                phoneSupplier = p.Supplier.Person.phone,

                //Employee
                fkCatEmployee = p.fkCatEmployee,
                nameEmployee = p.Employee.Person.name,
                lastNameEmployee = p.Employee.Person.lastName,
                middleNameEmployee = p.Employee.Person.middleName,
                phoneEmployee = p.Employee.Person.phone,
            }).ToList();

            return purchaseDto;
        }

        /*[HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {
            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();
            return Ok();
        }*/

        /*[HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {
            string userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var employee = GetEmployeeFromDatabase(userId);

            if (employee != null)
            {
                purchase.fkCatEmployee = employee.idCatEmployee;

                dbContext.Add(purchase);
                await dbContext.SaveChangesAsync();

                return Ok();
            }
            else
            {
                return NotFound("Employee not found.");
            }
        }

        private CatEmployee GetEmployeeFromDatabase(string userId)
        {
            var employee = dbContext.CatEmployee
                .Include(e => e.Person)
                .FirstOrDefault(e => e.fkUser == userId);

            return employee;
        }*/

        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {
            string userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var employee = GetEmployeeFromDatabase(userId);

            if (employee != null)
            {
                purchase.fkCatEmployee = employee.idCatEmployee;

                dbContext.Add(purchase);
                await dbContext.SaveChangesAsync();

                // Actualiza los totales
                await UpdateTotalPurchase();
                await UpdateTotalRawMaterial(purchase.idCatPurchase);

                return Ok();
            }
            else
            {
                return NotFound("Employee not found.");
            }
        }

        private CatEmployee GetEmployeeFromDatabase(string userId)
        {
            var employee = dbContext.CatEmployee
                .Include(e => e.Person)
                .FirstOrDefault(e => e.fkUser == userId);

            return employee;
        }

        private async Task UpdateTotalRawMaterial(int purchaseId)
        {
            var subquery = dbContext.DetailPurchase
                .Where(dp => dp.fkCatPurchase == purchaseId)
                .GroupBy(dp => dp.fkCatRawMaterial)
                .Select(g => new
                {
                    fkCatRawMaterial = g.Key,
                    sum_quantity = g.Sum(dp => dp.quantity)
                });

            var rawMaterialToUpdate = await dbContext.CatRawMaterial
                .Join(subquery,
                    rawMaterial => rawMaterial.idCatRawMaterial,
                    sub => sub.fkCatRawMaterial,
                    (rawMaterial, sub) => new { RawMaterial = rawMaterial, Sub = sub })
                .ToListAsync();

            foreach (var rawMaterialInfo in rawMaterialToUpdate)
            {
                rawMaterialInfo.RawMaterial.quantityWarehouse = rawMaterialInfo.Sub.sum_quantity;
            }

            await dbContext.SaveChangesAsync();
        }

        private async Task UpdateTotalPurchase()
        {
            var subquery = dbContext.DetailPurchase
                .GroupBy(dp => dp.fkCatPurchase)
                .Select(g => new
                {
                    fkCatPurchase = g.Key,
                    sum_quantity = g.Sum(dp => dp.price)
                });

            var purchasesToUpdate = await dbContext.CatPurchase
                .Join(subquery,
                    purchase => purchase.idCatPurchase,
                    sub => sub.fkCatPurchase,
                    (purchase, sub) => new { Purchase = purchase, Sub = sub })
                .ToListAsync();

            foreach (var purchaseInfo in purchasesToUpdate)
            {
                purchaseInfo.Purchase.total = purchaseInfo.Sub.sum_quantity;
            }

            await dbContext.SaveChangesAsync();
        }
    }
}
