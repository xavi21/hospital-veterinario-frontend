import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/statusUsuario/bloc/statususuario_bloc.dart';
import 'package:paraiso_canino/statusUsuario/widget/status_usuario_body.dart';

class StatusUsuarioPage extends StatelessWidget {
  const StatusUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatusUsuarioBloc>(
      create: (context) => StatusUsuarioBloc(),
      child: const StatusUsuarioBody(),
    );
  }
}
