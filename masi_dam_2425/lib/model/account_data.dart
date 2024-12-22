class ConnectionData {
  late String email;
  late DateTime lastLogin;
  late DateTime firstLogin;
  late bool isVerified;

  ConnectionData({
    required this.email,
    required this.lastLogin,
    required this.firstLogin,
    required this.isVerified
  });

  String lastLoginFormatted() {
    return '${lastLogin.day.toString().padLeft(2, '0')}-'
        '${lastLogin.month.toString().padLeft(2, '0')}-'
        '${lastLogin.year}';
  }

  String firstLoginFormatted() {
    return '${firstLogin.day.toString().padLeft(2, '0')}-'
        '${firstLogin.month.toString().padLeft(2, '0')}-'
        '${firstLogin.year}';
  }

  factory ConnectionData.fromJson(Map<String, dynamic> json) {
    return ConnectionData(
      email: json['email'],
      lastLogin: json['lastLogin'],
      firstLogin: json['firstLogin'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'lastLogin': lastLogin,
      'firstLogin': firstLogin,
      'isVerified': isVerified,
    };
  }

  copyWith({required String email}) {
    return ConnectionData(
      email: email,
      lastLogin: lastLogin,
      firstLogin: firstLogin,
      isVerified: isVerified,
    );
  }

}