abstract class LoginEvent {}

class LoginStarted extends LoginEvent {
  LoginStarted({required this.username, required this.password});

  final String username;
  final String password;
}
