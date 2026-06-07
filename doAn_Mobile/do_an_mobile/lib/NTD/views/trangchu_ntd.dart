import 'package:flutter/material.dart';
import 'dang_tuyen_dung_page.dart';
import 'danhsach_cv_page.dart';

class TrangChuNtdPage extends StatefulWidget {
  const TrangChuNtdPage({super.key});

  @override
  State<TrangChuNtdPage> createState() => _TrangChuNtdPageState();
}

class _TrangChuNtdPageState extends State<TrangChuNtdPage> {
  String searchText = "";
  String selectedFilter = "Tất cả";

  // 🔥 DATA CHIẾN DỊCH (Giữ nguyên các chức năng cũ)
  final List<Map<String, String>> myJobs = [
    {
      "title": "Nhân Viên Kinh Doanh Fulltime",
      "status": "Đang mở",
      "cv_count": "15",
      "date": "Hạn: 30/05/2026",
      "skills": "Sales, Giao tiếp, Chốt đơn"
    },
    {
      "title": "Nhân Viên Video Editor",
      "status": "Đang mở",
      "cv_count": "08",
      "date": "Hạn: 15/06/2026",
      "skills": "Premiere, CapCut, Adobe"
    },
    {
      "title": "Thực tập sinh Marketing",
      "status": "Đã đóng",
      "cv_count": "20",
      "date": "Đã hết hạn",
      "skills": "Content, SEO, Facebook Ads"
    },
  ];

  // 🔥 SEARCH LOGIC: Tìm kiếm rộng (Tiêu đề + Kỹ năng)
  List<Map<String, String>> get filteredMyJobs {
    return myJobs.where((job) {
      bool matchFilter = selectedFilter == "Tất cả" || job["status"] == selectedFilter;
      
      // Tìm kiếm rộng: Kiểm tra tiêu đề công việc HOẶC kỹ năng yêu cầu
      String searchLower = searchText.toLowerCase();
      bool matchSearch = searchText.isEmpty || 
                         job["title"]!.toLowerCase().contains(searchLower) || 
                         job["skills"]!.toLowerCase().contains(searchLower);
      
      return matchFilter && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // 🔰 HEADER: Nâng cấp tìm kiếm rộng
          Container(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quản lý tuyển dụng",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => setState(() => searchText = value),
                  decoration: InputDecoration(
                    hintText: "Tìm tin đăng hoặc kỹ năng (SEO, Sales...)",
                    prefixIcon: const Icon(Icons.manage_search, color: Colors.green),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 📊 GIỮ LẠI THỐNG KÊ CŨ
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        _buildStatCard("CV Mới", "12", Colors.orange),
                        const SizedBox(width: 10),
                        _buildStatCard("Hẹn lịch", "05", Colors.blue),
                        const SizedBox(width: 10),
                        _buildStatCard("Tin đăng", "03", Colors.green),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ➕ NÚT TẠO TIN MỚI
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          side: const BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const DangTuyenDungPage()));
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Tạo tin tuyển dụng mới", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🏷️ BỘ LỌC TRẠNG THÁI (Giữ cũ)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Danh sách tin đăng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            _filterChip("Tất cả"),
                            _filterChip("Đang mở"),
                          ],
                        )
                      ],
                    ),
                  ),

                  // 📋 DANH SÁCH TIN ĐĂNG (Giữ các chức năng Quản lý CV cũ)
                  Column(
                    children: filteredMyJobs.map((job) => _buildJobItem(job)).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị số liệu cũ
  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String title) {
    bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = title),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 12)),
      ),
    );
  }

  // Widget Tin đăng cũ với khả năng hiển thị thêm Tag Kỹ năng
  Widget _buildJobItem(Map<String, String> job) {
    bool isActive = job["status"] == "Đang mở";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: isActive ? Colors.green : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.business_center, color: Colors.green),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Kỹ năng: ${job["skills"]}", style: const TextStyle(color: Colors.blue, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(job["cv_count"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  const Text("CV", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              )
            ],
          ),
          const Divider(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(job["status"]!, style: TextStyle(color: isActive ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DanhSachCvPage()));
                },
                child: const Text("Quản lý CV", style: TextStyle(color: Colors.white, fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }
}