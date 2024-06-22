import 'package:go_router/go_router.dart';
import 'package:my_app/src/pages/application/application_page.dart';
import 'package:my_app/src/pages/forgot_password_page.dart';
import 'package:my_app/src/pages/home/home_page.dart';
import 'package:my_app/src/pages/login/login_page.dart';
import 'package:my_app/src/pages/register/register_page.dart';
import 'package:my_app/src/pages/welcome_page.dart';

class RouteName {
  static const String applicationRoute = '/application';
  static const String homeRoute = '/home';
  static const String welcomeRoute = '/welcome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';

  static const publicRoutes = [
    applicationRoute,
    homeRoute,
    welcomeRoute,
    loginRoute,
    registerRoute,
    forgotPasswordRoute
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }

    return RouteName.welcomeRoute;
  },
  routes: [
    GoRoute(
      path: RouteName.applicationRoute,
      builder: (context, state) => const ApplicationPage(),
    ),
    GoRoute(
      path: RouteName.homeRoute,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RouteName.welcomeRoute,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: RouteName.loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteName.registerRoute,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: RouteName.forgotPasswordRoute,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
  ],
);
