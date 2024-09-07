import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/talla/bloc/talla_bloc.dart';
import 'package:paraiso_canino/talla/widget/talla_body.dart';

class TallaPage extends StatelessWidget {
  const TallaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TallaBloc>(
      create: (context) => TallaBloc(),
      child: const TallaBody(),
    );
  }
}
