import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/medicamento/bloc/medicamento_bloc.dart';
import 'package:paraiso_canino/medicamento/model/medicamento_response.dart';
import 'package:paraiso_canino/resources/colors.dart';

class MedicamentoBody extends StatefulWidget {
  const MedicamentoBody({super.key});

  @override
  State<MedicamentoBody> createState() => _MedicamentoBodyState();
}

class _MedicamentoBodyState extends State<MedicamentoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchMedicamento = TextEditingController();

  late List<MedicamentoListModel> medicamentos;

  @override
  void initState() {
    medicamentos = [];
    super.initState();
    _getMedicamentoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      body: BlocListener<MedicamentoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (MedicamentoSuccess):
              final loadedState = state as MedicamentoSuccess;
              setState(() => medicamentos = loadedState.medicamentos);
              break;
            case const (MedicamentoDeletedSuccess):
              _getMedicamentoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
                description: 'Medicamento borrado',
              );
              break;
            case const (MedicamentoError):
              final stateError = state as MedicamentoError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
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
              pageTitle: 'Medicamentos',
              searchController: _searchMedicamento,
              onChangeSearchButton: () => _getMedicamentoList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const DetalleMedicamentoPage(),
                //   ),
                // );
              },
              headers: const [
                'ID medicamento',
                'nombre',
                'Componente principal',
                'nombre comercial',
                'nombre de casa medica',
                'descripcion',
                '',
              ],
              rows: medicamentos.map<Widget>((medicamento) {
                final index = medicamentos.indexOf(medicamento);
                return MouseRegion(
                  onEnter: (event) =>
                      setState(() => medicamento.isHover = true),
                  onExit: (event) =>
                      setState(() => medicamento.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: medicamento.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${medicamento.idmedicamento}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            medicamento.nombre,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(medicamento.nombreComponentePrincipal),
                        ),
                        Expanded(
                          child: Text(medicamento.nombrecomercial),
                        ),
                        Expanded(
                          child: Text(
                            medicamento.nombreCasaMedica,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(medicamento.descripcion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => DetalleMedicamentoPage(
                              //       arguments: medicamento,
                              //     ),
                              //   ),
                              // );
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
            BlocBuilder<MedicamentoBloc, BaseState>(
              builder: (context, state) {
                if (state is MedicamentoInProgress) {
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
      medicamentos = medicamentos
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchMedicamento.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getMedicamentoList() {
    context.read<MedicamentoBloc>().add(
          MedicamentoShown(),
        );
  }
}
