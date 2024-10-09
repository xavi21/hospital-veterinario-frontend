import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/genero/bloc/genero_bloc.dart';
import 'package:paraiso_canino/genero/widget/genero_body.dart';

class GeneroPage extends StatelessWidget {
  const GeneroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GeneroBloc>(
      create: (context) => GeneroBloc(),
      child: const GeneroBody(),
    );
  }
}
