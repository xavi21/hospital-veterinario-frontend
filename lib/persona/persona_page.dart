import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/persona/bloc/persona_bloc.dart';
import 'package:paraiso_canino/persona/widget/persona_body.dart';

class PersonaPage extends StatelessWidget {
  const PersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonaBloc>(
      create: (context) => PersonaBloc(),
      child: const PersonaBody(),
    );
  }
}
