import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/consulta/bloc/consulta_bloc.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/detalle_consulta/detalle_consulta_page.dart';
import 'package:paraiso_canino/resources/colors.dart';

class ConsultaBody extends StatefulWidget {
  const ConsultaBody({super.key});

  @override
  State<ConsultaBody> createState() => _ConsultaBodyState();
}

class _ConsultaBodyState extends State<ConsultaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchConsulta = TextEditingController();

  late List<ConsultaListModel> consultas;

  @override
  void initState() {
    consultas = [];
    super.initState();
    _getConsultaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      body: BlocListener<ConsultaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ConsultaSuccess):
              final loadedState = state as ConsultaSuccess;
              setState(() => consultas = loadedState.consultas);
              break;
            case const (ConsultaDeletedSuccess):
              _getConsultaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta borrada',
              );
              break;
            case const (ConsultaError):
              final stateError = state as ConsultaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
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
            CustomTable(
              pageTitle: 'Consultas',
              searchController: _searchConsulta,
              onChangeSearchButton: () => _getConsultaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetalleConsultaPage(),
                  ),
                );
              },
              headers: const [
                'ID Cita',
                'ID Consulta',
                'Nombre mascota',
                'Motivo',
                'ID Empleado',
                'Empleado',
                'Sintomas',
                'Diagnostico',
                '',
              ],
              rows: consultas.map<Widget>((consulta) {
                final index = consultas.indexOf(consulta);
                return MouseRegion(
                  onEnter: (event) => setState(() => consulta.isHover = true),
                  onExit: (event) => setState(() => consulta.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: consulta.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${consulta.idcita}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${consulta.idconsulta}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(consulta.nombreMascota),
                        ),
                        Expanded(
                          child: Text(consulta.motivo),
                        ),
                        Expanded(
                          child: Text(
                            '${consulta.idempleado}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${consulta.nombreEmpleado} ${consulta.apellidoEmpleado}',
                          ),
                        ),
                        Expanded(
                          child: Text(consulta.sintomas),
                        ),
                        Expanded(
                          child: Text(consulta.diagnostico),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetalleConsultaPage(
                                    arguments: consulta,
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: TableRowActions.edit,
                                child: Text('Editar'),
                              ),
                            ];
                          },
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            BlocBuilder<ConsultaBloc, BaseState>(
              builder: (context, state) {
                if (state is ConsultaInProgress) {
                  return const Loader();
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  void _filterTable() {
    setState(() {
      consultas = consultas
          .where(
            (element) => element.nombreEmpleado.toLowerCase().contains(
                  _searchConsulta.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getConsultaList() {
    context.read<ConsultaBloc>().add(
          ConsultaShown(),
        );
  }
}
