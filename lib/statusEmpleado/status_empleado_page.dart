import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/statusEmpleado/bloc/statusempleado_bloc.dart';
import 'package:paraiso_canino/statusEmpleado/widget/status_empleado_body.dart';

class StatusEmpleadoPage extends StatelessWidget {
  const StatusEmpleadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatusEmpleadoBloc>(
      create: (context) => StatusEmpleadoBloc(),
      child: const StatusEmpleadoBody(),
    );
  }
}
