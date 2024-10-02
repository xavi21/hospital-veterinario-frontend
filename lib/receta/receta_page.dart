import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/receta/bloc/receta_bloc.dart';
import 'package:paraiso_canino/receta/widget/receta_body.dart';

class CrearRecetaPage extends StatelessWidget {
  final int idConsulta;
  const CrearRecetaPage({
    super.key,
    required this.idConsulta,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecetaBloc(),
      child: CrearRecetaBody(
        idConsulta: idConsulta,
      ),
    );
  }
}
