class User {
  final String id;
  final String email;
  final String role;
  final bool appAccess;
  final bool isAdmin;
  final Map<String, dynamic> token;

  const User(
    this.id,
    this.email,
    this.role,
    this.appAccess,
    this.isAdmin,
    this.token,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'],
      json['role'],
      json['app_access'],
      json['admin_access'],
      json['token'],
    );
  }
}
