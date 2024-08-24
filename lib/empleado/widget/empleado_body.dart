import 'package:flutter/material.dart';

class EmpleadoBody extends StatefulWidget {
  const EmpleadoBody({super.key});

  @override
  State<EmpleadoBody> createState() => _EmpleadoBodyState();
}

class _EmpleadoBodyState extends State<EmpleadoBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Empleados'),
      ),
    );
  }
}
