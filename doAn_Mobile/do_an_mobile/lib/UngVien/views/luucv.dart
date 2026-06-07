import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/controllers/cv_controller.dart';
import 'package:do_an_mobile/UngVien/models/ho_so_cv_model.dart';
import 'package:do_an_mobile/UngVien/utils/cv_pdf_helper.dart';

class LuuCvPage extends StatefulWidget {
  const LuuCvPage({super.key});

  @override
  State<LuuCvPage> createState() => _LuuCvPageState();
}

class _LuuCvPageState extends State<LuuCvPage> {
  bool allowSearch = false;
  bool isLoadingCv = true;

  final CvController _cvController = CvController();
  HoSoCvModel? cvData;

  final List<Map<String, String>> suggestedJobs = [
    {
      "title": "Nhân Viên Phòng Hợp Đồng",
      "company": "CÔNG TY TNHH CHO THUÊ TÀI CHÍNH...",
      "salary": "Thoả thuận",
      "location": "Hồ Chí Minh (mới)",
    },
    {
      "title": "Kỹ Sư Xây Dựng (QS Dự Toán - QA / QC -Shopdrawing- Giám Sát)",
      "company": "CÔNG TY TNHH XÂY DỰNG VÀ THƯƠNG...",
      "salary": "Thoả thuận",
      "location": "Hồ Chí Minh",
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchCvFromDatabase();
  }

  String getValue(List<String> keys, {String defaultValue = ""}) {
    return cvData?.getValue(keys, defaultValue: defaultValue) ?? defaultValue;
  }

  Map<String, dynamic> parseJsonField(String value) {
    if (value.trim().isEmpty) return {};

    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return {};
    } catch (_) {
      return {};
    }
  }

  String formatMapData(Map<String, dynamic> data) {
    if (data.isEmpty) return "Chưa cập nhật";

    final result = data.entries
        .where((e) => e.value != null && e.value.toString().trim().isNotEmpty)
        .map((e) => "${e.key}: ${e.value}")
        .join("\n");

    return result.isEmpty ? "Chưa cập nhật" : result;
  }

  String removeVietnameseAccent(String text) {
    const vietnamese =
        'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
        'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ';

    const latin =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd'
        'AAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';

    String result = text;
    for (int i = 0; i < vietnamese.length; i++) {
      result = result.replaceAll(vietnamese[i], latin[i]);
    }
    return result;
  }

  String pdfText(String text) {
    return removeVietnameseAccent(text);
  }

  Future<void> fetchCvFromDatabase() async {
    try {
      final latestCv = await _cvController.getLatestCv();

      if (mounted) {
        setState(() {
          cvData = latestCv;
          allowSearch = latestCv.getValue(
                ["trangThaiTimViec", "trang_thai_tim_viec"],
                defaultValue: "true",
              )
              .toLowerCase() !=
              "false";
          isLoadingCv = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingCv = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi lấy dữ liệu CV: $e")),
      );
    }
  }

  Future<void> updateSearchStatus(bool value) async {
    setState(() {
      allowSearch = value;
    });

    try {
      final idCv = getValue(["idCv", "id_cv"]);
      await _cvController.updateSearchStatus(idCv: idCv, value: value);
    } catch (_) {}
  }

  Future<void> downloadCvPdf() async {
    if (cvData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Chưa có dữ liệu CV để tải")),
      );
      return;
    }

    await CvPdfHelper.sharePdf(cvData!);
  }

  @override
  Widget build(BuildContext context) {
    final tieuDeCv = getValue(
      ["tieuDeCv", "tieu_de_cv"],
      defaultValue: "CV_Tuấn Anh Đặng",
    );

    final hoTen = getValue(
      ["hoTen", "ho_ten"],
      defaultValue: "Tuấn Anh Đặng",
    );

    return Scaffold(
      backgroundColor: const Color(0xfff4f5f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: 110,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Row(
            children: [
              SizedBox(width: 16),
              Icon(Icons.close, color: Color(0xff243447), size: 30),
              SizedBox(width: 8),
              Text(
                "Đóng",
                style: TextStyle(
                  color: Color(0xff243447),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoadingCv
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff00b14f),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 28),
                    child: Column(
                      children: [
                        const Text(
                          "Lưu CV thành công!",
                          style: TextStyle(
                            color: Color(0xff00b14f),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "Hồ sơ của bạn đã được cập nhật.\nBạn có thể dùng CV này để ứng tuyển ngay.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff243447),
                            fontSize: 22,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 36),

                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 86,
                                height: 130,
                                color: const Color(0xff4a2f33),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      hoTen,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 7,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 22),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tieuDeCv,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xff243447),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 70),

                                    Row(
                                      children: [
                                        OutlinedButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: const Text("Sửa lại"),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xff00b14f),
                                            side: const BorderSide(
                                              color: Color(0xff00b14f),
                                              width: 1.5,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                              vertical: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        OutlinedButton(
                                          onPressed: downloadCvPdf,
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xff00b14f),
                                            side: const BorderSide(
                                              color: Color(0xff00b14f),
                                              width: 1.5,
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(14),
                                          ),
                                          child: const Icon(Icons.download),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Cho phép NTD tìm kiếm hồ sơ",
                                style: TextStyle(
                                  color: Color(0xff243447),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(
                              value: allowSearch,
                              activeColor: const Color(0xff00b14f),
                              onChanged: updateSearchStatus,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Bật Cho phép ngay để không bỏ lỡ những cơ hội\nnghề nghiệp đầy tiềm năng.",
                          style: TextStyle(
                            color: Color(0xff243447),
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Row(
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: Color(0xff00b14f),
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Tìm hiểu thêm",
                              style: TextStyle(
                                color: Color(0xff00b14f),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Việc làm phù hợp với CV của bạn",
                          style: TextStyle(
                            color: Color(0xff243447),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        ...suggestedJobs.map((job) {
                          return _buildJobCard(job);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildJobCard(Map<String, String> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xfff0fff6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xff00b14f),
          width: 1.3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Center(
              child: Icon(
                Icons.business,
                color: Color(0xff00b14f),
                size: 42,
              ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job["title"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xff243447),
                    fontSize: 20,
                    height: 1.25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  job["company"]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xff00b14f),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            color: Color(0xff00b14f),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            job["salary"]!,
                            style: const TextStyle(
                              color: Color(0xff00b14f),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text(
                          job["location"]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff243447),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff00b14f),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Color(0xff00b14f),
            ),
          ),
        ],
      ),
    );
  }
}