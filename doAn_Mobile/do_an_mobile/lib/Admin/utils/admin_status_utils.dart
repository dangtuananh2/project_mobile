class AdminStatusUtils {
  static bool isPending(String status) => status.toLowerCase().contains('chờ');
  static bool isActive(String status) => status.toLowerCase().contains('hoạt động');
}
