class NtdStatusUtils {
  static bool isDangTuyen(String status) => status.toLowerCase().contains('đang');
  static bool isTamDung(String status) => status.toLowerCase().contains('tạm');
}
