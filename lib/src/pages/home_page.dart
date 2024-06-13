import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/src/config/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Home'),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  context.go(RouteName.loginRoute);
                },
                child: Text('Go to Login'))
          ],
        ),
      ),
    );
  }
}
