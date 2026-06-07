import 'package:flutter/material.dart';

class UngVienPage extends StatefulWidget {
  final String name;
  final String role;

  const UngVienPage({super.key, required this.name, required this.role});

  @override
  State<UngVienPage> createState() => _UngVienPageState();
}

class _UngVienPageState extends State<UngVienPage> with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  int _rating = 0; // Số sao đánh giá
  final TextEditingController _noteCtrl = TextEditingController();

  void _downloadCV() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang tải file PDF CV của ứng viên xuống...'), backgroundColor: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(height: 200, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF009688)]))),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    const Text("Chi tiết Hồ sơ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.file_download, color: Colors.white), onPressed: _downloadCV, tooltip: "Tải file CV"),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                          child: Column(
                            children: [
                              const CircleAvatar(radius: 40, backgroundColor: Colors.green, child: Icon(Icons.person, size: 40, color: Colors.white)),
                              const SizedBox(height: 10),
                              Text(widget.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text("Ứng tuyển: ${widget.role}", style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _infoItem(Icons.phone, "Điện thoại", "0909 123 456"),
                                  _infoItem(Icons.email, "Email", "ungvien@mail.com"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _tabItem("Chi tiết CV", 0),
                            _tabItem("Ghi chú & Đánh giá", 1),
                            _tabItem("File đính kèm", 2),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (tabIndex == 0) _buildDetailTab(),
                        if (tabIndex == 1) _buildRatingTab(),
                        if (tabIndex == 2) _buildFileTab(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -2))]),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: Colors.red)),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã chuyển CV vào danh sách loại!'))),
                child: const Text("TỪ CHỐI", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu dữ liệu và gửi email hẹn lịch!'), backgroundColor: Colors.green)),
                child: const Text("HẸN PHỎNG VẤN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => tabIndex = index),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: tabIndex == index ? Colors.green : Colors.grey, fontWeight: FontWeight.bold)),
          if (tabIndex == index) Container(margin: const EdgeInsets.only(top: 5), height: 2, width: 40, color: Colors.green),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // NỘI DUNG TAB 0: CHI TIẾT
  Widget _buildDetailTab() {
    return Column(
      children: [
        _buildSection("Kỹ năng", ["Telesales", "Tiếng Trung HSK3", "Giao tiếp", "Tin học VP"]),
        _buildSection("Học vấn & Kinh nghiệm", [
          "Đại học HUIT (2022 - 2026)",
          "Công ty ABC (01/2024 - Hiện tại)\nVị trí: Nhân viên tư vấn",
        ]),
      ],
    );
  }

  // NỘI DUNG TAB 1: GHI CHÚ ĐÁNH GIÁ (INTERACTIVE)
  Widget _buildRatingTab() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đánh giá của HR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(index < _rating ? Icons.star : Icons.star_border, color: Colors.orange, size: 30),
                onPressed: () => setState(() => _rating = index + 1),
              );
            }),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _noteCtrl,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Nhập ghi chú nội bộ về ứng viên này...",
              filled: true, fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(vertical: 12)),
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu ghi chú nội bộ!'), backgroundColor: Colors.blue));
              },
              child: const Text("Lưu Ghi Chú", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  // NỘI DUNG TAB 2: FILE MÔ PHỎNG PDF
  Widget _buildFileTab() {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 60, color: Colors.red),
          const SizedBox(height: 10),
          Text("CV_${widget.name.replaceAll(' ', '_')}.pdf", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
            onPressed: _downloadCV,
            icon: const Icon(Icons.open_in_new, color: Colors.white, size: 18),
            label: const Text("Mở file gốc", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildSection(String title, List items) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...items.map((e) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text("• $e", style: const TextStyle(height: 1.4)))),
        ],
      ),
    );
  }
}