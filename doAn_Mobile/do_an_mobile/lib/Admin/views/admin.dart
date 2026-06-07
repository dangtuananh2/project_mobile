import 'package:flutter/material.dart';

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00B14F),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Danh sách các Menu mục lục
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard, 'label': 'Tổng quan'},
    {'icon': Icons.people, 'label': 'Người tìm việc'},
    {'icon': Icons.business, 'label': 'Nhà tuyển dụng'},
    {'icon': Icons.post_add, 'label': 'Quản lý tin'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _menuItems[_selectedIndex]['label'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF00B14F),
        iconTheme: const IconThemeData(color: Colors.white),

        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, size: 26),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bạn không có thông báo mới nào."),
                    ),
                  );
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(child: _buildDrawerContent()),
      // Logic chuyển đổi trang: Nếu index = 0 thì hiện Dashboard, ngược lại hiện trang tương ứng
      body: _buildBody(),
    );
  }

  // Hàm quyết định nội dung hiển thị của body
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const OverviewScreen(); // Trang Dashboard ban đầu
      case 1:
        return const UserManagementScreen(); // Trang Quản lý Người tìm việc
      case 2:
        return const RecruiterManagementScreen(); // Trang Quản lý Nhà tuyển dụng
      case 3:
        return const JobPostManagementScreen(); //Trang Quản lý tin
      default:
        return Center(
          child: Text(
            "Giao diện ${_menuItems[_selectedIndex]['label']} đang cập nhật",
          ),
        );
    }
  }

  Widget _buildDrawerContent() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xFF00B14F)),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Color(0xFF00B14F), size: 40),
          ),
          accountName: Text(
            "Nguyễn Văn Khải",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text("Admin - JobsGo System"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _menuItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  _menuItems[index]['icon'],
                  color: _selectedIndex == index
                      ? const Color(0xFF00B14F)
                      : Colors.grey,
                ),
                title: Text(_menuItems[index]['label']),
                selected: _selectedIndex == index,
                onTap: () {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),

        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            "Đăng xuất",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pop(context); // Đóng drawer trước
            // Xử lý logic đăng xuất tài khoản ở đây (ví dụ điều hướng về trang Login)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đang đăng xuất hệ thống...")),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// --- TRANG 1: TỔNG QUAN ---
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 1200 ? 4 : (width > 600 ? 2 : 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Chào mừng quay trở lại, Admin",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.8,
            children: [
              _infoCard("Người dùng", "12,500", Icons.people, Colors.blue),
              _infoCard(
                "Nhà tuyển dụng",
                "1,850",
                Icons.business,
                Colors.orange,
              ),
              _infoCard(
                "Tin tuyển dụng",
                "3,120",
                Icons.post_add,
                Colors.green,
              ),
              _infoCard("CV đã tạo", "9,100", Icons.description, Colors.purple),
            ],
          ),

          const SizedBox(height: 30),
          const Text(
            "Hoạt động gần đây",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Center(child: Text("Biểu đồ tăng trưởng hệ thống")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- TRANG 2: QUẢN LÝ NGƯỜI TÌM VIỆC ---
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // --- Ô TÌM KIẾM ---
          TextField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm theo tên hoặc ID người dùng...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF00B14F)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              // Xử lý logic tìm kiếm tại đây
            },
          ),
          const SizedBox(height: 20),

          // --- DANH SÁCH ---
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) => Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text("Ứng viên: Nguyễn Văn $index"),
                  subtitle: Text("ID: 2026$index • Kỹ năng: Mobile Dev"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- TRANG 3: QUẢN LÝ NHÀ TUYỂN DỤNG (CÓ TAB DUYỆT) ---
class RecruiterManagementScreen extends StatelessWidget {
  const RecruiterManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm tên công ty hoặc Mã số thuế (ID)...",
                prefixIcon: const Icon(
                  Icons.business_center,
                  color: Color(0xFF00B14F),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          const TabBar(
            labelColor: Color(0xFF00B14F),
            indicatorColor: Color(0xFF00B14F),
            tabs: [
              Tab(text: "Chờ phê duyệt"),
              Tab(text: "Đã xác thực"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildList(isPending: true),
                _buildList(isPending: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList({required bool isPending}) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: isPending ? 3 : 8,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.business),
          title: Text(
            isPending
                ? "Công ty mới đăng ký $index"
                : "Đối tác chiến lược $index",
          ),
          subtitle: Text(isPending ? "Yêu cầu duyệt hồ sơ" : "Đang hoạt động"),
          trailing: isPending
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Duyệt",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Từ chối",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : const Icon(Icons.check_circle, color: Colors.blue),
        ),
      ),
    );
  }
}

// --- TRANG 4: QUẢN LÝ TIN TUYỂN DỤNG ---
class JobPostManagementScreen extends StatefulWidget {
  const JobPostManagementScreen({super.key});

  @override
  State<JobPostManagementScreen> createState() =>
      _JobPostManagementScreenState();
}

class _JobPostManagementScreenState extends State<JobPostManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Ô TÌM KIẾM TIN ---
          TextField(
            decoration: InputDecoration(
              hintText: "Tìm tiêu đề tin hoặc ID bài đăng...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF00B14F)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Danh sách bài đăng tuyển dụng",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // --- DANH SÁCH TIN ---
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                // Giả lập các trạng thái khác nhau
                String status = index % 3 == 0 ? "Chờ duyệt" : "Đang hiển thị";
                Color statusColor = index % 3 == 0
                    ? Colors.orange
                    : Colors.green;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.description,
                          color: Color(0xFF00B14F),
                        ),
                      ),
                      title: Text(
                        "Lập trình viên Flutter (DART) #$index",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text("Công ty: Tech Solution Co., Ltd"),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "ID: JOB-102$index",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // --- NÚT CHỈNH SỬA ---
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.edit_note,
                          color: Colors.blue,
                          size: 28,
                        ),
                        onPressed: () {
                          _showEditDialog(
                            context,
                            "Lập trình viên Flutter #$index",
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị hộp thoại chỉnh sửa nhanh
  void _showEditDialog(BuildContext context, String currentTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Chỉnh sửa tin tuyển dụng"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: currentTitle),
                decoration: const InputDecoration(labelText: "Tiêu đề tin"),
              ),
              const SizedBox(height: 15),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Mô tả ngắn gọn",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B14F),
            ),
            child: const Text(
              "Lưu thay đổi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
