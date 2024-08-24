import 'package:paraiso_canino/resources/constants.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Correo requerido.';
  } else {
    return RegExp(emailRegexp).hasMatch(value)
        ? 'Correo electrónico invalido.'
        : null;
  }
}
