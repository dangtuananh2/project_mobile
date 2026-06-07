import '../models/auth_user_model.dart';
import '../models/register_request_model.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<AuthUserModel> login({required String email, required String password}) {
    return _authService.login(email: email, password: password);
  }

  Future<void> register({
    required String email,
    required String password,
    required bool isUngVien,
    required String nameOrCompany,
  }) {
    final request = RegisterRequestModel(
      email: email,
      matKhau: password,
      vaiTro: isUngVien ? 'ung_vien' : 'nha_tuyen_dung',
      hoTen: isUngVien ? nameOrCompany : null,
      tenCongTy: isUngVien ? null : nameOrCompany,
    );
    return _authService.register(request);
  }

  Future<AuthUserModel?> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }
}
