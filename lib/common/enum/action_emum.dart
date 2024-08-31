import 'package:flutter/material.dart';

enum TableRowActions {
  see,
  edit,
  delete;

  String textActions(BuildContext context) {
    switch (this) {
      case TableRowActions.see:
        return 'Ver';
      case TableRowActions.edit:
        return 'Editar';
      default:
        return 'Borrar';
    }
  }
}
