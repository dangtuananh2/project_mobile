import 'package:flutter/material.dart';

class CapNhatThongTinNtdPage extends StatelessWidget {
  const CapNhatThongTinNtdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Sửa thông tin", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF009688)]))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.white, child: Icon(Icons.camera_alt, size: 30, color: Colors.grey)),
            const SizedBox(height: 20),
            TextField(controller: TextEditingController(text: "Công ty TNHH Tango"), decoration: _decor("Tên công ty")),
            const SizedBox(height: 15),
            TextField(controller: TextEditingController(text: "0123456789"), decoration: _decor("Mã số thuế")),
            const SizedBox(height: 15),
            TextField(controller: TextEditingController(text: "0909123456"), decoration: _decor("Số điện thoại")),
            const SizedBox(height: 15),
            TextField(controller: TextEditingController(text: "Quận 1, TP.HCM"), decoration: _decor("Địa chỉ")),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lưu thành công!"), backgroundColor: Colors.green));
                  Navigator.pop(context);
                },
                child: const Text("LƯU THAY ĐỔI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _decor(String label) => InputDecoration(
    labelText: label, filled: true, fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  );
}