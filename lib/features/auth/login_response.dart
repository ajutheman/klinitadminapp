class LoginResponse {
  final bool status;
  final String token;
  final int adminId;
  final String name;
  final String email;

  LoginResponse({
    required this.status,
    required this.token,
    required this.adminId,
    required this.name,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      token: json['token'],
      adminId: json['admin_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
