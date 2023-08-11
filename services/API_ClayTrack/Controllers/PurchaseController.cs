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
        public async Task<ActionResult> AddPurchase([FromBody] PurchaseDto purchaseDto)
        {
            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

            var employeeId = GetEmployeeIdFromDatabase(userId);

            purchaseDto.fkCatEmployee = employeeId;

            var purchase = new CatPurchase
            {
                total = purchaseDto.total,
                fkCatSupplier = purchaseDto.fkCatSupplier,
                fkCatEmployee = employeeId
            };
            

            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();

            return Ok();
        }*/

       /* [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {
            string userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            int employeeId = GetEmployeeIdFromDatabase(userId);


            purchase.fkCatEmployee = employeeId;

            purchase.Supplier = dbContext.CatSupplier.FirstOrDefault(s => s.idCatSupplier == purchase.fkCatSupplier);

            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();

            return Ok();
        }




        private int GetEmployeeIdFromDatabase(string userId)
        {
            var employee = dbContext.CatEmployee.FirstOrDefault(e => e.fkUser == userId);
            return employee?.idCatEmployee ?? 0;
        }*/





        /*[HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {

            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();
            return Ok();
        }*

        /* [HttpGet]


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
         }*/
    }
}
