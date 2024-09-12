import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/tipoMascota/bloc/mascota_bloc.dart';
import 'package:paraiso_canino/tipoMascota/widget/mascota_body.dart';

class TipoMascotaPage extends StatelessWidget {
  const TipoMascotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TipoMascotaBloc>(
      create: (context) => TipoMascotaBloc(),
      child: const TipoMascotaBody(),
    );
  }
}
