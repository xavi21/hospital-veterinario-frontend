import 'package:flutter/material.dart';

class UsuarioBody extends StatefulWidget {
  const UsuarioBody({super.key});

  @override
  State<UsuarioBody> createState() => _UsuarioBodyState();
}

class _UsuarioBodyState extends State<UsuarioBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Usuarios'),
      ),
    );
  }
}
