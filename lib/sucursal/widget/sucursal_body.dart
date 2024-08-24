import 'package:flutter/material.dart';

class SucursalBody extends StatefulWidget {
  const SucursalBody({super.key});

  @override
  State<SucursalBody> createState() => _SucursalBodyState();
}

class _SucursalBodyState extends State<SucursalBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sucursales'),
      ),
    );
  }
}
