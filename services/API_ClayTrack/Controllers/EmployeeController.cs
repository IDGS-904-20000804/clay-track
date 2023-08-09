using API_ClayTrack.DataBase;
using API_ClayTrack.DTOs;
using API_ClayTrack.Models;
using com.sun.security.ntlm;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_ClayTrack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Employee,Admin")]
    public class EmployeeController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;
        private readonly UserManager<IdentityUser> userManager;

        public EmployeeController(ClayTrackDbContext dbContext,
            UserManager<IdentityUser> userManager)
        {
            this.dbContext = dbContext;
            this.userManager = userManager;
        }

        [HttpGet]
        [Route("GetAll")]
        public async Task<ActionResult<List<CatEmployee>>> GetAllEmployee()
        {
            return await dbContext.CatEmployee
                .Include(e => e.Person)
                .Include(e => e.User)
                .Include(e => e.Role)
                .ToListAsync();
        }

        [HttpGet]
        [Route("GetOne{id:int}")]
        public async Task<ActionResult<CatEmployee>> GetEmployee(int id)
        {
            var employee = await dbContext.CatEmployee
                .Include(e => e.Person)
                .Include(e => e.User)
                .Include(e => e.Role)
                .FirstOrDefaultAsync(e => e.idCatEmployee == id);

            if (employee == null)
            {
                return NotFound();
            }

            return Ok(employee);
        }

        [HttpPost]
        [Route("AddEmployee")]
        public async Task<ActionResult> AddEmployee([FromBody] CatEmployee employee)
        {
            try
            {
                IdentityRole employeeRole = dbContext.Roles.FirstOrDefault(r => r.Name == "Employee");

                if (employeeRole == null)
                {
                    return BadRequest("Role does not exist");
                }
                employee.Role = employeeRole;

                var user = new IdentityUser
                {
                    UserName = employee.User.Email,
                    Email = employee.User.Email
                };

                var password = employee.User.PasswordHash;
                var identityResult = await userManager.CreateAsync(user, password);

                if (!identityResult.Succeeded)
                {
                    var errorMessage = string.Join(", ", identityResult.Errors.Select(e => e.Description));
                    return BadRequest(errorMessage);
                }

                employee.User = user;
                dbContext.Add(employee);
                await dbContext.SaveChangesAsync();
                await userManager.AddToRoleAsync(user, employee.Role.Name);

                return Ok("Employee was added successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpPut]
        [Route("Update{id:int}")]
        public async Task<ActionResult> UpdateEmployee(CatEmployee employee, int id)
        {
            if (employee.idCatEmployee != id)
            {
                return BadRequest("Employee id different from URL id");
            }

            var exist = await dbContext.CatEmployee
                .Include(e => e.Person)
                .Include(e => e.User)
                .Include(e => e.Role)
                .AnyAsync(x => x.idCatEmployee == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(employee);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        [Route("Delete{id:int}")]
        public async Task<ActionResult> DeleteEmployee(int id)
        {
            var employee = await dbContext.CatEmployee
                .Include(e => e.Person)
                .Include(e => e.User)
                .FirstOrDefaultAsync(c => c.idCatEmployee == id);

            if (employee == null)
            {
                return NotFound();
            }

            employee.Person.status = false;

            var user = await userManager.FindByIdAsync(employee.fkUser);
            if (user != null)
            {
                var result = await userManager.DeleteAsync(user);
                if (!result.Succeeded)
                {
                    var errorMessage = string.Join(", ", result.Errors.Select(e => e.Description));
                    return BadRequest(errorMessage);
                }
            }

            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
