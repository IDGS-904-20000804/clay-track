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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin,Employee")]
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
        [Route("GetAll")]
        public async Task<ActionResult<List<CatClient>>> GetAllClient()
        {
            return await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .ToListAsync();
        }

        [HttpGet]
        [Route("GetOne{id:int}")]
        public async Task<ActionResult<CatClient>> GetClient(int id)
        {
            var client = await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .FirstOrDefaultAsync(c => c.idCatClient == id);

            if (client == null)
            {
                return NotFound();
            }

            return Ok(client);
        }


        [HttpPost]
        [Route("AddClient")]
        [AllowAnonymous]
        public async Task<ActionResult> AddClient([FromBody] CatClient client)
        {
            try
            {
                IdentityRole clientRole = dbContext.Roles.FirstOrDefault(r => r.Name == "Client");

                if (clientRole == null)
                {
                    return BadRequest("Role does not exist");
                }
                client.Role = clientRole;

                var user = new IdentityUser
                {
                    UserName = client.User.Email,
                    Email = client.User.Email
                };

                var password = client.User.PasswordHash;
                var identityResult = await userManager.CreateAsync(user, password);

                if (!identityResult.Succeeded)
                {
                    var errorMessage = string.Join(", ", identityResult.Errors.Select(c => c.Description));
                    return BadRequest(errorMessage);
                }

                client.User = user;
                dbContext.Add(client);
                await dbContext.SaveChangesAsync();
                await userManager.AddToRoleAsync(user, client.Role.Name);

                return Ok("Client was added successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpPut]
        [Route("Update{id:int}")]
        [AllowAnonymous]
        public async Task<ActionResult> UpdateClient(CatClient client, int id)
        {
            if (client.idCatClient != id)
            {
                return BadRequest("Client id different from URL id");
            }

            var exist = await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .Include(c => c.Role)
                .AnyAsync(x => x.idCatClient == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(client);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeleteClient(int id)
        {
            var client = await dbContext.CatClient
                .Include(c => c.Person)
                .Include(c => c.User)
                .FirstOrDefaultAsync(c => c.idCatClient == id);

            if (client == null)
            {
                return NotFound();
            }

            var user = await userManager.FindByIdAsync(client.fkUser);
            if (user != null)
            {
                var result = await userManager.DeleteAsync(user);
                if (!result.Succeeded)
                {
                    var errorMessage = string.Join(", ", result.Errors.Select(e => e.Description));
                    return BadRequest(errorMessage);
                }
            }

            dbContext.Remove(client.Person); 
            dbContext.Remove(client);

            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}