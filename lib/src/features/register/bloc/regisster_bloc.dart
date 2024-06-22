import 'package:bloc/bloc.dart';
import 'package:my_app/src/features/data/register/user.dart';
import 'package:my_app/src/features/register/bloc/register_event.dart';
import 'package:my_app/src/features/register/bloc/register_state.dart';
import 'package:my_app/src/services/api/user_api.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserAPI _userAPI;

  RegisterBloc(this._userAPI) : super(RegisterInitial()) {
    on<RegisterStarted>(_onRegisterStarted);
    on<SignInWithGoogleStarted>(_onSignInWithGoogleStarted);
    on<SignInWithFacebookStarted>(_onSignInWithFacebookStarted);
    on<SignInWithTwitterStarted>(_onSignInWithTwitterStarted);
  }

  Future<void> _onRegisterStarted(
      RegisterStarted event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());

    try {
      UserModel newUser = UserModel(
        id: event.id ?? '',
        phone: event.phone ?? '',
        email: event.email ?? '',
        username: event.username ?? '',
        password: event.password ?? '',
      );

      await _userAPI.registerUser(newUser);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure());
    }
  }

  // Hàm xử lý đăng nhập Google
  Future<void> _onSignInWithGoogleStarted(
      SignInWithGoogleStarted event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());

    try {
      await _userAPI.signInWithGoogle();
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure());
    }
  }

  Future<void> _onSignInWithFacebookStarted(
      SignInWithFacebookStarted event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());

    try {
      await _userAPI.checkFacebookIsSignUp();
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure());
    }
  }

  Future<void> _onSignInWithTwitterStarted(
      SignInWithTwitterStarted event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());

    try {
      await _userAPI.signInWithTwitter();
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure());
    }
  }
}
