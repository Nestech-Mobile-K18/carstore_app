// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/app.dart';
import 'package:my_app/src/features/login/bloc/login_bloc.dart';
import 'package:my_app/src/features/register/bloc/regisster_bloc.dart';
import 'package:my_app/src/services/mock/user/user_api.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final UserAPI _userService = UserAPI();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(_userService),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(_userService),
        ),
      ],
      child: const App(),
    );
  }
}
