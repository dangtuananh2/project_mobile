import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/ung_vien_profile_model.dart';
import '../services/ung_vien_profile_service.dart';
import 'cv_controller.dart';

class UngVienProfileController {
  final UngVienProfileService _service = UngVienProfileService();
  final CvController _cvController = CvController();

  // ================= PROFILE METHODS CŨ =================

  Future<UngVienProfileModel> loadLocalProfile() => _service.loadLocalProfile();

  Future<UngVienProfileModel?> fetchRemoteAccount(UngVienProfileModel current) {
    return _service.fetchRemoteAccount(current);
  }

  Future<void> saveAvatarPath(String path) => _service.saveAvatarPath(path);

  Future<void> logout() => _service.logout();

  Future<void> updateProfile({
    required int userId,
    required String hoTen,
    required String soDienThoai,
    required String gioiTinh,
    required String ngaySinh,
    required String diaChi,
    required String anhDaiDien,
  }) {
    return _service.updateProfile(
      userId: userId,
      hoTen: hoTen,
      soDienThoai: soDienThoai,
      gioiTinh: gioiTinh,
      ngaySinh: ngaySinh,
      diaChi: diaChi,
      anhDaiDien: anhDaiDien,
    );
  }

  // ================= CONTROLLERS CHO TAOMAU.DART =================

  final TextEditingController tenCvController = TextEditingController();
  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController viTriUngTuyenController = TextEditingController();
  final TextEditingController soDienThoaiController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();

  final TextEditingController nganhHocController = TextEditingController();
  final TextEditingController thoiGianHocController = TextEditingController();
  final TextEditingController tenTruongController = TextEditingController();
  final TextEditingController moTaHocVanController = TextEditingController();

  final TextEditingController mucTieuController = TextEditingController();

  final TextEditingController kinhNghiemViTriController =
      TextEditingController();
  final TextEditingController kinhNghiemTuController = TextEditingController();
  final TextEditingController kinhNghiemDenController = TextEditingController();
  final TextEditingController kinhNghiemCongTyController =
      TextEditingController();
  final TextEditingController kinhNghiemMoTaController =
      TextEditingController();

  final TextEditingController danhHieuThoiGianController =
      TextEditingController();
  final TextEditingController danhHieuTenController = TextEditingController();

  final TextEditingController chungChiThoiGianController =
      TextEditingController();
  final TextEditingController chungChiTenController = TextEditingController();

  final TextEditingController hoatDongViTriController = TextEditingController();
  final TextEditingController hoatDongTuController = TextEditingController();
  final TextEditingController hoatDongDenController = TextEditingController();
  final TextEditingController hoatDongToChucController =
      TextEditingController();
  final TextEditingController hoatDongMoTaController = TextEditingController();

  final TextEditingController kyNangController = TextEditingController();
  final TextEditingController soThichController = TextEditingController();
  final TextEditingController nguoiGioiThieuController =
      TextEditingController();

  // ================= NGÀY SINH =================

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  Future<void> pickNgaySinh(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
      helpText: 'Chọn ngày sinh',
      cancelText: 'Hủy',
      confirmText: 'Chọn',
    );

    if (pickedDate != null) {
      ngaySinhController.text = formatDate(pickedDate);
    }
  }

  // ================= LƯU CV TỪ TAOMAU.DART =================

  Future<void> saveTaoMauCvToDatabase() async {
    final hocVan = {
      "nganhHoc": nganhHocController.text.trim(),
      "thoiGian": thoiGianHocController.text.trim(),
      "tenTruong": tenTruongController.text.trim(),
      "moTa": moTaHocVanController.text.trim(),
    };

    final kinhNghiem = {
      "viTri": kinhNghiemViTriController.text.trim(),
      "tu": kinhNghiemTuController.text.trim(),
      "den": kinhNghiemDenController.text.trim(),
      "tenCongTy": kinhNghiemCongTyController.text.trim(),
      "moTa": kinhNghiemMoTaController.text.trim(),
    };

    final danhHieu = {
      "thoiGian": danhHieuThoiGianController.text.trim(),
      "ten": danhHieuTenController.text.trim(),
    };

    final chungChi = {
      "thoiGian": chungChiThoiGianController.text.trim(),
      "ten": chungChiTenController.text.trim(),
    };

    final hoatDong = {
      "viTri": hoatDongViTriController.text.trim(),
      "tu": hoatDongTuController.text.trim(),
      "den": hoatDongDenController.text.trim(),
      "toChuc": hoatDongToChucController.text.trim(),
      "moTa": hoatDongMoTaController.text.trim(),
    };

    final body = {
      "tieuDeCv": tenCvController.text.trim().isEmpty
          ? "CV_${hoTenController.text.trim()}"
          : tenCvController.text.trim(),
      "anhCv": "",
      "hoTen": hoTenController.text.trim(),
      "viTriUngTuyen": viTriUngTuyenController.text.trim(),
      "soDienThoai": soDienThoaiController.text.trim(),
      "ngaySinh": ngaySinhController.text.trim(),
      "email": emailController.text.trim(),
      "profileFacebook": facebookController.text.trim(),
      "diaChi": diaChiController.text.trim(),
      "nguoiGioiThieu": nguoiGioiThieuController.text.trim(),
      "mucTieu": mucTieuController.text.trim(),
      "hocVan": jsonEncode(hocVan),
      "moTaHocVan": moTaHocVanController.text.trim(),
      "kinhNghiem": jsonEncode(kinhNghiem),
      "kyNang": kyNangController.text.trim(),
      "soThich": soThichController.text.trim(),
      "chungChi": jsonEncode(chungChi),
      "danhHieu": jsonEncode(danhHieu),
      "hoatDong": jsonEncode(hoatDong),
      "nganhNghe": viTriUngTuyenController.text.trim(),
      "trangThaiTimViec": true,
    };

    await _cvController.createCv(body);
  }

  // ================= DISPOSE CONTROLLERS =================

  void disposeTaoMauControllers() {
    tenCvController.dispose();
    hoTenController.dispose();
    viTriUngTuyenController.dispose();
    soDienThoaiController.dispose();
    ngaySinhController.dispose();
    emailController.dispose();
    facebookController.dispose();
    diaChiController.dispose();

    nganhHocController.dispose();
    thoiGianHocController.dispose();
    tenTruongController.dispose();
    moTaHocVanController.dispose();

    mucTieuController.dispose();

    kinhNghiemViTriController.dispose();
    kinhNghiemTuController.dispose();
    kinhNghiemDenController.dispose();
    kinhNghiemCongTyController.dispose();
    kinhNghiemMoTaController.dispose();

    danhHieuThoiGianController.dispose();
    danhHieuTenController.dispose();

    chungChiThoiGianController.dispose();
    chungChiTenController.dispose();

    hoatDongViTriController.dispose();
    hoatDongTuController.dispose();
    hoatDongDenController.dispose();
    hoatDongToChucController.dispose();
    hoatDongMoTaController.dispose();

    kyNangController.dispose();
    soThichController.dispose();
    nguoiGioiThieuController.dispose();
  }
}