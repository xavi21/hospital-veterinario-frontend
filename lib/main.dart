import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/theme/app_theme.dart';
import 'package:paraiso_canino/login/login_page.dart';

void main() {
  runApp(const DogParadiseWeb());
}

class DogParadiseWeb extends StatelessWidget {
  const DogParadiseWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paraíso Canino',
      theme: customThemeData(),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      // supportedLocales: supportedLocales,
    );
  }
}
