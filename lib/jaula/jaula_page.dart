import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/jaula/bloc/jaula_bloc.dart';
import 'package:paraiso_canino/jaula/widget/jaula_body.dart';

class JaulaPage extends StatelessWidget {
  const JaulaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JaulaBloc>(
      create: (context) => JaulaBloc(),
      child: const JaulaBody(),
    );
  }
}
