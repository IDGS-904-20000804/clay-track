using System.Security.Claims;
using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using javax.management.relation;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sun.security.krb5.@internal;

namespace API_ClayTrack.Controllers
{
    // https://localhost:7106/api/Client
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Policy = "Employee")]
    public class ClientController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;
        private readonly UserManager<IdentityUser> userManager;

        public ClientController(ClayTrackDbContext dbContext,
            UserManager<IdentityUser> userManager)
        {
            this.dbContext = dbContext;
            this.userManager = userManager;
        }

        [HttpGet]
        public async Task<ActionResult<List<CatClient>>> GetAllClients()
        {
            return await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .Include(c => c.Role)
                .ToListAsync();
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> AddClient([FromBody] CatClient client)
        {
            IdentityRole clientRole = dbContext.Roles.FirstOrDefault(r => r.Name == "Client");

            if (clientRole == null)
            {
                return BadRequest("Role does not exist");
            }
            client.Role = clientRole;

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
