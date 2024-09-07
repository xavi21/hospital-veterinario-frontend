import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/opcion_usuario/bloc/opcion_usuario_bloc.dart';
import 'package:paraiso_canino/opcion_usuario/widget/opcion_usuario_body.dart';

class OpcionUsuarioPage extends StatelessWidget {
  const OpcionUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpcionUsuarioBloc>(
      create: (context) => OpcionUsuarioBloc(),
      child: const OpcionUsuarioBody(),
    );
  }
}
