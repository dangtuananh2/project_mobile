import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/views/trangchu.dart';
import 'package:do_an_mobile/UngVien/views/taikhoan.dart';
import 'package:do_an_mobile/UngVien/views/taomau.dart';
import 'package:do_an_mobile/UngVien/views/mycv.dart';
import 'package:do_an_mobile/UngVien/views/ntd_uv.dart';
import 'package:do_an_mobile/UngVien/views/thongbao.dart';

class TaoCV extends StatefulWidget {
  const TaoCV({super.key});

  @override
  State<TaoCV> createState() => _TaoCVState();
}

class _TaoCVState extends State<TaoCV> {

  String selectedStyle = "Tất cả"; // 🔥 thêm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Tạo CV"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCV(),
                ),
              );
            },
            child: const Text(
              "CV của tôi",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tạo CV ngay để nhân đôi cơ hội trúng tuyển:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("• Mẫu CV chuẩn ATS, dễ dàng vượt qua vòng lọc hồ sơ."),
            const Text("• Chỉ 15 phút cho 1 chiếc CV chuyên nghiệp"),

            const SizedBox(height: 10),

            Row(
              children: const [
                Text("Bạn đã có CV trên điện thoại? "),
                Text(
                  "Tải lên CV",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),

            const SizedBox(height: 15),

            // STYLE FILTER
            Row(
              children: [
                const Text("Style: "),
                chip("Tất cả"),
                chip("Đơn giản"),
                chip("Chuyên nghiệp"),
              ],
            ),

            const SizedBox(height: 20),

            // CV PREVIEW (ẢNH) 🔥 chỉ sửa đoạn này
            Container(
              width: double.infinity,
              height: 650,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: selectedStyle == "Đơn giản"
                    ? buildCVItem("assets/images/cv_chuyennghiep.jpg")
                    : selectedStyle == "Chuyên nghiệp"
                        ? buildCVItem("assets/images/cv_mau.jpg")
                        : Column(
                            children: [
                              Expanded(
                                child: buildCVItem("assets/images/cv_mau.jpg"),
                              ),
                              const Divider(),
                              Expanded(
                                child: buildCVItem("assets/images/cv_chuyennghiep.jpg"),
                              ),
                            ],
                          ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),

      // 🔽 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if(index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TrangChu(),),
            );
          }
          if(index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NTD_UV(),),
            );
          }
          if(index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ThongBao(),),
            );
          }
          if(index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TaiKhoan(),),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: "Tạo CV"),
          BottomNavigationBarItem(
              icon: Icon(Icons.group), label: "NTD -> UV"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Thông báo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Tài khoản"),
        ],
      ),
    );
  }

  // CHIP STYLE (giữ nguyên logic bạn đã sửa)
  Widget chip(String text) {
    final bool selected = selectedStyle == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStyle = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green),
          color: selected ? Colors.green : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }

  // 🔥 THÊM MỚI
  Widget buildCVItem(String imagePath) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            width: double.infinity,
            fit: BoxFit.contain
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaoMau(type: imagePath.contains("chuyennghiep") ? "pro" : "simple"),
                ),
              );
            },
            child: const Text(
              "Dùng mẫu này",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}