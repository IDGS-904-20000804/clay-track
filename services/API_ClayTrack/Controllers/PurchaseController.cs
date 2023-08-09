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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class PurchaseController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;
        private readonly UserManager<IdentityUser> userManager;

        public PurchaseController(ClayTrackDbContext dbContext, 
            UserManager<IdentityUser> userManager)
        {
            this.dbContext = dbContext;
            this.userManager = userManager;
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

        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddPurchase([FromBody] CatPurchase purchase)
        {
            var user = await userManager.GetUserAsync(User);

            if (user == null)
            {
                return Unauthorized();
            }

            var employee = dbContext.CatEmployee.FirstOrDefault(e => e.fkUser == user.Id);

            if (employee == null)
            {
                return NotFound("Employee not found.");
            }

            purchase.fkCatEmployee = employee.idCatEmployee;

            dbContext.Add(purchase);
            await dbContext.SaveChangesAsync();

            return Ok();
        }



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
