import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/medicamento/bloc/medicamento_bloc.dart';
import 'package:paraiso_canino/medicamento/widget/medicamento_body.dart';

class MedicamentoPage extends StatelessWidget {
  const MedicamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicamentoBloc>(
      create: (context) => MedicamentoBloc(),
      child: const MedicamentoBody(),
    );
  }
}
