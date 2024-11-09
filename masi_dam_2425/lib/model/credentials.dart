class Credentials {
  final int id;
  final String email;
  final String apiToken;

  const Credentials({
    required this.id,
    required this.email,
    required this.apiToken,
  });

  Map<String, Object?> toMap() {
      return {
        'id': id,
        'email': email,
        'apiToken': apiToken,
      };
    }
}
