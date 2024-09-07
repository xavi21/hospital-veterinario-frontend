import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/color/bloc/color_bloc.dart';
import 'package:paraiso_canino/color/widget/color_body.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ColorBloc>(
      create: (context) => ColorBloc(),
      child: const ColorBody(),
    );
  }
}
