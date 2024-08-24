String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Contraseña requerida.';
  }
  return null;
}
