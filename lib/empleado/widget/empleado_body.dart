import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/empleado/bloc/empleado_bloc.dart';
import 'package:paraiso_canino/empleado/model/empleado_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class EmpleadoBody extends StatefulWidget {
  const EmpleadoBody({super.key});

  @override
  State<EmpleadoBody> createState() => _EmpleadoBodyState();
}

class _EmpleadoBodyState extends State<EmpleadoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();
  final TextEditingController _contractDate = TextEditingController();
  final TextEditingController _sucursal = TextEditingController();
  final TextEditingController _puesto = TextEditingController();
  final TextEditingController _estadoCivil = TextEditingController();
  final TextEditingController _genero = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<EmpleadoListModel> empleados;

  late bool _isEdit;
  late int _empleadoId;

  @override
  void initState() {
    _isEdit = false;
    empleados = [];
    _getEmpleadosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<EmpleadoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (EmpleadoSuccess):
              final loadedState = state as EmpleadoSuccess;
              setState(() => empleados = loadedState.empleados);
              break;
            case const (EmpleadoCreatedSuccess):
              _getEmpleadosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Empleados',
                description: 'Empleado creado',
              );
              break;
            case const (EmpleadoEditedSuccess):
              _getEmpleadosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Empleados',
                description: 'Empleado editado',
              );
              break;
            case const (EmpleadoDeletedSuccess):
              _getEmpleadosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Empleados',
                description: 'Empleado borrado',
              );
              break;
            case const (EmpleadoError):
              final stateError = state as EmpleadoError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'empleados',
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
              pageTitle: 'Empleados',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getEmpleadosList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _lastName.clear();
                  _birthDate.clear();
                  _contractDate.clear();
                  _sucursal.clear();
                  _puesto.clear();
                  _estadoCivil.clear();
                  _genero.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre',
                'Apellido',
                'Sucursal',
                'Estado',
                'Puesto',
                'Genero',
                'Estado Civil',
                '',
              ],
              rows: empleados.map<Widget>((empleado) {
                final index = empleados.indexOf(empleado);
                return MouseRegion(
                  onEnter: (event) => setState(() => empleado.isHover = true),
                  onExit: (event) => setState(() => empleado.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: empleado.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${empleado.idempleado}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(empleado.nombreEmpleado),
                        ),
                        Expanded(
                          child: Text(empleado.apellidoEmpleado),
                        ),
                        Expanded(
                          child: Text(empleado.nombreSucursal),
                        ),
                        Expanded(
                          child: Text(empleado.nombreEstadoCivil),
                        ),
                        Expanded(
                          child: Text(empleado.nombrePuesto),
                        ),
                        Expanded(
                          child: Text(empleado.nombreGenero),
                        ),
                        Expanded(
                          child: Text(empleado.nombreEstadoCivil),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteEmpleado(
                                id: empleado.idempleado,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _empleadoId = empleado.idempleado;
                                _name.text = empleado.nombreEmpleado;
                                _lastName.text = empleado.apellidoEmpleado;
                                _birthDate.text = empleado.fechanacimiento;
                                _contractDate.text = empleado.fechacontratacion;
                                _sucursal.text = empleado.idsucursal.toString();
                                _puesto.text = empleado.idpuesto.toString();
                                _estadoCivil.text =
                                    empleado.idestadocivil.toString();
                                _genero.text = empleado.idgenero.toString();
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
            BlocBuilder<EmpleadoBloc, BaseState>(
              builder: (context, state) {
                if (state is EmpleadoInProgress) {
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

  Widget _drawerForm() {
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
                _isEdit ? 'Editar Empleado' : 'Nuevo Empleado',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Nombre',
                controller: _name,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Apellido',
                controller: _lastName,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Fecha de nacimiento',
                controller: _birthDate,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Fecha de contrato',
                controller: _lastName,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'ID Sucursal',
                controller: _sucursal,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'ID Estado Civil',
                controller: _estadoCivil,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'ID Puesto',
                controller: _puesto,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'ID Genero',
                controller: _genero,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editEmpleado(id: _empleadoId);
                    } else {
                      _saveNewEmpleado();
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
      empleados = empleados
          .where(
            (element) => element.nombreEmpleado.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getEmpleadosList() {
    context.read<EmpleadoBloc>().add(
          EmpleadoShown(),
        );
  }

  void _saveNewEmpleado() {
    context.read<EmpleadoBloc>().add(
          EmpleadoSaved(
            name: _name.text,
            lastName: _lastName.text,
            birthDate: _birthDate.text,
            contractDate: _contractDate.text,
            idSucursal: int.parse(_sucursal.text),
            idPuesto: int.parse(_puesto.text),
            idEstadoCivil: int.parse(_estadoCivil.text),
            idGenero: int.parse(_genero.text),
            idStatusEmpleado: 1,
          ),
        );
  }

  void _deleteEmpleado({required int id}) {
    context.read<EmpleadoBloc>().add(
          EmpleadoDeleted(
            id: id,
          ),
        );
  }

  void _editEmpleado({required int id}) {
    context.read<EmpleadoBloc>().add(
          EmpleadoEdited(
            id: id,
            name: _name.text,
            lastName: _lastName.text,
            birthDate: _birthDate.text,
            contractDate: _contractDate.text,
            idSucursal: int.parse(_sucursal.text),
            idPuesto: int.parse(_puesto.text),
            idEstadoCivil: int.parse(_estadoCivil.text),
            idGenero: int.parse(_genero.text),
            idStatusEmpleado: 1,
          ),
        );
  }
}
