using API_ClayTrack.DataBase;
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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class EmployeeController : ControllerBase
    {
        private readonly ClayTrackDbContext dbContext;

        public EmployeeController(ClayTrackDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        public async Task<ActionResult<List<CatEmployee>>> GetAllEmployee()
        {
            return await dbContext.CatEmployee
                .Include(e => e.Person)
                .Include(e => e.User)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult> AddEmployee([FromBody] CatEmployee employee)
        {

            dbContext.Add(employee);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        [Route("{id:int}")]
        public async Task<ActionResult> UpdateEmployee(CatEmployee employee, int id)
        {
            if (employee.idCatEmployee != id)
            {
                return BadRequest("Employee id different from URL id");
            }

            var exist = await dbContext.CatEmployee.AnyAsync(x => x.idCatEmployee == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Update(employee);
            await dbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<ActionResult> DeleteEmployee(int id)
        {
            var exist = await dbContext.CatEmployee.AnyAsync(x => x.idCatEmployee == id);
            if (!exist)
            {
                return NotFound();
            }

            dbContext.Remove(new CatEmployee() { idCatEmployee = id });
            await dbContext.SaveChangesAsync();
            return Ok();
        }
    }
}
