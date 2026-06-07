using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TaoAPI.Entities; // Hãy đảm bảo tên này đúng với namespace trong thư mục Entities của bạn

namespace TaoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaiKhoanController : ControllerBase
    {
        public class RegisterRequest
        {
            public string Email { get; set; }
            public string MatKhau { get; set; }
            public string HoTen { get; set; }
            public string? SoDienThoai { get; set; }
        }

        private readonly MobileAppContext _context;

        // Khai báo DbContext để làm việc với Database
        public TaiKhoanController(MobileAppContext context)
        {
            _context = context;
        }

        // 1. API Lấy danh sách tài khoản (GET: api/TaiKhoan)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TaiKhoan>>> GetTaiKhoans()
        {
            return await _context.TaiKhoans.ToListAsync();
        }

        // 2. API Đăng ký tài khoản mới (POST: api/TaiKhoan)
        [HttpPost]
        public async Task<ActionResult> PostTaiKhoan(RegisterRequest request)
        {
            // 1. Tạo đối tượng TaiKhoan từ dữ liệu request
            var taiKhoan = new TaiKhoan
            {
                Email = request.Email,
                MatKhau = request.MatKhau,
                SoDienThoai = request.SoDienThoai,
                VaiTro = "ung_vien",
                NgayTao = DateTime.Now
            };

            _context.TaiKhoans.Add(taiKhoan);
            await _context.SaveChangesAsync(); // Lưu để lấy id_taikhoan tự tăng

            // 2. Tạo đối tượng UngVien liên kết với TaiKhoan vừa tạo
            var ungVien = new UngVien
            {
                IdTaikhoan = taiKhoan.IdTaikhoan, // Khóa ngoại kết nối
                HoTen = request.HoTen             // Lưu Họ Tên vào bảng UngVien như ý bạn muốn
            };

            _context.UngViens.Add(ungVien);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Đăng ký thành công!", id = taiKhoan.IdTaikhoan });
        }

        // 3. API Đăng nhập (POST: api/TaiKhoan/login)
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] TaiKhoan loginInfo)
        {
            var user = await _context.TaiKhoans
                .FirstOrDefaultAsync(u => u.Email == loginInfo.Email && u.MatKhau == loginInfo.MatKhau);

            if (user == null)
            {
                return Unauthorized("Sai email hoặc mật khẩu");
            }

            return Ok(user);
        }
        // 4. API Lấy thông tin 1 tài khoản theo ID (GET: api/TaiKhoan/5)
        [HttpGet("{id}")]
        public async Task<ActionResult> GetTaiKhoan(int id)
        {
            // Tìm tài khoản và kèm theo thông tin bên bảng UngVien
            var data = await _context.TaiKhoans
                .Where(t => t.IdTaikhoan == id)
                .Select(t => new {
                    idTaikhoan = t.IdTaikhoan,
                    email = t.Email,
                    // Lấy HoTen từ bảng UngVien thông qua quan hệ khóa ngoại
                    hoTen = _context.UngViens.Where(u => u.IdTaikhoan == t.IdTaikhoan).Select(u => u.HoTen).FirstOrDefault()
                })
                .FirstOrDefaultAsync();

            if (data == null) return NotFound("Không tìm thấy tài khoản");

            return Ok(data);
        }
    }
}