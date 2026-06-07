class UngVienProfileModel {
  final int userId;
  final String userName;
  final String userEmail;
  final String userCode;
  final String userPhone;
  final String userAddress;
  final String userGender;
  final String userBirthDate;
  final String avatarPath;

  UngVienProfileModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userCode,
    this.userPhone = '',
    this.userAddress = '',
    this.userGender = '',
    this.userBirthDate = '',
    this.avatarPath = '',
  });

  UngVienProfileModel copyWith({
    String? userName,
    String? userEmail,
    String? userCode,
    String? userPhone,
    String? userAddress,
    String? userGender,
    String? userBirthDate,
    String? avatarPath,
  }) {
    return UngVienProfileModel(
      userId: userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userCode: userCode ?? this.userCode,
      userPhone: userPhone ?? this.userPhone,
      userAddress: userAddress ?? this.userAddress,
      userGender: userGender ?? this.userGender,
      userBirthDate: userBirthDate ?? this.userBirthDate,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
