import 'package:flutter/material.dart';
import 'trangchu_ntd.dart'; 
import 'danhsach_cv_page.dart';
import 'thongbao_page.dart';
import 'taikhoan_ntd_page.dart';

class HomeNtdPage extends StatefulWidget {
  const HomeNtdPage({super.key});

  @override
  State<HomeNtdPage> createState() => _HomeNtdPageState();
}

class _HomeNtdPageState extends State<HomeNtdPage> {
  int _currentIndex = 0;

  // Dùng IndexedStack để khi chuyển qua lại các tab không bị load lại trang
  final List<Widget> _pages = const [
    TrangChuNtdPage(), // Đảm bảo class trong file trangchu_ntd.dart tên là TrangChuNtdPage
    DanhSachCvPage(),
    ThongBaoPage(),
    TaiKhoanNtdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Bảng tin"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_ind), label: "Quản lý CV"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Thông báo"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Công ty"),
        ],
      ),
    );
  }
}