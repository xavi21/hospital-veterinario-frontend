import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/mascota/bloc/mascota_bloc.dart';
import 'package:paraiso_canino/mascota/widget/mascota_body.dart';

class MascotaPage extends StatelessWidget {
  const MascotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MascotaBloc>(
      create: (context) => MascotaBloc(),
      child: const MascotaBody(),
    );
  }
}
