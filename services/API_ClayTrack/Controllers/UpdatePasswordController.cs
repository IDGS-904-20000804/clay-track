using API_ClayTrack.Repositories.Password;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UpdatePasswordController : ControllerBase
    {
        /*private readonly PasswordHashingService passwordHashingService;

        public UpdatePasswordController(PasswordHashingService passwordHashingService)
        {
            this.passwordHashingService = passwordHashingService;
        }*/
        /*[HttpPut]
        [Route("UpdateClientPassword/{id}")]
        public async Task<ActionResult> UpdateClientPassword(int id, [FromBody] UpdatePasswordDto passwordModel)
        {
            try
            {
                var existingClient = await dbContext.CatClient
                    .Include(c => c.User)
                    .FirstOrDefaultAsync(c => c.idCatClient == id);

                if (existingClient == null)
                {
                    return NotFound("Client not found");
                }

                var existingUser = await userManager.FindByIdAsync(existingClient.fkUser);

                if (existingUser == null)
                {
                    return NotFound("User not found");
                }

                var newPasswordHash = userManager.PasswordHasher.HashPassword(existingUser, passwordModel.NewPassword);
                existingUser.PasswordHash = newPasswordHash;

                dbContext.Update(existingUser);
                await dbContext.SaveChangesAsync();

                return Ok("Client password was updated successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }*/

/*
        [HttpPost]
        [Route("HashPasswords")]
        public ActionResult HashPasswords([FromBody] Dictionary<string, string> unhashedPasswords)
        {
            var hashedPasswords = passwordHashingService.HashPasswords(unhashedPasswords);
            return Ok(hashedPasswords);
        }*/

    }
}
