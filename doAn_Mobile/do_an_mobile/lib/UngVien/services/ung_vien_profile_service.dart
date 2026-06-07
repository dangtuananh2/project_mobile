import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ung_vien_profile_model.dart';
import '../utils/api_constants.dart';

class UngVienProfileService {
  Future<UngVienProfileModel> loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    final cachedName = prefs.getString('userName') ?? 'Người dùng';
    final cachedEmail = prefs.getString('userEmail') ?? '';
    final cachedAvatar = prefs.getString('avatarPath') ?? '';

    return UngVienProfileModel(
      userId: userId,
      userName: cachedName,
      userEmail: cachedEmail,
      userCode: userId == 0 ? '...' : userId.toString(),
      avatarPath: cachedAvatar,
    );
  }

  Future<UngVienProfileModel?> fetchRemoteAccount(UngVienProfileModel current) async {
    if (current.userId == 0) return null;

    final response = await http.get(
      Uri.parse('${ApiConstants.taiKhoan}/${current.userId}'),
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    final apiName = data['hoTen'] ?? data['HoTen'] ?? data['ho_ten'] ?? current.userName;
    final apiEmail = data['email'] ?? data['Email'] ?? current.userEmail;
    final apiCode = (data['idTaikhoan'] ?? data['IdTaikhoan'] ?? data['id_taikhoan'] ?? current.userId).toString();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', apiName);
    await prefs.setString('userEmail', apiEmail);

    return current.copyWith(
      userName: apiName,
      userEmail: apiEmail,
      userCode: apiCode,
    );
  }

  Future<void> saveAvatarPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarPath', path);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> updateProfile({
    required int userId,
    required String hoTen,
    required String soDienThoai,
    required String gioiTinh,
    required String ngaySinh,
    required String diaChi,
    required String anhDaiDien,
  }) async {
    final body = {
      'idTaikhoan': userId,
      'hoTen': hoTen,
      'soDienThoai': soDienThoai,
      'gioiTinh': gioiTinh,
      'ngaySinh': ngaySinh,
      'diaChi': diaChi,
      'anhDaiDien': anhDaiDien,
    };

    final response = await http.put(
      Uri.parse('${ApiConstants.ungVien}/update-by-taikhoan/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Cập nhật thất bại');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', hoTen);
    await prefs.setString('avatarPath', anhDaiDien);
  }
}
