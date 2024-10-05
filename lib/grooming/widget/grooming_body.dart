import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/grooming/bloc/grooming_bloc.dart';
import 'package:paraiso_canino/grooming/model/cita_list_model.dart';
import 'package:paraiso_canino/grooming/model/empleado_list_model.dart';
import 'package:paraiso_canino/grooming/model/grooming_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class GroomingBody extends StatefulWidget {
  const GroomingBody({super.key});

  @override
  State<GroomingBody> createState() => _GroomingBodyState();
}

class _GroomingBodyState extends State<GroomingBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _searchOptions = TextEditingController();
  final TextEditingController _citaController = TextEditingController();
  final TextEditingController _empleadoController = TextEditingController();

  late List<GroomingListModel> groomings;
  List<CitaModel> _citasList = [];
  List<EmpleadoModel> _empleadosList = [];

  late bool _isEdit;
  late int _groomingId;

  late int _selectedCitaId;
  late int _selectedEmpleadoId;

  @override
  void initState() {
    _isEdit = false;
    groomings = [];
    super.initState();
    _getGroomingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _groomingForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<GroomingBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (GroomingSuccess):
              final loadedState = state as GroomingSuccess;
              setState(() => groomings = loadedState.groomings);
              break;
            case const (GroomingCitaListSuccess):
              final loadedState = state as GroomingCitaListSuccess;
              setState(() => _citasList = loadedState.citas);
              break;
            case const (GroomingEmpleadoListSuccess):
              final loadedState = state as GroomingEmpleadoListSuccess;
              setState(() => _empleadosList = loadedState.empleados);
              break;
            case const (GroomingCreatedSuccess):
              _getGroomingList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Groomings',
                description: 'Grooming creado',
              );
              break;
            case const (GroomingEditedSuccess):
              _getGroomingList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Groomings',
                description: 'Grooming editado',
              );
              break;
            case const (GroomingDeletedSuccess):
              _getGroomingList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Groomings',
                description: 'Grooming borrada',
              );
              break;
            case const (GroomingServiceError):
              final stateError = state as GroomingServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Groomings',
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
              pageTitle: 'Groomings',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getGroomingList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _citaController.clear();
                  _empleadoController.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'Stauts',
                'Mascota',
                'Motivo',
                'Puesto',
                'Encargado',
                '',
              ],
              rows: groomings.map<Widget>((grooming) {
                final index = groomings.indexOf(grooming);
                return MouseRegion(
                  onEnter: (event) => setState(() => grooming.isHover = true),
                  onExit: (event) => setState(() => grooming.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: grooming.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(grooming.nombreStatusCita),
                        ),
                        Expanded(
                          child: Text(grooming.nombreMascota),
                        ),
                        Expanded(
                          child: Text(grooming.motivo),
                        ),
                        Expanded(
                          child: Text(grooming.nombrePuesto),
                        ),
                        Expanded(
                          child: Text(
                            '${grooming.nombreEmpleado} ${grooming.apellidoEmpleado}',
                          ),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _citaController.text = _citasList
                                    .firstWhere((cita) =>
                                        cita.idcita == grooming.idcita)
                                    .motivo;
                                final empleadoVal = _empleadosList.firstWhere(
                                    (empleado) =>
                                        empleado.idempleado ==
                                        grooming.idempleado);
                                _empleadoController.text =
                                    '${empleadoVal.nombreEmpleado} ${empleadoVal.apellidoEmpleado}';
                                // _groomingId = grooming.idGrooming;
                              });
                              _scaffoldKey.currentState!.openEndDrawer();
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
            BlocBuilder<GroomingBloc, BaseState>(
              builder: (context, state) {
                if (state is GroomingInProgress) {
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

  Widget _groomingForm() {
    return Drawer(
      backgroundColor: fillInputSelect,
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _isEdit ? 'Editar Grooming' : 'Nueva Grooming',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInputSelect(
                title: 'Cita',
                hint: 'Selecciona una cita',
                valueItems: _citasList
                    .map<String>((cita) => cita.idcita.toString())
                    .toList(),
                displayItems:
                    _citasList.map<String>((cita) => cita.motivo).toList(),
                onSelected: (String? citaId) {
                  setState(() {
                    _selectedCitaId = _citasList
                        .firstWhere((val) => val.motivo == citaId!)
                        .idcita;
                  });
                },
                controller: _citaController,
              ),
              const SizedBox(
                width: 12.0,
              ),
              CustomInputSelect(
                title: 'Empleado',
                hint: 'Selecciona un empleado',
                valueItems: _empleadosList
                    .map<String>((empleado) => empleado.idpuesto.toString())
                    .toList(),
                displayItems: _empleadosList
                    .map<String>(
                      (empleado) =>
                          '${empleado.nombreEmpleado} ${empleado.apellidoEmpleado}',
                    )
                    .toList(),
                onSelected: (String? empleadoId) {
                  setState(() {
                    _selectedEmpleadoId = _empleadosList
                        .firstWhere(
                          (val) =>
                              '${val.nombreEmpleado} ${val.apellidoEmpleado}' ==
                              empleadoId!,
                        )
                        .idempleado;
                  });
                },
                controller: _empleadoController,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      // _editGrooming(id: _groomingId);
                    } else {
                      _saveNewGrooming();
                    }
                  }
                },
                text: _isEdit ? 'Editar' : 'Guardar',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _filterTable() {
    setState(() {
      groomings = groomings
          .where(
            (element) => element.motivo.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getGroomingList() {
    context.read<GroomingBloc>()
      ..add(
        GroomingShown(),
      )
      ..add(
        CitasListShown(),
      )
      ..add(
        EmpleadosListShown(),
      );
  }

  void _saveNewGrooming() {
    context.read<GroomingBloc>().add(
          GroomingSaved(
            idcita: _selectedCitaId,
            idempleado: _selectedEmpleadoId,
          ),
        );
  }

  void _editGrooming({required int id}) {
    context.read<GroomingBloc>().add(
          GroomingEdited(
            idGrooming: id,
            idcita: _selectedCitaId,
            idempleado: _selectedEmpleadoId,
          ),
        );
  }
}
