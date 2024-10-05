import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/bloc/hospitalizacion_laboratorio_bloc.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/widget/hospitalizacion_laboratorio_body.dart';

class HospitalizacionLaboratorioPage extends StatelessWidget {
  final int idHospitalizacion;
  const HospitalizacionLaboratorioPage({
    super.key,
    required this.idHospitalizacion,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HospitalizacionLaboratorioBloc>(
      create: (context) => HospitalizacionLaboratorioBloc(),
      child: HospitalizacionLaboratorioBody(
        idHospitalizacion: idHospitalizacion,
      ),
    );
  }
}
