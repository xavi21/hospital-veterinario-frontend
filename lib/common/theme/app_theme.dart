import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/style.dart';

ThemeData customThemeData() => ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all<bool>(true),
      ),
      brightness: Brightness.light,
      primaryColor: blue,
      useMaterial3: true,
      primaryColorLight: white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0.0),
          backgroundColor: const WidgetStatePropertyAll(blue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          overlayColor: WidgetStatePropertyAll(
            blueShade.withOpacity(0.4),
          ),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        surfaceTintColor: white,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: blue,
        selectionColor: blueSemiLight.withOpacity(0.5),
        selectionHandleColor: blueSemiLight.withOpacity(0.5),
      ),
      hoverColor: transparent,
      highlightColor: transparent,
      splashColor: transparent,
      canvasColor: white,
      cardColor: white,
      cardTheme: const CardTheme(
        surfaceTintColor: white,
        color: white,
      ),
      iconTheme: const IconThemeData(
        color: blue,
        size: 16.0,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          textStyle: displayLarge,
        ),
        displayMedium: GoogleFonts.poppins(
          textStyle: displayMedium,
        ),
        displaySmall: GoogleFonts.poppins(
          textStyle: displaySmall,
        ),
        headlineMedium: GoogleFonts.poppins(
          textStyle: headlineMedium,
        ),
        headlineSmall: GoogleFonts.poppins(
          textStyle: headlineSmall,
        ),
        bodyLarge: GoogleFonts.poppins(
          textStyle: bodyLarge,
        ),
        bodyMedium: GoogleFonts.poppins(
          textStyle: bodyMedium,
        ),
        labelLarge: GoogleFonts.poppins(
          textStyle: labelLarge,
        ),
        bodySmall: GoogleFonts.poppins(
          textStyle: bodySmall,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        filled: true,
        fillColor: white,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              32,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: inputBorder,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            32,
          ),
          borderSide: const BorderSide(
            color: error,
          ),
        ),
        labelStyle: bodySmall,
        hintStyle: bodySmall.copyWith(
          color: grey,
          fontSize: 12.0,
        ),
        errorStyle: bodySmall.copyWith(
          color: error,
          fontSize: 11.0,
        ),
      ),
      colorScheme: const ColorScheme(
        primary: blue,
        primaryContainer: blue,
        secondary: blue,
        secondaryContainer: blue,
        surface: blue,
        error: blue,
        onPrimary: blue,
        onSecondary: blue,
        onSurface: blue,
        onError: blue,
        brightness: Brightness.light,
      ).copyWith(
        surface: Colors.white,
      ),
    );
