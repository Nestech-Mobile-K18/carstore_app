sealed class RegisterState {}

class RegisterInitial extends RegisterState {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String username;
  final String password;
  final bool loading;
  final bool isRegister;

  RegisterInitial({
    this.id = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.username = '',
    this.password = '',
    this.loading = false,
    this.isRegister = false,
  });
}

class RegisterInProgress extends RegisterState {
  final bool loading;

  RegisterInProgress({this.loading = true});
}

class RegisterSuccess extends RegisterState {
  final bool isRegister;

  RegisterSuccess({this.isRegister = true});
}

class RegisterFailure extends RegisterState {
  final bool isRegister;

  RegisterFailure({this.isRegister = false});
}

class RegisterReset extends RegisterInitial {}
