import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/consulta/bloc/consulta_bloc.dart';
import 'package:paraiso_canino/consulta/widget/consulta_body.dart';

class ConsultaPage extends StatelessWidget {
  const ConsultaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsultaBloc>(
      create: (context) => ConsultaBloc(),
      child: const ConsultaBody(),
    );
  }
}
