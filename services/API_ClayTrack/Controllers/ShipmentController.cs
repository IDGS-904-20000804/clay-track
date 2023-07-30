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
        public async Task<ActionResult<List<CatShipment>>> GetAll()
        {
            var shipment = await dbContext.CatShipment
                .Include(s => s.Sale)
                .Include(s => s.Employee)
                .Where(s => s.delivered == true)
                .ToListAsync();

            return shipment;
        }

        [HttpPost]
        public async Task<ActionResult> AddSupplier([FromBody] CatShipment shipment)
        {
            dbContext.Add(shipment);
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}