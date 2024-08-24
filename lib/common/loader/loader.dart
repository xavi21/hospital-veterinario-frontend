import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: white.withOpacity(
          0.6,
        ),
        alignment: Alignment.center,
        child: Lottie.asset(
          '${animationPath}loader.json',
        ),
      ),
    );
  }
}
