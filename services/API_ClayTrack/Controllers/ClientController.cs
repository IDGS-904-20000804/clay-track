using API_ClayTrack.DataBase;
using API_ClayTrack.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers
{
    // https://localhost:7106/api/Client
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ClientController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public ClientController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        public async Task<ActionResult<List<CatClient>>> GetAllClients()
        {
            return await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult> AddClient([FromBody] CatClient client)
        {
            dbContext.Add(client);
            await dbContext.SaveChangesAsync();
            return Ok();
        }


        [HttpPut]
        [Route("{id:int}")]
        public async Task<ActionResult> UpdateClient(CatClient client, int id)
        {
            if (client.idCatClient != id)
            {
                return BadRequest("Client id different from URL id");
            }

            var exist = await dbContext.CatClient.AnyAsync(x => x.idCatClient == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(client);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<ActionResult> DeleteClient(int id)
        {
            var exist = await dbContext.CatClient.AnyAsync(x => x.idCatClient == id);
            if (!exist)
            {
                return NotFound();
            }
            
            dbContext.Remove(new CatClient() { idCatClient = id});
            await dbContext.SaveChangesAsync();
            return Ok();
        }

    }
}
