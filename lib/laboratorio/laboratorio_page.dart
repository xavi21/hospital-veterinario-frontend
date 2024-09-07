import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/laboratorio/bloc/laboratorio_bloc.dart';
import 'package:paraiso_canino/laboratorio/widget/laboratorio_body.dart';

class LaboratorioPage extends StatelessWidget {
  const LaboratorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LaboratorioBloc>(
      create: (context) => LaboratorioBloc(),
      child: const LaboratorioBody(),
    );
  }
}
