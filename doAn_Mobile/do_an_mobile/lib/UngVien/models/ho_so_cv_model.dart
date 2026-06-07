class HoSoCvModel {
  final Map<String, dynamic> data;

  HoSoCvModel(this.data);

  factory HoSoCvModel.fromJson(Map<String, dynamic> json) => HoSoCvModel(json);

  Map<String, dynamic> toJson() => data;

  String getValue(List<String> keys, {String defaultValue = ''}) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return defaultValue;
  }

  String get idCv => getValue(['idCv', 'id_cv']);

  String get tieuDeCv => getValue(['tieuDeCv', 'tieu_de_cv'], defaultValue: 'CV');

  String get hoTen => getValue(['hoTen', 'ho_ten'], defaultValue: 'Người dùng');
}
