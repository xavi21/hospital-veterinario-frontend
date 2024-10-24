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

  double _totalGooming = 0;
  double _totalConsultas = 0;
  double _totalHospitalizaciones = 0;

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
              setState(() {
                _consultas = loadedState.consultas;
                _totalConsultas = loadedState.consultas.length.toDouble();
              });
              break;
            case const (DashboardGroomingSuccess):
              final loadedState = state as DashboardGroomingSuccess;
              setState(() {
                _groomings = loadedState.groomings;
                _totalGooming = loadedState.groomings.length.toDouble();
              });
              break;
            case const (DashboardMascotaSuccess):
              final loadedState = state as DashboardMascotaSuccess;
              setState(() => _mascotas = loadedState.mascotas);
              break;
            case const (DashboardHospitalizacionSuccess):
              final loadedState = state as DashboardHospitalizacionSuccess;
              setState(
                () {
                  _hospitalizaciones = loadedState.hospitalizaciones;
                  _totalHospitalizaciones =
                      loadedState.hospitalizaciones.length.toDouble();
                },
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
                                      sections: [
                                        PieChartSectionData(
                                          color: getColorForChart(0),
                                          value: _totalGooming,
                                          title: '$_totalGooming%',
                                          titleStyle: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        PieChartSectionData(
                                          color: getColorForChart(1),
                                          value: _totalConsultas,
                                          title: '$_totalConsultas%',
                                          titleStyle: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        PieChartSectionData(
                                          color: getColorForChart(2),
                                          value: _totalHospitalizaciones,
                                          title: '$_totalHospitalizaciones%',
                                          titleStyle: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                                children: [
                                  Indicator(
                                    color: getColorForChart(0),
                                    text: 'Groomings',
                                    isSquare: true,
                                  ),
                                  Indicator(
                                    color: getColorForChart(1),
                                    text: 'Consultas',
                                    isSquare: true,
                                  ),
                                  Indicator(
                                    color: getColorForChart(2),
                                    text: 'Hospitalizaciones',
                                    isSquare: true,
                                  )
                                ],
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: getColorForChart(1),
                                          width: 40,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$_totalConsultas',
                                            style:
                                                const TextStyle(fontSize: 40),
                                          ),
                                          const Text(
                                            "TOTAL",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ],
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
                                                      color: getColorForChart(
                                                          index),
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: getColorForChart(0),
                                          width: 40,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$_totalGooming',
                                            style:
                                                const TextStyle(fontSize: 40),
                                          ),
                                          const Text(
                                            "TOTAL",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ],
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
                                                      color: getColorForChart(
                                                          index),
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: getColorForChart(2),
                                          width: 40,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$_totalHospitalizaciones',
                                            style:
                                                const TextStyle(fontSize: 40),
                                          ),
                                          const Text(
                                            "TOTAL",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ],
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
                                                      color: getColorForChart(
                                                          index),
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

  Color getColorForChart(int index) {
    int colorIndex = index % _listColors.length;
    return _listColors[colorIndex];
  }
}
