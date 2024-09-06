import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/menu/bloc/menu_bloc.dart';
import 'package:paraiso_canino/menu/widget/menu_body.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuBloc>(
      create: (context) => MenuBloc(),
      child: const MenuBody(),
    );
  }
}
