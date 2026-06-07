CREATE DATABASE mobile_app;
GO

USE mobile_app;
GO

CREATE TABLE TaiKhoan (
    id_taikhoan INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(100) UNIQUE NOT NULL,
    mat_khau NVARCHAR(255) NOT NULL,
    so_dien_thoai NVARCHAR(15),
    vai_tro NVARCHAR(20) NOT NULL DEFAULT 'ung_vien',
    trang_thai BIT DEFAULT 1,
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE UngVien (
    id_ungvien INT PRIMARY KEY IDENTITY(1,1),
    id_taikhoan INT NOT NULL,

    -- Thông tin cá nhân
    ho_ten NVARCHAR(100),
    anh_dai_dien NVARCHAR(MAX),
    ngay_sinh DATE,
    gioi_tinh NVARCHAR(10),
    dia_chi NVARCHAR(255),

    -- Thông tin trên CV
    vi_tri_ung_tuyen NVARCHAR(150),
    profile_facebook NVARCHAR(255),
    nguoi_gioi_thieu NVARCHAR(MAX),

    FOREIGN KEY (id_taikhoan) 
    REFERENCES TaiKhoan(id_taikhoan)
);
GO

CREATE TABLE NhaTuyenDung (
    id_ntd INT PRIMARY KEY IDENTITY(1,1),
    id_taikhoan INT NOT NULL,
    ten_cong_ty NVARCHAR(150) NOT NULL,
    logo NVARCHAR(MAX),
    dia_chi NVARCHAR(255),
    mo_ta NVARCHAR(MAX),
    linh_vuc NVARCHAR(100),
    website NVARCHAR(255),

    FOREIGN KEY (id_taikhoan)
    REFERENCES TaiKhoan(id_taikhoan)
);
GO

CREATE TABLE HoSoCV (
    id_cv INT PRIMARY KEY IDENTITY(1,1),
    id_ungvien INT NOT NULL,

    -- Thông tin CV
    tieu_de_cv NVARCHAR(150),
    anh_cv NVARCHAR(MAX),
    muc_tieu NVARCHAR(MAX),

    -- Học vấn
    hoc_van NVARCHAR(MAX),
    mo_ta_hoc_van NVARCHAR(MAX),

    -- Nội dung chính
    kinh_nghiem NVARCHAR(MAX),
    ky_nang NVARCHAR(MAX),
    so_thich NVARCHAR(MAX),
    chung_chi NVARCHAR(MAX),
    danh_hieu NVARCHAR(MAX),
    hoat_dong NVARCHAR(MAX),
    nganh_nghe NVARCHAR(MAX),

    -- Trạng thái CV
    trang_thai_tim_viec BIT DEFAULT 1,
    ngay_tao DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (id_ungvien)
    REFERENCES UngVien(id_ungvien)
);
GO
CREATE TABLE TinTuyenDung (
    id_tin INT PRIMARY KEY IDENTITY(1,1),
    id_ntd INT NOT NULL,
    tieu_de NVARCHAR(200) NOT NULL,
    mo_ta_cong_viec NVARCHAR(MAX),
    yeu_cau NVARCHAR(MAX),
    quyen_loi NVARCHAR(MAX),
    dia_diem NVARCHAR(255),
    muc_luong NVARCHAR(100),
    kinh_nghiem NVARCHAR(100),
    hinh_thuc NVARCHAR(50),
    nganh_nghe NVARCHAR(100),
    han_nop DATE,
    trang_thai NVARCHAR(50) DEFAULT N'Đang tuyển',
    ngay_dang DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (id_ntd)
    REFERENCES NhaTuyenDung(id_ntd)
);
GO

CREATE TABLE UngTuyen (
    id_ungtuyen INT PRIMARY KEY IDENTITY(1,1),
    id_tin INT NOT NULL,
    id_cv INT NOT NULL,
    ngay_ung_tuyen DATETIME DEFAULT GETDATE(),
    trang_thai NVARCHAR(50) DEFAULT N'Chờ duyệt',

    FOREIGN KEY (id_tin)
    REFERENCES TinTuyenDung(id_tin),

    FOREIGN KEY (id_cv)
    REFERENCES HoSoCV(id_cv)
);
GO

CREATE TABLE LuuTin (
    id_luu INT PRIMARY KEY IDENTITY(1,1),
    id_ungvien INT NOT NULL,
    id_tin INT NOT NULL,
    ngay_luu DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (id_ungvien)
    REFERENCES UngVien(id_ungvien),

    FOREIGN KEY (id_tin)
    REFERENCES TinTuyenDung(id_tin)
);
GO

-- Tránh ứng viên lưu trùng một tin nhiều lần
ALTER TABLE LuuTin
ADD CONSTRAINT UQ_LuuTin_UngVien_Tin 
UNIQUE (id_ungvien, id_tin);
GO

-- Tránh một CV ứng tuyển trùng một tin nhiều lần
ALTER TABLE UngTuyen
ADD CONSTRAINT UQ_UngTuyen_Tin_CV 
UNIQUE (id_tin, id_cv);
GO

INSERT INTO TaiKhoan (
    email,
    mat_khau,
    so_dien_thoai,
    vai_tro,
    trang_thai
)
VALUES (
    'admin@gmail.com',
    '123456',
    '0123456789',
    'admin',
    1
);
GO