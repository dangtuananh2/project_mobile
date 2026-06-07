using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TaoAPI.Entities;
using System.Globalization;

namespace TaoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoSoCVController : ControllerBase
    {
        private readonly MobileAppContext _context;

        public HoSoCVController(MobileAppContext context)
        {
            _context = context;
        }

        [HttpPost("create-by-taikhoan/{idTaiKhoan}")]
        public async Task<ActionResult> CreateByTaiKhoan(
            int idTaiKhoan,
            [FromBody] CreateHoSoCvRequest request)
        {
            try
            {
                var ungVien = await _context.UngViens
                    .FirstOrDefaultAsync(x => x.IdTaikhoan == idTaiKhoan);

                if (ungVien == null)
                {
                    return NotFound(new
                    {
                        message = "Không tìm thấy ứng viên theo tài khoản này"
                    });
                }

                var taiKhoan = await _context.TaiKhoans
                    .FirstOrDefaultAsync(x => x.IdTaikhoan == idTaiKhoan);

                if (taiKhoan == null)
                {
                    return NotFound(new
                    {
                        message = "Không tìm thấy tài khoản"
                    });
                }

                // Cập nhật thông tin ứng viên
                if (!string.IsNullOrWhiteSpace(request.HoTen))
                {
                    ungVien.HoTen = request.HoTen;
                }

                if (!string.IsNullOrWhiteSpace(request.DiaChi))
                {
                    ungVien.DiaChi = request.DiaChi;
                }

                if (!string.IsNullOrWhiteSpace(request.ViTriUngTuyen))
                {
                    ungVien.ViTriUngTuyen = request.ViTriUngTuyen;
                }

                if (!string.IsNullOrWhiteSpace(request.ProfileFacebook))
                {
                    ungVien.ProfileFacebook = request.ProfileFacebook;
                }

                if (!string.IsNullOrWhiteSpace(request.NguoiGioiThieu))
                {
                    ungVien.NguoiGioiThieu = request.NguoiGioiThieu;
                }

                if (!string.IsNullOrWhiteSpace(request.NgaySinh))
                {
                    var formats = new[]
                    {
                        "dd/MM/yyyy",
                        "d/M/yyyy",
                        "yyyy-MM-dd",
                        "MM/dd/yyyy"
                    };

                    if (DateOnly.TryParseExact(
                        request.NgaySinh,
                        formats,
                        CultureInfo.InvariantCulture,
                        DateTimeStyles.None,
                        out var ngaySinh))
                    {
                        ungVien.NgaySinh = ngaySinh;
                    }
                    else if (DateTime.TryParse(request.NgaySinh, out var dateTime))
                    {
                        ungVien.NgaySinh = DateOnly.FromDateTime(dateTime);
                    }
                }

                // Cập nhật thông tin tài khoản
                if (!string.IsNullOrWhiteSpace(request.Email) &&
                    request.Email != taiKhoan.Email)
                {
                    var emailDaTonTai = await _context.TaiKhoans
                        .AnyAsync(x =>
                            x.Email == request.Email &&
                            x.IdTaikhoan != idTaiKhoan);

                    if (emailDaTonTai)
                    {
                        return BadRequest(new
                        {
                            message = "Email này đã được tài khoản khác sử dụng"
                        });
                    }

                    taiKhoan.Email = request.Email;
                }

                if (!string.IsNullOrWhiteSpace(request.SoDienThoai))
                {
                    taiKhoan.SoDienThoai = request.SoDienThoai;
                }

                // Tạo CV mới
                var cv = new HoSoCv
                {
                    IdUngvien = ungVien.IdUngvien,
                    TieuDeCv = request.TieuDeCv,
                    AnhCv = request.AnhCv,
                    MucTieu = request.MucTieu,
                    HocVan = request.HocVan,
                    MoTaHocVan = request.MoTaHocVan,
                    KinhNghiem = request.KinhNghiem,
                    KyNang = request.KyNang,
                    SoThich = request.SoThich,
                    ChungChi = request.ChungChi,
                    DanhHieu = request.DanhHieu,
                    HoatDong = request.HoatDong,
                    NganhNghe = request.NganhNghe,
                    TrangThaiTimViec = request.TrangThaiTimViec ?? true,
                    NgayTao = DateTime.Now
                };

                _context.HoSoCvs.Add(cv);
                await _context.SaveChangesAsync();

                return Ok(new
                {
                    message = "Lưu CV thành công",
                    idCv = cv.IdCv
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi khi lưu CV",
                    error = ex.Message,
                    inner = ex.InnerException?.Message
                });
            }
        }

        [HttpGet("latest-by-taikhoan/{idTaiKhoan}")]
        public async Task<ActionResult> GetLatestByTaiKhoan(int idTaiKhoan)
        {
            try
            {
                var ungVien = await _context.UngViens
                    .FirstOrDefaultAsync(x => x.IdTaikhoan == idTaiKhoan);

                if (ungVien == null)
                {
                    return NotFound(new
                    {
                        message = "Không tìm thấy ứng viên"
                    });
                }

                var taiKhoan = await _context.TaiKhoans
                    .FirstOrDefaultAsync(x => x.IdTaikhoan == idTaiKhoan);

                if (taiKhoan == null)
                {
                    return NotFound(new
                    {
                        message = "Không tìm thấy tài khoản"
                    });
                }

                var cv = await _context.HoSoCvs
                    .Where(x => x.IdUngvien == ungVien.IdUngvien)
                    .OrderByDescending(x => x.IdCv)
                    .FirstOrDefaultAsync();

                if (cv == null)
                {
                    return NotFound(new
                    {
                        message = "Chưa có CV nào"
                    });
                }

                // Không return Ok(cv), tránh vòng lặp JSON
                return Ok(new
                {
                    idCv = cv.IdCv,
                    idUngvien = cv.IdUngvien,

                    tieuDeCv = cv.TieuDeCv,
                    anhCv = cv.AnhCv,

                    hoTen = ungVien.HoTen,
                    soDienThoai = taiKhoan.SoDienThoai,
                    email = taiKhoan.Email,
                    ngaySinh = ungVien.NgaySinh.HasValue
                        ? ungVien.NgaySinh.Value.ToString("dd/MM/yyyy")
                        : null,
                    gioiTinh = ungVien.GioiTinh,
                    diaChi = ungVien.DiaChi,
                    anhDaiDien = ungVien.AnhDaiDien,

                    viTriUngTuyen = ungVien.ViTriUngTuyen,
                    profileFacebook = ungVien.ProfileFacebook,
                    nguoiGioiThieu = ungVien.NguoiGioiThieu,

                    mucTieu = cv.MucTieu,
                    hocVan = cv.HocVan,
                    moTaHocVan = cv.MoTaHocVan,
                    kinhNghiem = cv.KinhNghiem,
                    kyNang = cv.KyNang,
                    soThich = cv.SoThich,
                    chungChi = cv.ChungChi,
                    danhHieu = cv.DanhHieu,
                    hoatDong = cv.HoatDong,
                    nganhNghe = cv.NganhNghe,
                    trangThaiTimViec = cv.TrangThaiTimViec,
                    ngayTao = cv.NgayTao
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi khi lấy CV",
                    error = ex.Message,
                    inner = ex.InnerException?.Message
                });
            }
        }

        [HttpPut("update-status/{idCv}")]
        public async Task<ActionResult> UpdateStatus(
            int idCv,
            [FromBody] UpdateCvStatusRequest request)
        {
            try
            {
                var cv = await _context.HoSoCvs.FindAsync(idCv);

                if (cv == null)
                {
                    return NotFound(new
                    {
                        message = "Không tìm thấy CV"
                    });
                }

                cv.TrangThaiTimViec = request.TrangThaiTimViec;
                await _context.SaveChangesAsync();

                return Ok(new
                {
                    message = "Cập nhật trạng thái CV thành công"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi khi cập nhật trạng thái CV",
                    error = ex.Message,
                    inner = ex.InnerException?.Message
                });
            }
        }
    }

    public class CreateHoSoCvRequest
    {
        public string? TieuDeCv { get; set; }

        public string? AnhCv { get; set; }

        public string? HoTen { get; set; }

        public string? ViTriUngTuyen { get; set; }

        public string? SoDienThoai { get; set; }

        public string? NgaySinh { get; set; }

        public string? Email { get; set; }

        public string? ProfileFacebook { get; set; }

        public string? DiaChi { get; set; }

        public string? NguoiGioiThieu { get; set; }

        public string? MucTieu { get; set; }

        public string? HocVan { get; set; }

        public string? MoTaHocVan { get; set; }

        public string? KinhNghiem { get; set; }

        public string? KyNang { get; set; }

        public string? SoThich { get; set; }

        public string? ChungChi { get; set; }

        public string? DanhHieu { get; set; }

        public string? HoatDong { get; set; }

        public string? NganhNghe { get; set; }

        public bool? TrangThaiTimViec { get; set; }
    }

    public class UpdateCvStatusRequest
    {
        public bool TrangThaiTimViec { get; set; }
    }
}