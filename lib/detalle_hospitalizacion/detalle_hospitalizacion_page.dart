import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/bloc/detallehospitalizacion_bloc.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/widget/detalle_hospitalizacion_body.dart';
import 'package:paraiso_canino/hospitalizacion/model/hotpitalizacion_list_model.dart';

class DetalleHospitalizacionPage extends StatelessWidget {
  final HospitalizacionListModel? arguments;
  const DetalleHospitalizacionPage({
    super.key,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetallehospitalizacionBloc(),
      child: DetallehospitalizacionBody(
        arguments: arguments,
      ),
    );
  }
}
