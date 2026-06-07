import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ho_so_cv_model.dart';
import '../utils/api_constants.dart';

class CvService {
  Future<void> createCvByTaiKhoan({required int userId, required Map<String, dynamic> body}) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.hoSoCv}/create-by-taikhoan/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  Future<HoSoCvModel> getLatestCvByTaiKhoan(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.hoSoCv}/latest-by-taikhoan/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return HoSoCvModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> updateSearchStatus({required String idCv, required bool value}) async {
    await http.put(
      Uri.parse('${ApiConstants.hoSoCv}/update-status/$idCv'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'trangThaiTimViec': value}),
    );
  }
}
