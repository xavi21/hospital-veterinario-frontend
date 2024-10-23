import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/dashboard/bloc/dashboard_bloc.dart';
import 'package:paraiso_canino/dashboard/model/consulta_response.dart';
import 'package:paraiso_canino/dashboard/model/grooming_list_model.dart';
import 'package:paraiso_canino/dashboard/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/dashboard/model/mascota_list_model.dart';
import 'package:paraiso_canino/dashboard/widget/indicator.dart';
import 'package:paraiso_canino/resources/colors.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  List<ConsultaListModel> _consultas = [];
  List<GroomingListModel> _groomings = [];
  List<MascotaListModel> _mascotas = [];
  List<HospitalizacionListModel> _hospitalizaciones = [];

  final List<Color> _listColors = [
    const Color(0xFF4A628A),
    const Color(0xFF7AB2D3),
    const Color(0xFFB9E5E8),
    const Color(0xFFDFF2EB),
    const Color(0xFF4A628A),
    const Color(0xFF7AB2D3),
    const Color(0xFFB9E5E8),
    const Color(0xFFDFF2EB),
  ];

  @override
  void initState() {
    _getDashboards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<DashboardBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (DashboardConsultaSuccess):
              final loadedState = state as DashboardConsultaSuccess;
              setState(() => _consultas = loadedState.consultas);
              break;
            case const (DashboardGroomingSuccess):
              final loadedState = state as DashboardGroomingSuccess;
              setState(() => _groomings = loadedState.groomings);
              break;
            case const (DashboardMascotaSuccess):
              final loadedState = state as DashboardMascotaSuccess;
              setState(() => _mascotas = loadedState.mascotas);
              break;
            case const (DashboardHospitalizacionSuccess):
              final loadedState = state as DashboardHospitalizacionSuccess;
              setState(
                () => _hospitalizaciones = loadedState.hospitalizaciones,
              );
              break;
            case const (DashboardServiceError):
              final stateError = state as DashboardServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Dashboard',
                description: stateError.message,
                isError: true,
              );
              break;
            case const (ServerClientError):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Error',
                description: 'En este momento no podemos atender tu solicitud.',
                isWarning: true,
              );
              break;
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      sections: _mascotas.map((mascota) {
                                        final index =
                                            _mascotas.indexOf(mascota);
                                        return PieChartSectionData(
                                          color: _listColors[index],
                                          value:
                                              mascota.idTipoMascota.toDouble(),
                                          title: mascota.nombreMascota,
                                          titleStyle: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _mascotas.map((mascota) {
                                  final index = _mascotas.indexOf(mascota);
                                  return Indicator(
                                    color: _listColors[index],
                                    text: mascota.nombreMascota,
                                    isSquare: true,
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(26.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          sections: _consultas.map((consulta) {
                                            final index =
                                                _consultas.indexOf(consulta);
                                            return PieChartSectionData(
                                              color: _listColors[index],
                                              value: consulta.idconsulta
                                                  .toDouble(),
                                              title: consulta.nombreMascota,
                                              titleStyle: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Consultas",
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          DataTable(
                                            columns: ['Mascota', 'Sintomas']
                                                .map(
                                                  (column) => DataColumn(
                                                    label: Text(column),
                                                  ),
                                                )
                                                .toList(),
                                            rows: _consultas.map((consulta) {
                                              final index =
                                                  _consultas.indexOf(consulta);
                                              return DataRow(
                                                cells: [
                                                  DataCell(
                                                    Indicator(
                                                      color: _listColors[index],
                                                      text: consulta
                                                          .nombreMascota,
                                                      isSquare: true,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(consulta.sintomas),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(26.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          sections: _groomings.map((grooming) {
                                            final index =
                                                _groomings.indexOf(grooming);
                                            return PieChartSectionData(
                                              color: _listColors[index],
                                              value: grooming.idcita.toDouble(),
                                              title: grooming.nombreMascota,
                                              titleStyle: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Grooming",
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          DataTable(
                                            columns: ['Mascota', 'motivo']
                                                .map(
                                                  (column) => DataColumn(
                                                    label: Text(column),
                                                  ),
                                                )
                                                .toList(),
                                            rows: _groomings.map((grooming) {
                                              final index =
                                                  _groomings.indexOf(grooming);
                                              return DataRow(
                                                cells: [
                                                  DataCell(
                                                    Indicator(
                                                      color: _listColors[index],
                                                      text: grooming
                                                          .nombreMascota,
                                                      isSquare: true,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(grooming.motivo),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(26.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          sections: _hospitalizaciones
                                              .map((hospitalizacion) {
                                            final index = _hospitalizaciones
                                                .indexOf(hospitalizacion);
                                            return PieChartSectionData(
                                              color: _listColors[index],
                                              value: hospitalizacion
                                                  .idhospitalizacion
                                                  .toDouble(),
                                              title:
                                                  hospitalizacion.nombreMascota,
                                              titleStyle: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Hospitalizacion",
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          DataTable(
                                            columns: ['Mascota', 'motivo']
                                                .map(
                                                  (column) => DataColumn(
                                                    label: Text(column),
                                                  ),
                                                )
                                                .toList(),
                                            rows: _hospitalizaciones
                                                .map((hospitalizacion) {
                                              final index = _hospitalizaciones
                                                  .indexOf(hospitalizacion);
                                              return DataRow(
                                                cells: [
                                                  DataCell(
                                                    Indicator(
                                                      color: _listColors[index],
                                                      text: hospitalizacion
                                                          .nombreMascota,
                                                      isSquare: true,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                        hospitalizacion.motivo),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<DashboardBloc, BaseState>(
              builder: (context, state) {
                if (state is DashboardInProgress) {
                  return const Loader();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _getDashboards() {
    context.read<DashboardBloc>()
      ..add(
        ConsultaShown(),
      )
      ..add(
        GroomingShown(),
      )
      ..add(
        MascotaShown(),
      )
      ..add(
        HospitalizacionShown(),
      );
  }
}
