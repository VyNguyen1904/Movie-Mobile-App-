class AuthUser {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String accessToken;

  const AuthUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      accessToken: json['accessToken'] ?? json['token'] ?? '',
    );
  }
}