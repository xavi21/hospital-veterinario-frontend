import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cliente/bloc/cliente_bloc.dart';
import 'package:paraiso_canino/cliente/widget/cliente_body.dart';

class ClientePage extends StatelessWidget {
  const ClientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClienteBloc>(
      create: (context) => ClienteBloc(),
      child: const ClienteBody(),
    );
  }
}
