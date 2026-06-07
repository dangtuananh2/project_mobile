class AuthUserModel {
  final int userId;
  final String email;
  final String userName;
  final String vaiTro;

  AuthUserModel({
    required this.userId,
    required this.email,
    required this.userName,
    required this.vaiTro,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json, String fallbackEmail) {
    return AuthUserModel(
      userId: json['idTaikhoan'] ?? json['IdTaikhoan'] ?? json['id_taikhoan'] ?? 0,
      email: json['email'] ?? json['Email'] ?? fallbackEmail,
      vaiTro: json['vaiTro'] ?? json['VaiTro'] ?? json['vai_tro'] ?? 'ung_vien',
      userName: json['hoTen'] ??
          json['HoTen'] ??
          json['ho_ten'] ??
          json['tenCongTy'] ??
          json['TenCongTy'] ??
          json['ten_cong_ty'] ??
          'Người dùng',
    );
  }
}
