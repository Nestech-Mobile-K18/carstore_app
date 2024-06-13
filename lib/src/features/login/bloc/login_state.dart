sealed class LoginState {}

class LoginInitial extends LoginState {
  final String username;
  final String password;
  final bool loading;
  final bool isLogin;

  LoginInitial({
    this.username = '',
    this.password = '',
    this.loading = false,
    this.isLogin = false,
  });
}

class LoginInProgress extends LoginState {
  final bool loading;

  LoginInProgress({this.loading = true});
}

class LoginSuccess extends LoginState {
  final bool isLogin;

  LoginSuccess({this.isLogin = true});
}

class LoginFailure extends LoginState {
  final bool isLogin;

  LoginFailure({this.isLogin = false});
}

class LoginReset extends LoginInitial {}
