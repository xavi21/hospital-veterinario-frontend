import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/detalle_consulta/bloc/detalleconsulta_bloc.dart';
import 'package:paraiso_canino/detalle_consulta/widget/detalle_consulta_body.dart';

class DetalleConsultaPage extends StatelessWidget {
  final ConsultaListModel? arguments;
  const DetalleConsultaPage({
    super.key,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetalleconsultaBloc>(
      create: (context) => DetalleconsultaBloc(),
      child: DetalleConsultaBody(
        arguments: arguments,
      ),
    );
  }
}
