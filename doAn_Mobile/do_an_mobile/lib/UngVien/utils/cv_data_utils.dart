import 'dart:convert';

class CvDataUtils {
  static Map<String, dynamic> parseJsonField(String value) {
    if (value.trim().isEmpty) return {};
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } catch (_) {
      return {};
    }
  }

  static String formatMapData(Map<String, dynamic> data) {
    if (data.isEmpty) return 'Chưa cập nhật';
    final result = data.entries
        .where((e) => e.value != null && e.value.toString().trim().isNotEmpty)
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
    return result.isEmpty ? 'Chưa cập nhật' : result;
  }

  static String removeVietnameseAccent(String text) {
    const vietnamese =
        'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
        'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ';
    const latin =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd'
        'AAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';
    var result = text;
    for (int i = 0; i < vietnamese.length; i++) {
      result = result.replaceAll(vietnamese[i], latin[i]);
    }
    return result;
  }

  static String pdfText(String text) => removeVietnameseAccent(text);
}
