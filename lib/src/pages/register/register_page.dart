import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/src/config/router.dart';
import 'package:my_app/src/features/register/bloc/regisster_bloc.dart';

import 'package:my_app/src/features/register/bloc/register_event.dart';
import 'package:my_app/src/features/register/bloc/register_state.dart';
import 'package:my_app/src/pages/register/widgets/form_input_register.dart';
import 'package:my_app/src/pages/register/widgets/header_register.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _mailController = TextEditingController(text: '');
  final TextEditingController _phoneController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();
  final bool _isShowPassword = false;
  final Uuid uuid = Uuid();

  void _onLogin() {
    context.go(RouteName.registerRoute);
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      final email = _mailController.text;
      final phone = _phoneController.text;
      final id = uuid.v4();
      context.read<RegisterBloc>().add(RegisterStarted(
            id: id,
            username: username,
            email: email,
            phone: phone,
            password: password,
          ));
    }
  }

  void _onGoogle() {
    context.read<RegisterBloc>().add(SignInWithGoogleStarted());
  }

  void _onFacebook() {
    context.read<RegisterBloc>().add(SignInWithFacebookStarted());
  }

  void _onTwitter() {
    context.read<RegisterBloc>().add(SignInWithTwitterStarted());
  }

  Widget registerWidgets() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeaderRegister(),
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FormInputRegister(
                formKey: _formKey,
                isShowPassword: _isShowPassword,
                onLogIn: _onLogin,
                onSignUp: _onSignUp,
                userController: _usernameController,
                mailController: _mailController,
                phoneController: _phoneController,
                passwordController: _passwordController,
                onGoogle: _onGoogle,
                onFacebook: _onFacebook,
                onTwitter: _onTwitter,
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
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              print('Login successful, navigating to HomePage');
              context.go(RouteName.homeRoute);
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đăng kí thất bại')),
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return registerWidgets();
            },
          ),
        ),
      ),
    );
  }
}
