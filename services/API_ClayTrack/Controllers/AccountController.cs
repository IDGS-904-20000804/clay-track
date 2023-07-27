using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using API_ClayTrack.DTOs;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using static com.sun.tools.@internal.xjc.reader.xmlschema.bindinfo.BIConversion;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<IdentityUser> userManager;
        private readonly IConfiguration configuration;
        private readonly SignInManager<IdentityUser> signInManager;

        public AccountController(UserManager<IdentityUser> userManager, IConfiguration configuration,
            SignInManager<IdentityUser> signInManager)
        {
            this.userManager = userManager;
            this.configuration = configuration;
            this.signInManager = signInManager;
        }

        [HttpPost]
        [Route("register")]
        public async Task<ActionResult<AuthenticationResponse>> Register(UserCredentials userCredentials)
        {
            var user = new IdentityUser
            {
                UserName = userCredentials.Email,
                Email = userCredentials.Email
            };
            var result = await userManager.CreateAsync(user, userCredentials.Password);

            if (result.Succeeded)
            {
                return await ContructorToken(userCredentials);
            }
            else
            {
                return BadRequest(result.Errors);
            }
        }

        [HttpPost]
        [Route("login")]
        public async Task<ActionResult<AuthenticationResponse>> Login(UserCredentials userCredentials) 
        {
            var result = await signInManager.PasswordSignInAsync(userCredentials.Email,
                userCredentials.Password, isPersistent: false, lockoutOnFailure: false);

            if (result.Succeeded)
            {
                return await ContructorToken(userCredentials);
            }
            else
            {
                return BadRequest("Incorrect login");
            }
        }

        [HttpGet]
        [Route("Renew Token")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<ActionResult<AuthenticationResponse>> Renew()
        {
            var emailClaim = HttpContext.User.Claims.Where(claim => claim.Type == "email").FirstOrDefault();
            var email = emailClaim.Value;
            var userCredentials = new UserCredentials()
            {
                Email = email
            };

            return await ContructorToken(userCredentials);
        }

        private async Task<AuthenticationResponse> ContructorToken(UserCredentials userCredentials) 
        {
            var claims = new List<Claim>()
            {
                new Claim("email", userCredentials.Email)
            };

            var user = await userManager.FindByEmailAsync(userCredentials.Email);
            var claimsDB = await userManager.GetClaimsAsync(user);

            claims.AddRange(claimsDB);

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["keyjwt"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var expirate = DateTime.UtcNow.AddMinutes(120);

            var securityToken = new JwtSecurityToken(issuer: null, audience: null, claims: claims,
                expires: expirate, signingCredentials: creds);


            return new AuthenticationResponse()
            {
                Token = new JwtSecurityTokenHandler().WriteToken(securityToken),
                Expiration = expirate
            };

        }

        [HttpPost]
        [Route("CreateAdmin")]
        public async Task<ActionResult> CreateAdmin(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.AddClaimAsync(user, new Claim("Admin", "1"));
            return NoContent();
        }

        [HttpPost("RemoveAdmin")]
        public async Task<ActionResult> RemoveAdmin(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.RemoveClaimAsync(user, new Claim("Admin", "1"));
            return NoContent();
        }

        [HttpPost]
        [Route("CreateEmployee")]
        public async Task<ActionResult> CreateEmployee(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.AddClaimAsync(user, new Claim("Employee", "2"));
            return NoContent();
        }

        [HttpPost("RemoveEmployee")]
        public async Task<ActionResult> RemoveEmployee(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.RemoveClaimAsync(user, new Claim("Employee", "2"));
            return NoContent();
        }

        [HttpPost]
        [Route("CreateClient")]
        public async Task<ActionResult> CreateClient(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.AddClaimAsync(user, new Claim("Client", "3"));
            return NoContent();
        }

        [HttpPost("RemoveClient")]
        public async Task<ActionResult> RemoveClient(EditRolDTO editRolDTO)
        {
            var user = await userManager.FindByEmailAsync(editRolDTO.Email);
            await userManager.RemoveClaimAsync(user, new Claim("Client", "3"));
            return NoContent();
        }
    }
}
