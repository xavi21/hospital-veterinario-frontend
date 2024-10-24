import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/casaMedica/bloc/casamedica_bloc.dart';
import 'package:paraiso_canino/casaMedica/widget/casa_medica_body.dart';

class CasaMedicaPage extends StatelessWidget {
  const CasaMedicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CasamedicaBloc(),
      child: const CasaMedicaBody(),
    );
  }
}
