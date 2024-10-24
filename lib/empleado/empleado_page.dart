import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/empleado/bloc/empleado_bloc.dart';
import 'package:paraiso_canino/empleado/widget/empleado_body.dart';

class EmpleadoPage extends StatelessWidget {
  const EmpleadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmpleadoBloc(),
      child: const EmpleadoBody(),
    );
  }
}
