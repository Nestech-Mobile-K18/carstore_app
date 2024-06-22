import 'package:bloc/bloc.dart';
import 'package:my_app/src/features/data/register/user.dart';
import 'package:my_app/src/services/api/user_api.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserAPI _userAPI;

  LoginBloc(this._userAPI) : super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
  }

  void _onLoginStarted(LoginStarted event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
      List<UserModel> users = await _userAPI.fetchUsers();
      UserModel? user;
      try {
        user = users.firstWhere(
          (user) =>
              user.username == event.username &&
              user.password == event.password,
        );
      } catch (e) {
        user = null;
      }

      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
