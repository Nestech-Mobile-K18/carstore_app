import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/src/mainApp.dart';
import 'package:my_app/src/services/supabase/supabase_config.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(
    const MainApp(),
  );
}
