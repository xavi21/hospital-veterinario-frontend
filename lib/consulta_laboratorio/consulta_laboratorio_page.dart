import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/consulta_laboratorio/bloc/consultalaboratorio_bloc.dart';
import 'package:paraiso_canino/consulta_laboratorio/widget/consulta_laboratorio_body.dart';

class ConsultaLaboratorioPage extends StatelessWidget {
  final int idConsulta;
  const ConsultaLaboratorioPage({
    super.key,
    required this.idConsulta,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsultalaboratorioBloc>(
      create: (context) => ConsultalaboratorioBloc(),
      child: ConsultaLaboratorioBody(
        idConsulta: idConsulta,
      ),
    );
  }
}
