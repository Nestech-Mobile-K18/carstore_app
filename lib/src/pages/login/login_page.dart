import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/src/config/router.dart';
import 'package:my_app/src/features/login/bloc/login_bloc.dart';
import 'package:my_app/src/features/login/bloc/login_event.dart';
import 'package:my_app/src/features/login/bloc/login_state.dart';
import 'package:my_app/src/pages/login/widgets/form_input_login.dart';
import 'package:my_app/src/pages/login/widgets/header_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  final bool _isShowPassword = false; // Remove final to allow changes

  void _onForgotPassword() {
    context.go(RouteName.forgotPasswordRoute);
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      context.read<LoginBloc>().add(LoginStarted(
            username: username,
            password: password,
          ));
    }
  }

  void _onSignUp() {
    context.go(RouteName.registerRoute);
  }

  Widget loginWidgets() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeaderLogin(),
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FormInputLogin(
                formKey: _formKey,
                isShowPassword: _isShowPassword,
                onForgotPassword: _onForgotPassword,
                onLogIn: _onLogin,
                onSignUp: _onSignUp,
                userController: _usernameController,
                passwordController: _passwordController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              print('Login successful, navigating to HomePage');
              context.go(RouteName.homeRoute);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đăng nhập thất bại')),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return loginWidgets();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
