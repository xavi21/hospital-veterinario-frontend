import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/consulta_laboratorio/bloc/consultalaboratorio_bloc.dart';
import 'package:paraiso_canino/consulta_laboratorio/widget/consulta_laboratorio_body.dart';

class ConsultaLaboratorioPage extends StatelessWidget {
  const ConsultaLaboratorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsultalaboratorioBloc>(
      create: (context) => ConsultalaboratorioBloc(),
      child: const ConsultaLaboratorioBody(),
    );
  }
}
