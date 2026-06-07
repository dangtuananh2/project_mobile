import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/views/dangnhap.dart';
class CapNhatMatKhau extends StatefulWidget {
  const CapNhatMatKhau({super.key});

  @override
  State<CapNhatMatKhau> createState() => _CapNhatMatKhauState();
}

class _CapNhatMatKhauState extends State<CapNhatMatKhau> {
  bool hidePass1 = true;
  bool hidePass2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // APPBAR
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              const Text(
                "Nhập mã xác nhận",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // MÔ TẢ
              const Text(
                "Chúng tôi đã gửi mã xác nhận tới địa chỉ dangtuananh.26125@gmail.com. "
                "Vui lòng kiểm tra hòm thư hoặc hòm thư spam để lấy mã và nhập vào bên dưới",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 25),

              // MÃ XÁC NHẬN
              const Text(
                "Mã xác nhận *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              buildInput("Nhập mã xác nhận"),

              const SizedBox(height: 15),

              // PASSWORD MỚI
              const Text(
                "Mật khẩu mới *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              buildPassword("Nhập mật khẩu mới", hidePass1, () {
                setState(() {
                  hidePass1 = !hidePass1;
                });
              }),

              const SizedBox(height: 15),

              // NHẬP LẠI PASSWORD
              const Text(
                "Nhập lại mật khẩu mới *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              buildPassword("Nhập lại mật khẩu mới", hidePass2, () {
                setState(() {
                  hidePass2 = !hidePass2;
                });
              }),

              const SizedBox(height: 15),

              // NOTE
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      "Mã xác nhận hết hạn sau 1 giờ kể từ khi bạn nhận được mã. ",
                    ),
                  ),
                  Text(
                    "Gửi lại mã",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // BUTTON DƯỚI
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // QUAY LẠI
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Quay lại",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // CẬP NHẬT
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DangNhap()),
                    );
                },
                child: const Text("Cập nhật mật khẩu", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // INPUT TEXT
  Widget buildInput(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // INPUT PASSWORD
  Widget buildPassword(
      String hint, bool obscure, VoidCallback toggle) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}