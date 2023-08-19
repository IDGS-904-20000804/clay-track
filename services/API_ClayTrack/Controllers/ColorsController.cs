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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin,Employee")]
    public class ColorsController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public ColorsController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatColor>>> GetAll()
        {
            var color = await dbContext.CatColor
                .ToListAsync();

            return color;
        }

        [HttpPost]
        [Route("Add")]
        public async Task<ActionResult> AddColor([FromBody] CatColor color)
        {
            dbContext.Add(color);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

    }
}
