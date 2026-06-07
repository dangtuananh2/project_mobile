import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/controllers/ung_vien_profile_controller.dart';
import 'package:do_an_mobile/UngVien/views/luucv.dart';

class TaoMau extends StatefulWidget {
  final String type;

  const TaoMau({super.key, this.type = "simple"});

  @override
  State<TaoMau> createState() => _TaoMauState();
}

class _TaoMauState extends State<TaoMau> {
  final UngVienProfileController _profileController =
      UngVienProfileController();

  bool isSaving = false;

  // 🔥 STATE (chỉ dùng cho SIMPLE)
  List<int> experiences = [1];
  List<int> activities = [1];
  List<int> certificates = [1];
  List<int> skills = [1];
  List<int> hobbies = [1];

  Future<void> saveCvToDatabase() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      await _profileController.saveTaoMauCvToDatabase();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LuuCvPage(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi lưu CV: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _profileController.disposeTaoMauControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _profileController.tenCvController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: "Tên CV",
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),

      body: widget.type == "pro" ? buildProfessionalCV() : buildSimpleCV(),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: isSaving ? null : saveCvToDatabase,
            child: Text(
              isSaving ? "Đang lưu..." : "Lưu CV",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // ================= SIMPLE =================
  Widget buildSimpleCV() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // LEFT (GIỮ NGUYÊN)
              Container(
                width: 150,
                height: double.infinity,
                color: const Color(0xFF5D4037),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                    const SizedBox(height: 20),

                    TextField(
                      controller: _profileController.hoTenController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Họ tên",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),

                    TextField(
                      controller: _profileController.viTriUngTuyenController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Vị trí ứng tuyển",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Divider(color: Colors.white),

                    infoInput(
                      Icons.phone,
                      "Số điện thoại",
                      controller: _profileController.soDienThoaiController,
                    ),
                    infoInput(
                      Icons.calendar_today,
                      "Ngày sinh",
                      controller: _profileController.ngaySinhController,
                      isDate: true,
                    ),
                    infoInput(
                      Icons.email,
                      "Email",
                      controller: _profileController.emailController,
                    ),
                    infoInput(
                      Icons.person,
                      "Profile Facebook",
                      controller: _profileController.facebookController,
                    ),
                    infoInput(
                      Icons.location_on,
                      "Địa chỉ",
                      controller: _profileController.diaChiController,
                    ),

                    const SizedBox(height: 10),

                    // ================= HỌC VẤN =================
                    sectionTitle("Học vấn"),

                    TextField(
                      controller: _profileController.nganhHocController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Ngành học / Môn học",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),

                    TextField(
                      controller: _profileController.thoiGianHocController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Bắt đầu - Kết thúc",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),

                    TextField(
                      controller: _profileController.tenTruongController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Tên trường học",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),

                    TextField(
                      controller: _profileController.moTaHocVanController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: "Mô tả quá trình học",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= KỸ NĂNG =================
                    sectionTitle("Kỹ năng"),

                    ...skills.map(
                      (e) => TextField(
                        controller: _profileController.kyNangController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: "Tên kỹ năng",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          skills.add(1);
                        });
                      },
                      child: const Text(
                        "+ Thêm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= SỞ THÍCH =================
                    sectionTitle("Sở thích"),

                    ...hobbies.map(
                      (e) => TextField(
                        controller: _profileController.soThichController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: "Tên sở thích",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          hobbies.add(1);
                        });
                      },
                      child: const Text(
                        "+ Thêm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= NGƯỜI GIỚI THIỆU =================
                    sectionTitle("Người giới thiệu"),

                    TextField(
                      controller: _profileController.nguoiGioiThieuController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: "Tên, chức vụ, liên hệ",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔥 RIGHT (ĐÃ SỬA)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCareerGoal(),
                      buildExperienceSection(),
                      buildAwardSection(),
                      buildCertificateSection(),
                      buildActivitySection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= PRO (GIỮ NGUYÊN) =================
  Widget buildProfessionalCV() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 160,
              color: const Color.fromARGB(255, 218, 129, 206),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                  const SizedBox(height: 10),

                  TextField(
                    controller: _profileController.hoTenController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: "Họ tên",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),

                  TextField(
                    controller: _profileController.viTriUngTuyenController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: "Vị trí",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),

                  const Divider(),

                  infoInput(
                    Icons.cake,
                    "Ngày sinh",
                    controller: _profileController.ngaySinhController,
                    isDate: true,
                  ),
                  infoInput(
                    Icons.phone,
                    "SĐT",
                    controller: _profileController.soDienThoaiController,
                  ),
                  infoInput(
                    Icons.email,
                    "Email",
                    controller: _profileController.emailController,
                  ),
                  infoInput(
                    Icons.location_on,
                    "Địa chỉ",
                    controller: _profileController.diaChiController,
                  ),

                  const SizedBox(height: 10),

                  sectionTitle("Học vấn"),
                  TextField(
                    controller: _profileController.nganhHocController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: "Nhập học vấn",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),

                  sectionTitle("Kỹ năng"),
                  TextField(
                    controller: _profileController.kyNangController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Nhập kỹ năng",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rightSection("Mục tiêu nghề nghiệp"),
                    rightSection("Kinh nghiệm làm việc"),
                    rightSection("Danh hiệu và giải thưởng"),
                    rightSection("Chứng chỉ"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMPONENT =================

  Widget brownTitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF5D4037),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCareerGoal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        brownTitle("Mục tiêu nghề nghiệp"),
        TextField(
          controller: _profileController.mucTieuController,
          maxLines: 3,
        ),
        const Divider(),
      ],
    );
  }

  Widget buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        brownTitle("Kinh nghiệm làm việc"),
        ...experiences.map((e) => experienceItem()),
        TextButton(
          onPressed: () {
            setState(() {
              experiences.add(1);
            });
          },
          child: const Text("+ Thêm"),
        ),
        const Divider(),
      ],
    );
  }

  Widget experienceItem() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _profileController.kinhNghiemViTriController,
                decoration: const InputDecoration(hintText: "Vị trí"),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 70,
              child: TextField(
                controller: _profileController.kinhNghiemTuController,
                decoration: const InputDecoration(hintText: "Từ"),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 70,
              child: TextField(
                controller: _profileController.kinhNghiemDenController,
                decoration: const InputDecoration(hintText: "Đến"),
              ),
            ),
          ],
        ),
        TextField(
          controller: _profileController.kinhNghiemCongTyController,
          decoration: const InputDecoration(hintText: "Tên công ty"),
        ),
        TextField(
          controller: _profileController.kinhNghiemMoTaController,
          maxLines: 2,
          decoration: const InputDecoration(hintText: "Mô tả"),
        ),
      ],
    );
  }

  Widget buildAwardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        brownTitle("Danh hiệu"),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _profileController.danhHieuThoiGianController,
                decoration: const InputDecoration(hintText: "Thời gian"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _profileController.danhHieuTenController,
                decoration: const InputDecoration(hintText: "Tên"),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            setState(() {
              certificates.add(1);
            });
          },
          child: const Text("+ Thêm"),
        ),
        const Divider(),
      ],
    );
  }

  Widget buildCertificateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        brownTitle("Chứng chỉ"),
        ...certificates.map(
          (e) => Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _profileController.chungChiThoiGianController,
                  decoration: const InputDecoration(hintText: "Thời gian"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _profileController.chungChiTenController,
                  decoration: const InputDecoration(hintText: "Tên"),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              certificates.add(1);
            });
          },
          child: const Text("+ Thêm"),
        ),
        const Divider(),
      ],
    );
  }

  Widget buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        brownTitle("Hoạt động"),
        ...activities.map(
          (e) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _profileController.hoatDongViTriController,
                      decoration: const InputDecoration(hintText: "Vị trí"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _profileController.hoatDongTuController,
                      decoration: const InputDecoration(hintText: "Từ"),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _profileController.hoatDongDenController,
                      decoration: const InputDecoration(hintText: "Đến"),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _profileController.hoatDongToChucController,
                decoration: const InputDecoration(hintText: "Tổ chức"),
              ),
              TextField(
                controller: _profileController.hoatDongMoTaController,
                decoration: const InputDecoration(hintText: "Mô tả"),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              activities.add(1);
            });
          },
          child: const Text("+ Thêm"),
        ),
        const Divider(),
      ],
    );
  }

  Widget infoInput(
    IconData icon,
    String hint, {
    TextEditingController? controller,
    bool isDate = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 5),
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: isDate,
            onTap: isDate
                ? () => _profileController.pickNgaySinh(context)
                : null,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget rightSection(String title) {
    TextEditingController? controller;

    if (title == "Mục tiêu nghề nghiệp") {
      controller = _profileController.mucTieuController;
    } else if (title == "Kinh nghiệm làm việc") {
      controller = _profileController.kinhNghiemMoTaController;
    } else if (title == "Danh hiệu và giải thưởng") {
      controller = _profileController.danhHieuTenController;
    } else if (title == "Chứng chỉ") {
      controller = _profileController.chungChiTenController;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const Divider(),
          TextField(controller: controller),
        ],
      ),
    );
  }
}