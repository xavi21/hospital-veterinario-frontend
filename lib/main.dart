import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/theme/app_theme.dart';
import 'package:paraiso_canino/home/home_page.dart';
import 'package:paraiso_canino/resources/constants.dart';

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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      supportedLocales: supportedLocales,
    );
  }
}
