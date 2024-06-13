import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/src/config/router.dart';
import 'package:my_app/src/resources/common.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      childWidget: SizedBox(
        width: 64,
        height: 64,
        child: Image.asset("assets/images/logo.png"),
      ),
      backgroundColor: CommonValues.backgroundColorDefault,
      asyncNavigationCallback: () => Future.delayed(
        Duration.zero,
        () {
          GoRouter.of(context).go(RouteName.loginRoute);
        },
      ),
    );
  }
}
