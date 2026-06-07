import 'package:flutter/material.dart';

class ThongBaoPage extends StatefulWidget {
  const ThongBaoPage({super.key});

  @override
  State<ThongBaoPage> createState() => _ThongBaoPageState();
}

class _ThongBaoPageState extends State<ThongBaoPage> {
  // Dữ liệu giả lập có state
  List<Map<String, dynamic>> notifications = [
    {"id": 1, "title": "Có ứng viên mới", "sub": "Trần Văn Bình vừa nộp CV Telesales.", "time": "10 phút trước", "unread": true, "icon": Icons.person_add, "color": Colors.blue},
    {"id": 2, "title": "Xác nhận phỏng vấn", "sub": "Nguyễn Thị A đã xác nhận lịch phỏng vấn.", "time": "2 giờ trước", "unread": true, "icon": Icons.event_available, "color": Colors.green},
    {"id": 3, "title": "Tin sắp hết hạn", "sub": "Chiến dịch Marketing còn 2 ngày.", "time": "1 ngày trước", "unread": false, "icon": Icons.warning, "color": Colors.orange},
  ];

  void _markAllRead() {
    setState(() {
      for (var n in notifications) {
        n["unread"] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã đánh dấu tất cả là đã đọc')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Thông báo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF009688)]))),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist, color: Colors.white),
            tooltip: "Đánh dấu đã đọc",
            onPressed: _markAllRead,
          )
        ],
      ),
      body: notifications.isEmpty 
        ? const Center(child: Text("Không có thông báo nào", style: TextStyle(color: Colors.grey)))
        : ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notif = notifications[index];
              return Dismissible(
                key: Key(notif["id"].toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  setState(() => notifications.removeAt(index));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã xóa thông báo")));
                },
                child: Container(
                  color: notif["unread"] ? Colors.blue.withOpacity(0.05) : Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: Stack(
                      children: [
                        CircleAvatar(backgroundColor: notif["color"].withOpacity(0.1), radius: 25, child: Icon(notif["icon"], color: notif["color"])),
                        if (notif["unread"])
                          Positioned(right: 0, top: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
                      ],
                    ),
                    title: Text(notif["title"], style: TextStyle(fontWeight: notif["unread"] ? FontWeight.bold : FontWeight.w500)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notif["sub"]),
                          const SizedBox(height: 5),
                          Text(notif["time"], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() => notif["unread"] = false); // Bấm vào là hết đỏ
                    },
                  ),
                ),
              );
            },
          ),
    );
  }
}