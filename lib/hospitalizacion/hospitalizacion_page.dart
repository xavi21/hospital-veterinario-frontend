import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/hospitalizacion/bloc/hospitalizacion_bloc.dart';
import 'package:paraiso_canino/hospitalizacion/widget/hospitalizacion_body.dart';

class HospitalizacionPage extends StatelessWidget {
  const HospitalizacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HospitalizacionBloc>(
      create: (context) => HospitalizacionBloc(),
      child: const HospitalizacionBody(),
    );
  }
}
