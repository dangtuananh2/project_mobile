class TinTuyenDungModel {
  final String title;
  final String status;
  final String date;
  final int cvCount;
  final List<String> skills;

  TinTuyenDungModel({
    required this.title,
    required this.status,
    required this.date,
    required this.cvCount,
    required this.skills,
  });

  factory TinTuyenDungModel.fromMap(Map<String, dynamic> map) {
    return TinTuyenDungModel(
      title: map['title']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      cvCount: int.tryParse(map['cv_count']?.toString() ?? '0') ?? 0,
      skills: (map['skills'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
