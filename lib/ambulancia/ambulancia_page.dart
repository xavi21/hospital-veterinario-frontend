import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/ambulancia/bloc/ambulancia_bloc.dart';
import 'package:paraiso_canino/ambulancia/widget/ambulancia_body.dart';

class AmbulanciaPage extends StatelessWidget {
  const AmbulanciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AmbulanciaBloc>(
      create: (context) => AmbulanciaBloc(),
      child: const AmbulanciaBody(),
    );
  }
}
