// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/app.dart';
import 'package:my_app/src/features/application/bloc/application_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealers_featured_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealers_recomment_bloc.dart';
import 'package:my_app/src/features/login/bloc/login_bloc.dart';
import 'package:my_app/src/features/register/bloc/regisster_bloc.dart';
import 'package:my_app/src/services/api/car_dealers_api.dart';
import 'package:my_app/src/services/api/user_api.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final UserAPI _userService = UserAPI();
  final CarDealersAPI _carDealersAPI = CarDealersAPI();

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
        BlocProvider<ApplicationBlocs>(
          create: (context) => ApplicationBlocs(),
        ),
        BlocProvider<CarDealersFeaturedBloc>(
          create: (context) => CarDealersFeaturedBloc(_carDealersAPI),
        ),
        BlocProvider<CarDealersRecommentBloc>(
          create: (context) => CarDealersRecommentBloc(_carDealersAPI),
        ),
      ],
      child: const App(),
    );
  }
}
