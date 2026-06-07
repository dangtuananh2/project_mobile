import 'package:flutter/material.dart';
import 'ungvien_page.dart'; // Đã thêm dòng này để fix lỗi đỏ

class DanhSachCvPage extends StatelessWidget {
  const DanhSachCvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Quản lý Hồ sơ CV", style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF009688)]),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Mới ứng tuyển (3)"),
              Tab(text: "Phỏng vấn (2)"),
              Tab(text: "Đạt (1)"),
              Tab(text: "Đã loại (5)"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCvList(context, "Mới", Colors.orange),
            _buildCvList(context, "Phỏng vấn", Colors.blue),
            _buildCvList(context, "Đạt", Colors.green),
            _buildCvList(context, "Đã loại", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildCvList(BuildContext context, String status, Color statusColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: 3,
      itemBuilder: (context, index) {
        String name = "Ứng viên Nguyễn Văn ${String.fromCharCode(65 + index)}";
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 5),
                          const Text("Ứng tuyển: Mobile Developer", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UngVienPage(name: name, role: "Mobile Developer"),
                        ),
                      );
                    },
                    child: const Text("Chi tiết & Đánh giá CV", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}