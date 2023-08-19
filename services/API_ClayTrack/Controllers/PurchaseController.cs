using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using API_ClayTrack.Repositories.Token;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
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

        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult<PurchaseDto>> GetPurchaseById(int id)
        {
            var purchase = await dbContext.CatPurchase
                .Include(p => p.Supplier.Person)
                .Include(p => p.Employee.Person)
                .FirstOrDefaultAsync(p => p.idCatPurchase == id);

            if (purchase == null)
            {
                return NotFound();
            }

            var purchaseDto = new PurchaseDto
            {
                idCatPurchase = purchase.idCatPurchase,
                total = purchase.total,
                fkCatSupplier = purchase.fkCatSupplier,
                email = purchase.Supplier.email,
                idCatPersonSupplier = purchase.Supplier.Person.idCatPerson,
                nameSupplier = purchase.Supplier.Person.name,
                lastNameSupplier = purchase.Supplier.Person.lastName,
                middleNameSupplier = purchase.Supplier.Person.middleName,
                phoneSupplier = purchase.Supplier.Person.phone,
                fkCatEmployee = purchase.fkCatEmployee,
                idCatPersonEmployee = purchase.Employee.Person.idCatPerson,
                nameEmployee = purchase.Employee.Person.name,
                lastNameEmployee = purchase.Employee.Person.lastName,
                middleNameEmployee = purchase.Employee.Person.middleName,
                phoneEmployee = purchase.Employee.Person.phone,
                Details = dbContext.DetailPurchase
                        .Where(d => d.fkCatPurchase == purchase.idCatPurchase)
                        .Select(d => new DetailPurchaseDto
                        {
                            idDetailPurchase = d.idDetailPurchase,
                            quantity = d.quantity,
                            price = d.price,
                            fkCatRawMaterial = d.fkCatRawMaterial,
                            rawMaterialName = d.RawMaterial.name
                        }).ToList(),
            };

            return purchaseDto;
        }


        [HttpPost]
        [Route("Add")]
        public async Task<IActionResult> AddPurchase([FromBody] PurchaseJsonDto purchaseJsonDto)
        {
            // Check if the purchase JSON is valid
            if (purchaseJsonDto == null)
            {
                return BadRequest("The recipe JSON is invalid or empty.");
            }

            // Calculate the total value
            float total = 0.0f;
            if (purchaseJsonDto.RawMaterials != null && purchaseJsonDto.RawMaterials.Count > 0)
            {
                foreach (var rawMaterial in purchaseJsonDto.RawMaterials)
                {
                    total += rawMaterial.Price * rawMaterial.Quantity;

                    // Update quantityWarehouse and status of the raw material
                    var rawMaterialEntity = await dbContext.CatRawMaterial.FirstOrDefaultAsync(r => r.idCatRawMaterial == rawMaterial.FkCatRawMaterial);
                    if (rawMaterialEntity != null)
                    {
                        rawMaterialEntity.quantityWarehouse += rawMaterial.Quantity;
                        if (rawMaterialEntity.status == false)
                        {
                            rawMaterialEntity.status = true;
                        }
                    }
                }
            }

            // Create the purchase entity
            var purchase = new CatPurchase
            {
                total = total,
                fkCatSupplier = purchaseJsonDto.fkCatSupplier,
                fkCatEmployee = purchaseJsonDto.fkCatEmployee
            };

            // Add the purchase to the context and save changes to get the ID
            dbContext.CatPurchase.Add(purchase);
            await dbContext.SaveChangesAsync();

            // Use the ID of the inserted purchase to associate details
            if (purchaseJsonDto.RawMaterials != null && purchaseJsonDto.RawMaterials.Count > 0)
            {
                foreach (var rawMaterial in purchaseJsonDto.RawMaterials)
                {
                    var detailRawMaterial = new DetailPurchase
                    {
                        fkCatPurchase = purchase.idCatPurchase,
                        quantity = rawMaterial.Quantity,
                        fkCatRawMaterial = rawMaterial.FkCatRawMaterial,
                        price = rawMaterial.Price
                    };
                    dbContext.DetailPurchase.Add(detailRawMaterial);
                }
                await dbContext.SaveChangesAsync();
            }

            return Ok("Purchase added successfully.");
        }




        [HttpPost]
        [Route("InsertDetailRawMaterial")]
        public async Task<IActionResult> InsertDetailRawMaterial([FromBody] List<RawMaterialJsonDto> rawMaterialJsonList)
        {
            // Check if the catalog exists
            int idCatalog = rawMaterialJsonList.FirstOrDefault()?.IdCatalog ?? 0;
            var catalog = await dbContext.CatPurchase.FirstOrDefaultAsync(c => c.idCatPurchase == idCatalog);
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
                    var detailRawMaterial = new DetailPurchase
                    {
                        fkCatPurchase = idCatalog,
                        quantity = rawMaterialJson.Quantity,
                        fkCatRawMaterial = rawMaterialJson.FkCatRawMaterial
                    };
                    dbContext.DetailPurchase.Add(detailRawMaterial);
                }
            }

            await dbContext.SaveChangesAsync();

            return Ok("Details of raw materials inserted correctly.");
        }
    }
}
