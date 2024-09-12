import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/statusEmpleado/bloc/statusempleado_bloc.dart';
import 'package:paraiso_canino/statusEmpleado/model/status_empleado_response.dart';

class StatusEmpleadoBody extends StatefulWidget {
  const StatusEmpleadoBody({super.key});

  @override
  State<StatusEmpleadoBody> createState() => _StatusEmpleadoBodyState();
}

class _StatusEmpleadoBodyState extends State<StatusEmpleadoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchEmployeeStatus = TextEditingController();

  late List<StatusEmpleadoListModel> userStatusList;

  late bool _isEdit;
  late int _userStatusId;

  @override
  void initState() {
    _isEdit = false;
    userStatusList = [];
    super.initState();
    _getStatusEmpleadoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _statusForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<StatusEmpleadoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (StatusEmpleadoSuccess):
              final loadedState = state as StatusEmpleadoSuccess;
              setState(() => userStatusList = loadedState.statusEmpleados);
              break;
            case const (StatusEmpleadoCreatedSuccess):
              _getStatusEmpleadoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusEmpleados',
                description: 'StatusEmpleado creada',
              );
              break;
            case const (StatusEmpleadoEditedSuccess):
              _getStatusEmpleadoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusEmpleados',
                description: 'StatusEmpleado editada',
              );
              break;
            case const (StatusEmpleadoDeletedSuccess):
              _getStatusEmpleadoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusEmpleados',
                description: 'StatusEmpleado borrada',
              );
              break;
            case const (StatusEmpleadoError):
              final stateError = state as StatusEmpleadoError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusEmpleados',
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
              pageTitle: 'Status Empleados',
              searchController: _searchEmployeeStatus,
              onChangeSearchButton: () => _getStatusEmpleadoList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre StatusEmpleado',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: userStatusList.map<Widget>((status) {
                final index = userStatusList.indexOf(status);
                return MouseRegion(
                  onEnter: (event) => setState(() => status.isHover = true),
                  onExit: (event) => setState(() => status.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: status.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${status.idStatusEmpleado}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(status.name),
                        ),
                        Expanded(
                          child: Text(status.fechacreacion),
                        ),
                        Expanded(
                          child: Text(status.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(status.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(status.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteStatusEmpleado(
                                id: status.idStatusEmpleado,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = status.name;
                                _userStatusId = status.idStatusEmpleado;
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
                              PopupMenuItem(
                                value: TableRowActions.delete,
                                child: Text('Eliminar'),
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
            BlocBuilder<StatusEmpleadoBloc, BaseState>(
              builder: (context, state) {
                if (state is StatusEmpleadoInProgress) {
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

  Widget _statusForm() {
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
                _isEdit ? 'Editar StatusEmpleado' : 'Nueva StatusEmpleado',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Nombre',
                controller: _name,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editStatusEmpleado(id: _userStatusId);
                    } else {
                      _saveNewStatusEmpleado();
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
      userStatusList = userStatusList
          .where(
            (element) => element.name.toLowerCase().contains(
                  _searchEmployeeStatus.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getStatusEmpleadoList() {
    context.read<StatusEmpleadoBloc>().add(
          StatusEmpleadoShown(),
        );
  }

  void _saveNewStatusEmpleado() {
    context.read<StatusEmpleadoBloc>().add(
          StatusEmpleadoSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteStatusEmpleado({required int id}) {
    context.read<StatusEmpleadoBloc>().add(
          StatusEmpleadoDeleted(
            statusEmpleadoID: id,
          ),
        );
  }

  void _editStatusEmpleado({required int id}) {
    context.read<StatusEmpleadoBloc>().add(
          StatusEmpleadoEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
