namespace WebApi.Controllers;

using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class HealthCheckController : ControllerBase
{
    [HttpGet]
    public IActionResult Check()
    {
        // check database connection, external services, etc.
        // if everything is fine, return HTTP 200 OK
        return Ok(new { status = "::: Healthy :::" });
    }
}