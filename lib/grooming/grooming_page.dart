import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/grooming/bloc/grooming_bloc.dart';
import 'package:paraiso_canino/grooming/widget/grooming_body.dart';

class GroomingPage extends StatelessWidget {
  const GroomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroomingBloc>(
      create: (context) => GroomingBloc(),
      child: const GroomingBody(),
    );
  }
}
