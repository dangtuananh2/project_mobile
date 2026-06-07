import 'package:do_an_mobile/UngVien/views/ntd_uv.dart';
import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/views/trangchu.dart';
import 'package:do_an_mobile/UngVien/views/taocv.dart';
import 'package:do_an_mobile/UngVien/views/taikhoan.dart';

class ThongBao extends StatelessWidget {
  const ThongBao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔝 APPBAR
      appBar: AppBar(
        title: const Text("Thông báo"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      // 📄 BODY
      body: ListView(
        children: const [
          notificationItem(
            title: "Việc làm làm mà bạn là ứng viên hàng đầu",
            content:
                "Bạn đang tìm kiếm cơ hội mới? Hãy khám phá cơ hội do Toppy AI lựa chọn nhé.",
            time: "13 ngày trước",
          ),
          notificationItem(
            title: "Việc làm làm mà bạn là ứng viên hàng đầu",
            content:
                "Bạn đang tìm kiếm cơ hội mới? Hãy khám phá cơ hội do Toppy AI lựa chọn nhé.",
            time: "16 ngày trước",
          ),
          notificationItem(
            title: "AI: 420 việc làm mới nhất",
            content:
                "420 việc làm mới nhất cho từ khóa bạn từng tìm kiếm. Tham khảo ngay!",
            time: "18 ngày trước",
          ),
          notificationItem(
            title: "Việc làm làm mà bạn là ứng viên hàng đầu",
            content:
                "Bạn đang tìm kiếm cơ hội mới? Hãy khám phá cơ hội do Toppy AI lựa chọn nhé.",
            time: "19 ngày trước",
          ),
        ],
      ),

      // 🔽 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TrangChu(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TaoCV(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NTD_UV(),
              ),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TaiKhoan(),
              ),
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
}

// 🔥 ITEM THÔNG BÁO
class notificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String time;

  const notificationItem({
    super.key,
    required this.title,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 LOGO
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Center(
              child: Text(
                "topcv",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // 🔹 TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}