import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/sucursal/bloc/sucursal_bloc.dart';
import 'package:paraiso_canino/sucursal/widget/sucursal_body.dart';

class SucursalPage extends StatelessWidget {
  const SucursalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SucursalBloc>(
      create: (context) => SucursalBloc(),
      child: const SucursalBody(),
    );
  }
}
