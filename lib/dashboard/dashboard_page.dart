import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/dashboard/bloc/dashboard_bloc.dart';
import 'package:paraiso_canino/dashboard/widget/dashboard_body.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc(),
      child: const DashboardBody(),
    );
  }
}
