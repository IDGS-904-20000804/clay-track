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
        [Route("UpdateEmployee/{id}")]
        public async Task<ActionResult> UpdateEmployee(int id, [FromBody] CatEmployee employee)
        {
            try
            {
                if (employee.idCatEmployee != id)
                {
                    return BadRequest("Employee id different from URL id");
                }

                var existingEmployee = await dbContext.CatEmployee
                    .Include(e => e.Person)
                    .Include(e => e.User)
                    .Include(e => e.Role)
                    .FirstOrDefaultAsync(e => e.idCatEmployee == id);

                if (existingEmployee == null)
                {
                    return NotFound("Employee not found");
                }

                var existingUser = await userManager.FindByIdAsync(existingEmployee.fkUser);

                if (existingUser == null)
                {
                    return NotFound("User not found");
                }

                var employeePassword = employee.User.PasswordHash;

                if (!string.IsNullOrEmpty(employeePassword))
                {
                    var newPasswordHash = userManager.PasswordHasher.HashPassword(existingUser, employeePassword);
                    existingUser.PasswordHash = newPasswordHash;
                }

                existingUser.UserName = employee.User.Email;
                existingUser.Email = employee.User.Email;

                existingEmployee.Person.name = employee.Person.name;
                existingEmployee.Person.lastName = employee.Person.lastName;
                existingEmployee.Person.middleName = employee.Person.middleName;
                existingEmployee.Person.phone = employee.Person.phone;

                var existingRole = await dbContext.Roles.FirstOrDefaultAsync(r => r.Id == existingEmployee.fkRol);
                if (existingRole != null)
                {
                    existingRole.Name = employee.Role.Name;
                }

                dbContext.Update(existingUser);
                dbContext.Update(existingEmployee);
                await dbContext.SaveChangesAsync();

                return Ok("Employee was updated successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
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

            employee.status = false;
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
