class UserModel {
  final String id;

  final String phone;
  final String email;
  final String username;
  final String password;

  UserModel({
    required this.id,
    required this.phone,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phone'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
