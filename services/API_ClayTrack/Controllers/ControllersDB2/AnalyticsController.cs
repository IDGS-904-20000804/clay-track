using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers.ControllersDB2
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnalyticsController : ControllerBase
    {
        private readonly ClayTrackAnalyticsDbContext dbContext;

        public AnalyticsController(ClayTrackAnalyticsDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<string>>> GetAll(DateTime targetDate, string type)
        {
            var graphic = await dbContext.Graphic
                .Where(b => b.type == type &&
                            b.date.HasValue &&
                            b.date.Value.Year == targetDate.Year &&
                            b.date.Value.Month == targetDate.Month)
                .Select(b => new { b.date, b.result })
                .ToListAsync();

            return Ok(graphic);
        }
    }
}
