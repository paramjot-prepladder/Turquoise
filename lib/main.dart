import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/chat/chat.dart';
import 'package:testing/ui/home_tab/tab.dart';
import 'package:testing/ui/login/login.dart';
import 'package:testing/ui/menu/menu.dart';
import 'package:testing/ui/register/register.dart';
import 'package:testing/utils/color/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) => MaterialApp(
              title: 'TorQuoise',
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.greenPrimary),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: snapshot.data?.getString('token') == null
                  ? const LoginScreen()
                  : snapshot.data!.getString('token')!.toString().isEmpty
                      ? const LoginScreen()
                      : const TabHome(),
            ));
  }
}
