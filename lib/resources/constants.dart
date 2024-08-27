import 'package:flutter/material.dart';

const String imagePath = 'assets/images/';
const String iconPath = 'assets/icons/';
const String animationPath = 'assets/animations/';
const String responseMessage = 'message';
const String responseCode = 'status';
const String emptyString = '';
const List<Locale> supportedLocales = [
  Locale('es'),
  Locale('en'),
];
const emailRegexp =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String passwordRegExp = r'^([^0-9]*|[^A-Z]*|[^a-z]*|[a-zA-Z0-9]*)$';
