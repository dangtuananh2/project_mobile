using System;
using System.Collections.Generic;

namespace TaoAPI.Entities;

public partial class TaiKhoan
{
    public int IdTaikhoan { get; set; }

    public string Email { get; set; } = null!;

    public string MatKhau { get; set; } = null!;

    public string? SoDienThoai { get; set; }

    public string? VaiTro { get; set; }
    public bool? TrangThai { get; set; }

    public DateTime? NgayTao { get; set; }

    public virtual ICollection<UngVien> UngViens { get; set; } = new List<UngVien>();
}
