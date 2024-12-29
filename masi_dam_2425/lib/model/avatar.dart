import 'package:masi_dam_2425/model/account_data.dart';
import 'package:masi_dam_2425/model/stats.dart';

class Avatar {
  late String name;
  late String title;
  late ConnectionData connectionData;
  late Stats stats;

  Avatar({
    required this.name,
    required this.connectionData,
    required this.title,
    required this.stats
  });

  Avatar.starter(String? name, Map<String, dynamic> accountData) {
    this.name = name ?? 'Player';
    title = 'Baby warrior';
    stats = Stats.starter();
    connectionData = ConnectionData.fromJson(accountData);
  }

  Avatar.empty() {
    name = 'User';
    title = 'Nobody';
    stats = Stats.starter();
  }

  get level => stats.level;

  get xp => stats.xp;

  copyWith({
    String? name,
    String? title,
    Stats? stats,
    String? email, required connectionData,}) {
    return Avatar(
      name: name ?? this.name,
      title: title ?? this.title,
      stats: stats ?? this.stats,
      connectionData: ConnectionData(
        email: email ?? connectionData.email,
        lastLogin: connectionData.lastLogin,
        firstLogin: connectionData.firstLogin,
        isVerified: connectionData.isVerified,
      ),
    );
  }

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      name: json['name'],
      connectionData: ConnectionData.fromJson(json['connectionData']),
      title: json['title'],
      stats: Stats.fromJson(json['stats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'stats': stats.toJson(),
    };
  }

}
