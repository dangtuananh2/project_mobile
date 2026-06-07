import 'package:flutter/material.dart';
import 'package:do_an_mobile/UngVien/controllers/auth_controller.dart';

class DangKy extends StatefulWidget {
  const DangKy({super.key});

  @override
  State<DangKy> createState() => _DangKyState();
}

class _DangKyState extends State<DangKy> {
  bool isChecked = false;
  final AuthController _authController = AuthController();
  bool _isLoading = false;

  String selectedRole = "Ứng viên";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get isUngVien => selectedRole == "Ứng viên";

  Future<void> registerUser() async {
    final String nameOrCompany = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (nameOrCompany.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập lại mật khẩu")),
      );
      return;
    }

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng đồng ý với điều khoản")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu nhập lại không khớp")),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      await _authController.register(
        email: email,
        password: password,
        isUngVien: isUngVien,
        nameOrCompany: nameOrCompany,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isUngVien
                ? "Đăng ký ứng viên thành công!"
                : "Đăng ký nhà tuyển dụng thành công!",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Lỗi đăng ký: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký thất bại: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String nameHint = isUngVien ? "Họ và tên" : "Tên công ty";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 80,
                  child: Image.asset(
                    'assets/images/jobgo.jpg',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.work, size: 50, color: Colors.green),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Đăng ký tài khoản",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  isUngVien
                      ? "Tạo tài khoản để tìm việc phù hợp"
                      : "Tạo tài khoản để đăng tin tuyển dụng",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),

                const SizedBox(height: 28),

                buildRoleSelector(),

                const SizedBox(height: 18),

                buildInput(
                  nameHint,
                  _nameController,
                  icon: isUngVien
                      ? Icons.person_outline
                      : Icons.business_outlined,
                ),

                const SizedBox(height: 15),

                buildInput(
                  "Email",
                  _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                buildInput(
                  "Mật khẩu",
                  _passwordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 15),

                buildInput(
                  "Nhập lại mật khẩu",
                  _confirmPasswordController,
                  icon: Icons.lock_reset_outlined,
                  isPassword: true,
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() => isChecked = value ?? false);
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: "Tôi đồng ý với ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Điều khoản",
                              style: TextStyle(color: Colors.green),
                            ),
                            TextSpan(text: " và "),
                            TextSpan(
                              text: "Chính sách",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      disabledBackgroundColor: Colors.green.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _isLoading ? null : registerUser,
                    child: _isLoading
                        ? const SizedBox(
                            height: 21,
                            width: 21,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            isUngVien
                                ? "Đăng ký ứng viên"
                                : "Đăng ký nhà tuyển dụng",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoleSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: roleButton(
              title: "Ứng viên",
              icon: Icons.person_outline,
              active: isUngVien,
              onTap: () {
                setState(() {
                  selectedRole = "Ứng viên";
                  _nameController.clear();
                });
              },
            ),
          ),
          Expanded(
            child: roleButton(
              title: "Nhà tuyển dụng",
              icon: Icons.business_center_outlined,
              active: !isUngVien,
              onTap: () {
                setState(() {
                  selectedRole = "Nhà tuyển dụng";
                  _nameController.clear();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget roleButton({
    required String title,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
