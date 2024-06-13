class RegisterEvent {}

class RegisterStarted extends RegisterEvent {
  RegisterStarted(
      {this.id, this.phone, this.email, this.username, this.password});
  final String? id;

  final String? phone;
  final String? email;
  final String? username;
  final String? password;
}

class SignInWithGoogleStarted extends RegisterEvent {}

class SignInWithFacebookStarted extends RegisterEvent {}

class SignInWithTwitterStarted extends RegisterEvent {}
