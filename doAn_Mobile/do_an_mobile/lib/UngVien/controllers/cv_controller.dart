import 'package:shared_preferences/shared_preferences.dart';
import '../models/ho_so_cv_model.dart';
import '../services/cv_service.dart';

class CvController {
  final CvService _cvService = CvService();

  Future<int> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      throw Exception('Không tìm thấy tài khoản đăng nhập');
    }
    return userId;
  }

  Future<void> createCv(Map<String, dynamic> body) async {
    final userId = await getCurrentUserId();
    await _cvService.createCvByTaiKhoan(userId: userId, body: body);
  }

  Future<HoSoCvModel> getLatestCv() async {
    final userId = await getCurrentUserId();
    return _cvService.getLatestCvByTaiKhoan(userId);
  }

  Future<void> updateSearchStatus({required String idCv, required bool value}) {
    if (idCv.isEmpty) return Future.value();
    return _cvService.updateSearchStatus(idCv: idCv, value: value);
  }
}
