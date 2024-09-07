import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cita/bloc/cita_bloc.dart';
import 'package:paraiso_canino/cita/widget/cita_body.dart';

class CitaPage extends StatelessWidget {
  const CitaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CitaBloc>(
      create: (context) => CitaBloc(),
      child: const CitaBody(),
    );
  }
}
