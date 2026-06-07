class RegisterRequestModel {
  final String email;
  final String matKhau;
  final String vaiTro;
  final String? hoTen;
  final String? tenCongTy;

  RegisterRequestModel({
    required this.email,
    required this.matKhau,
    required this.vaiTro,
    this.hoTen,
    this.tenCongTy,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'matKhau': matKhau,
      'vaiTro': vaiTro,
      'hoTen': hoTen,
      'tenCongTy': tenCongTy,
    };
  }
}
