import 'package:flutter/material.dart';
import 'package:paraiso_canino/resources/colors.dart';

ThemeData customThemeData() => ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all<bool>(true),
      ),
      brightness: Brightness.light,
      primaryColor: blue,
    );
