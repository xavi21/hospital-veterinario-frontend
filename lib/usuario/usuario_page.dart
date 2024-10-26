import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/usuario/bloc/usuario_bloc.dart';
import 'package:paraiso_canino/usuario/widget/usuario_body.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsuarioBloc(),
      child: const UsuarioBody(),
    );
  }
}
