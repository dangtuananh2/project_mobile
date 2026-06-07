import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/views/trangchu.dart';
import 'package:do_an_mobile/UngVien/views/taikhoan.dart';
import 'package:do_an_mobile/UngVien/views/thongbao.dart';
import 'package:do_an_mobile/UngVien/views/taocv.dart';
class NTD_UV extends StatefulWidget {
  const NTD_UV({super.key});

  @override
  State<NTD_UV> createState() => _NTD_UVState();
}

class _NTD_UVState extends State<NTD_UV> {
  int currentTab = 0;
  int _currentIndex = 2; // 👈 tab hiện tại

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔝 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Lời mời Cơ hội nghề nghiệp",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Các Nhà tuyển dụng đã ấn tượng và gửi lời mời cho bạn.\nHãy phản hồi để nhận cơ hội tốt hơn.",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 15),

          // 🔹 TAB BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              tabItem("Chờ phản hồi (2)", 0),
              tabItem("Đã phản hồi", 1),
              tabItem("Quá hạn", 2),
            ],
          ),

          const SizedBox(height: 5),

          // 🔹 LINE ACTIVE
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: currentTab == 0 ? 1 : 0,
                  child: Container(color: Colors.green),
                ),
                Expanded(
                  flex: currentTab == 1 ? 1 : 0,
                  child: Container(color: Colors.green),
                ),
                Expanded(
                  flex: currentTab == 2 ? 1 : 0,
                  child: Container(color: Colors.green),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: const [
                JobCard(
                  title: "Nhân viên Marketing",
                  company: "Công ty ABC",
                  salary: "15 - 20 triệu",
                  location: "Hà Nội",
                ),
                SizedBox(height: 15),
                JobCard(
                  title: "Frontend Developer",
                  company: "Công ty XYZ",
                  salary: "20 - 30 triệu",
                  location: "Hồ Chí Minh",
                ),
              ],
            ),
          ),
        ],
      ),

      // 🔥 BOTTOM NAV (ĐÚNG CHUẨN)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TrangChu()),
            );
          }

          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TaoCV()),
            );
          }

          if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ThongBao()),
            );
          }

          if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TaiKhoan()),
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

  // 🔹 TAB ITEM
  Widget tabItem(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTab = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: currentTab == index ? Colors.green : Colors.grey,
          fontWeight: currentTab == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// 🔥 CARD JOB
class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String salary;
  final String location;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            company,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              chip(salary),
              const SizedBox(width: 10),
              chip(location),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Đồng ý",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Từ chối",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 🔹 CHIP (đã fix trùng)
  Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}