import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/opciones/bloc/bloc/opciones_bloc.dart';
import 'package:paraiso_canino/opciones/widget/opciones_body.dart';

class OpcionesPage extends StatelessWidget {
  const OpcionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpcionesBloc>(
      create: (context) => OpcionesBloc(),
      child: const OpcionesBody(),
    );
  }
}
