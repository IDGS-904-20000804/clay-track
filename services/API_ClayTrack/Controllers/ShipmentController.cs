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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class ShipmentController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public ShipmentController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<ShipmentDto>>> GetAll()
        {
            var shipments = await dbContext.CatShipment
                .Include(s => s.Sale)
                .Include(s => s.Employee)
                .Where(s => !s.delivered)
                .Select(s => new ShipmentDto
                {
                    //Shipment
                    idCatShipment = s.idCatShipment,
                    delivered = s.delivered,
                    creationDate = s.creationDate,
                    updateDate = s.updateDate,

                    //Sale
                    fkCatSale = s.fkCatSale,
                    total = s.Sale.total,

                    //Employee
                    fkCatEmployee = s.fkCatEmployee,
                    EmployeeName = s.Employee.Person.name,
                    EmployeeEmail = s.Employee.User.Email,
                    EmployeelastName = s.Employee.Person.lastName,
                    EmployeePhone = s.Employee.Person.phone,

                    //Client
                    fkCatClient = s.Sale.fkCatClient,
                    ClientName = s.Sale.Client.Person.name,
                    ClientlastName = s.Sale.Client.Person.lastName,
                    ClientPhone = s.Sale.Client.Person.phone,
                    ClientEmail = s.Sale.Client.User.Email,
                    postalCode = s.Sale.Client.Person.postalCode,
                    streetNumber = s.Sale.Client.Person.streetNumber,
                    apartmentNumber = s.Sale.Client.Person.apartmentNumber,
                    street = s.Sale.Client.Person.street,
                    neighborhood = s.Sale.Client.Person.neighborhood,
                })
                .ToListAsync();

            return shipments;
        }

        [HttpGet]
        [Route("GetAllDelivered")]
        public async Task<ActionResult<List<ShipmentDto>>> GetAllDelivered()
        {
            var shipments = await dbContext.CatShipment
                .Include(s => s.Sale)
                .Include(s => s.Employee)
                .Where(s => s.delivered)
                .Select(s => new ShipmentDto
                {
                    //Shipment
                    idCatShipment = s.idCatShipment,
                    delivered = s.delivered,
                    creationDate = s.creationDate,
                    updateDate = s.updateDate,

                    //Sale
                    fkCatSale = s.fkCatSale,
                    total = s.Sale.total,

                    //Employee
                    fkCatEmployee = s.fkCatEmployee,
                    EmployeeName = s.Employee.Person.name,
                    EmployeeEmail = s.Employee.User.Email,
                    EmployeelastName = s.Employee.Person.lastName,
                    EmployeePhone = s.Employee.Person.phone,

                    //Client
                    fkCatClient = s.Sale.fkCatClient,
                    ClientName = s.Sale.Client.Person.name,
                    ClientlastName = s.Sale.Client.Person.lastName,
                    ClientPhone = s.Sale.Client.Person.phone,
                    ClientEmail = s.Sale.Client.User.Email,
                    postalCode = s.Sale.Client.Person.postalCode,
                    streetNumber = s.Sale.Client.Person.streetNumber,
                    apartmentNumber = s.Sale.Client.Person.apartmentNumber,
                    street = s.Sale.Client.Person.street,
                    neighborhood = s.Sale.Client.Person.neighborhood,
                })
                .ToListAsync();

            return shipments;
        }

        [HttpPut]
        [Route("Delivered{id:int}")]
        public async Task<ActionResult> Delivered(int id)
        {
            var shipment = await dbContext.CatShipment
                .Include(s => s.Employee)
                .Include(s => s.Sale)
                .FirstOrDefaultAsync(c => c.idCatShipment == id);

            if (shipment == null)
            {
                return NotFound();
            }

            shipment.delivered = true;
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpGet]
        [Route("GetAllForClient")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Client,Employee,Admin")]
        public async Task<ActionResult<List<SaleClient>>> GetAllForClient(int clientId)
        {

            var saleClients = await dbContext.CatShipment
                .Include(s => s.Sale)
                .Include(s => s.Employee)
                .Where(s => !s.delivered && s.Sale.fkCatClient == clientId)
                .Select(s => new SaleClient
                {
                    // Shipment
                    idCatShipment = s.idCatShipment,
                    delivered = s.delivered,
                    creationDate = s.creationDate,

                    // Sale
                    fkCatSale = s.fkCatSale,
                    total = s.Sale.total,

                    // DetailSale
                    DetailSale = dbContext.DetailSale
                        .Where(detailSale => detailSale.fkCatSale == s.fkCatSale)
                        .Select(detailSale => new DetailSale
                        {
                            idDetailSale = detailSale.idDetailSale,
                            quantity = detailSale.quantity,
                            price = detailSale.price,
                            fkCatRecipe = detailSale.fkCatRecipe,
                            Recipe = new CatRecipe
                            {
                                idCatRecipe = detailSale.Recipe.idCatRecipe,
                                name = detailSale.Recipe.name,
                                fkCatSize = detailSale.Recipe.fkCatSize,
                                Size = new CatSize
                                {
                                    idCatSize = detailSale.Recipe.Size.idCatSize,
                                    description = detailSale.Recipe.Size.description,
                                    abbreviation = detailSale.Recipe.Size.abbreviation
                                },
                                Image = new CatImage
                                {
                                    FilePath = detailSale.Recipe.Image.FilePath
                                }
                            }
                        })
                        .ToList(),


                    // Client
                    fkCatClient = s.Sale.fkCatClient,
                    ClientName = s.Sale.Client.Person.name,
                    ClientLastName = s.Sale.Client.Person.lastName,
                    ClientMiddleName = s.Sale.Client.Person.middleName,
                    ClientPhone = s.Sale.Client.Person.phone,
                    ClientEmail = s.Sale.Client.User.Email,
                    postalCode = s.Sale.Client.Person.postalCode,
                    streetNumber = s.Sale.Client.Person.streetNumber,
                    apartmentNumber = s.Sale.Client.Person.apartmentNumber,
                    street = s.Sale.Client.Person.street,
                    neighborhood = s.Sale.Client.Person.neighborhood,
                })
                .ToListAsync();

            return saleClients;
        }
    }
}