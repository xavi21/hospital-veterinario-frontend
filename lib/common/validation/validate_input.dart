String? validateInput(String? value, bool isRequired) {
  if ((value == null || value.isEmpty) && isRequired) {
    return 'Campo requerido.';
  }
  return null;
}
