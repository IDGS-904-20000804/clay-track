using API_ClayTrack.DataBase;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace API_ClayTrack.Repositories.Token
{
    public class TokenRepository : ITokenRepository
    {
        private readonly IConfiguration configuration;
        private readonly ClayTrackDbContext dbContext;

        public TokenRepository(IConfiguration configuration, ClayTrackDbContext dbContext)
        {
            this.configuration = configuration;
            this.dbContext = dbContext;
        }


        public string CreateJWTToken(IdentityUser user, List<string> roles)
        {
            // Create claims
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email),
            };

            foreach (var role in roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role));

                if (role == "Client") // Assuming "Client" is the role for clients
                {
                    var clientId = GetClientIdFromDatabase(user.Id);
                    claims.Add(new Claim("ClientId", clientId.ToString()));
                }
                else if (role == "Employee") // Assuming "Employee" is the role for employees
                {
                    var employeeId = GetEmployeeIdFromDatabase(user.Id);
                    claims.Add(new Claim("EmployeeId", employeeId.ToString()));
                }
            }


            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                configuration["Jwt:Issuer"],
                configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddMinutes(60),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private int GetClientIdFromDatabase(string userId)
        {
            var client = dbContext.CatClient.FirstOrDefault(c => c.fkUser == userId);
            return client?.idCatClient ?? 0;
        }

        private int GetEmployeeIdFromDatabase(string userId)
        {
            var employee = dbContext.CatEmployee.FirstOrDefault(e => e.fkUser == userId);
            return employee?.idCatEmployee ?? 0;
        }
    }
}