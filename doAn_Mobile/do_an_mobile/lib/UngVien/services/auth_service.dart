import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_user_model.dart';
import '../models/register_request_model.dart';
import '../utils/api_constants.dart';

class AuthService {
  Future<AuthUserModel> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'matKhau': password}),
    );

    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final userData = jsonDecode(response.body) as Map<String, dynamic>;
    final user = AuthUserModel.fromJson(userData, email);
    await saveLoginSession(user);
    return user;
  }

  Future<void> register(RegisterRequestModel request) async {
    final response = await http.post(
      Uri.parse(ApiConstants.taiKhoan),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  Future<AuthUserModel?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);
    final account = await googleSignIn.signIn();
    if (account == null) return null;

    final user = AuthUserModel(
      userId: 0,
      email: account.email,
      userName: account.displayName ?? 'Người dùng',
      vaiTro: 'ung_vien',
    );

    await saveLoginSession(user);
    return user;
  }

  Future<void> saveLoginSession(AuthUserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.userId);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userName', user.userName);
    await prefs.setString('vaiTro', user.vaiTro);
  }
}
