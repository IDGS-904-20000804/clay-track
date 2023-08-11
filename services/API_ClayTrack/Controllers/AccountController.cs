using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Repositories.Token;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using static API_ClayTrack.Controllers.AccountController;
using static com.sun.tools.@internal.xjc.reader.xmlschema.bindinfo.BIConversion;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<IdentityUser> userManager;
        private readonly ITokenRepository tokenRepository;
        private readonly ClayTrackDbContext dbContext;

        public AccountController(UserManager<IdentityUser> userManager, ITokenRepository tokenRepository,
            ClayTrackDbContext dbContext)
        {
            this.userManager = userManager;
            this.tokenRepository = tokenRepository;
            this.dbContext = dbContext;
        }


        // POST: /api/Auth/Register
        [HttpPost]
        [Route("Register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequestDto registerRequestDto)
        {
            var identityUser = new IdentityUser
            {
                UserName = registerRequestDto.Username,
                Email = registerRequestDto.Username
            };

            var identityResult = await userManager.CreateAsync(identityUser, registerRequestDto.Password);

            if (identityResult.Succeeded)
            {
                // Add roles to this User
                if (registerRequestDto.Roles != null && registerRequestDto.Roles.Any())
                {
                    identityResult = await userManager.AddToRolesAsync(identityUser, registerRequestDto.Roles);

                    if (identityResult.Succeeded)
                    {
                        return Ok("User was registered! Please login.");
                    }
                }
            }

            return BadRequest("Something went wrong");
        }

        /*[HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromBody] LoginRequestDto loginRequestDto)
        {
            var user = await userManager.FindByEmailAsync(loginRequestDto.Username);

            if (user != null)
            {
                var checkPasswordResult = await userManager.CheckPasswordAsync(user, loginRequestDto.Password);

                if (checkPasswordResult)
                {
                    var roles = await userManager.GetRolesAsync(user);

                    if (roles != null)
                    {
                        var jwtToken = tokenRepository.CreateJWTToken(user, roles.ToList());

                        var response = new LoginResponseDto
                        {
                            JwtToken = jwtToken
                        };

                        return Ok(response);
                    }
                }
            }
            return BadRequest("Username or password incorrect");
        }*/

        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromBody] LoginRequestDto loginRequestDto)
        {
            var user = await userManager.FindByEmailAsync(loginRequestDto.Username);

            if (user != null)
            {
                var client = await dbContext.CatClient.FirstOrDefaultAsync(c => c.fkUser == user.Id);
                var employee = await dbContext.CatEmployee.FirstOrDefaultAsync(e => e.fkUser == user.Id);

                bool isClientEnabled = client?.status ?? false;
                bool isEmployeeEnabled = employee?.status ?? false;

                if (isClientEnabled || isEmployeeEnabled)
                {
                    var checkPasswordResult = await userManager.CheckPasswordAsync(user, loginRequestDto.Password);

                    if (checkPasswordResult)
                    {
                        // Get Roles for this user
                        var roles = await userManager.GetRolesAsync(user);

                        if (roles != null)
                        {
                            // Create Token
                            var jwtToken = tokenRepository.CreateJWTToken(user, roles.ToList());

                            var response = new LoginResponseDto
                            {
                                JwtToken = jwtToken
                            };

                            return Ok(response);
                        }
                    }
                }
            }

            return BadRequest("Username or password incorrect");
        }

    }
}
