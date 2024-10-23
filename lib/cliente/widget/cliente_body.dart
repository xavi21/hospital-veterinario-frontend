import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cliente/bloc/cliente_bloc.dart';
import 'package:paraiso_canino/cliente/model/cliente_response.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';

class ClienteBody extends StatefulWidget {
  const ClienteBody({super.key});

  @override
  State<ClienteBody> createState() => _ClienteBodyState();
}

class _ClienteBodyState extends State<ClienteBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _idpersona = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _fechanacimiento = TextEditingController();
  final TextEditingController _idGenero = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correoelectronico = TextEditingController();
  final TextEditingController _idEstadoCivil = TextEditingController();
  final TextEditingController _searchCliente = TextEditingController();

  late List<ClienteListModel> clientes;

  late bool _isEdit;
  late int _clienteId;

  @override
  void initState() {
    _isEdit = false;
    clientes = [];
    _getClienteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _personaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<ClienteBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ClienteSuccess):
              final loadedState = state as ClienteSuccess;
              setState(() => clientes = loadedState.clientes);
              break;
            case const (ClienteCreatedSuccess):
              _getClienteList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
                description: 'Cliente creado correctamente',
              );
              break;
            case const (ClienteEditedSuccess):
              _getClienteList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
                description: 'Cliente editado correctamente',
              );
              break;
            case const (ClienteDeletedSuccess):
              _getClienteList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
                description: 'Cliente borrado',
              );
              break;
            case const (ClienteError):
              final stateError = state as ClienteError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
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
              pageTitle: 'Clientes',
              searchController: _searchCliente,
              onChangeSearchButton: () => _getClienteList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _idpersona.clear();
                  _nombre.clear();
                  _apellido.clear();
                  _fechanacimiento.clear();
                  _idGenero.clear();
                  _direccion.clear();
                  _telefono.clear();
                  _correoelectronico.clear();
                  _idEstadoCivil.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID',
                'Nombre',
                'Apellido',
                'Telefono',
                'Dirección',
                'Correo electrónico',
                'Estado Civil',
                'Género',
                '',
              ],
              rows: clientes.map<Widget>((cliente) {
                final index = clientes.indexOf(cliente);
                return MouseRegion(
                  onEnter: (event) => setState(() => cliente.isHover = true),
                  onExit: (event) => setState(() => cliente.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: cliente.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${cliente.idpersona}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cliente.nombre,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(cliente.apellido),
                        ),
                        Expanded(
                          child: Text(cliente.telefono),
                        ),
                        Expanded(
                          child: Text(
                            cliente.direccion,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cliente.correoelectronico,
                          ),
                        ),
                        Expanded(
                          child: Text(cliente.nombreEstadoCivil),
                        ),
                        Expanded(
                          child: Text(cliente.nombreGenero),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteCliente(
                                id: cliente.idpersona,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _isEdit = false;
                                _idpersona.text = cliente.idpersona.toString();
                                _nombre.text = cliente.nombre;
                                _apellido.text = cliente.apellido;
                                _fechanacimiento.text = cliente.fechanacimiento;
                                _idGenero.text = cliente.idGenero.toString();
                                _direccion.text = cliente.direccion;
                                _telefono.text = cliente.telefono;
                                _correoelectronico.text =
                                    cliente.correoelectronico;
                                _idEstadoCivil.text =
                                    cliente.idEstadoCivil.toString();
                                _clienteId = cliente.idpersona;
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
            BlocBuilder<ClienteBloc, BaseState>(
              builder: (context, state) {
                if (state is ClienteInProgress) {
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

  Widget _personaForm() {
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
                _isEdit ? 'Editar Persona' : 'Nueva Persona',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Nombre',
                controller: _nombre,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Apellido',
                controller: _apellido,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Fecha de nacimiento',
                controller: _fechanacimiento,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Genero',
                controller: _idGenero,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Direccion',
                controller: _direccion,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Telefono',
                controller: _telefono,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Correo Electronico',
                controller: _correoelectronico,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Estado Civil',
                controller: _idEstadoCivil,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editCliente(id: _clienteId);
                    } else {
                      _saveNewCliente();
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
      clientes = clientes
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchCliente.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _saveNewCliente() {
    context.read<ClienteBloc>().add(
          ClienteSaved(
            nombre: _nombre.text,
            apellido: _apellido.text,
            fechaNacimiento: _fechanacimiento.text,
            idGenero: int.parse(_idGenero.text),
            direccion: _direccion.text,
            telefono: _telefono.text,
            correoElectronico: _correoelectronico.text,
            idEstadoCivil: int.parse(_idEstadoCivil.text),
          ),
        );
  }

  void _editCliente({required int id}) {
    context.read<ClienteBloc>().add(
          ClienteEdited(
            fechacreacion: '${DateTime.now()}',
            usuariocreacion: '',
            fechamodificacion: '${DateTime.now()}',
            usuariomodificacion: '',
            idpersona: int.parse(_idpersona.text),
            nombre: _nombre.text,
            apellido: _apellido.text,
            fechanacimiento: _fechanacimiento.text,
            idGenero: int.parse(_idGenero.text),
            direccion: _direccion.text,
            telefono: _telefono.text,
            correoelectronico: _correoelectronico.text,
            idEstadoCivil: int.parse(_idEstadoCivil.text),
          ),
        );
  }

  void _deleteCliente({required int id}) {
    context.read<ClienteBloc>().add(
          ClienteDeleted(
            clienteID: id,
          ),
        );
  }

  void _getClienteList() {
    context.read<ClienteBloc>().add(
          ClienteShown(),
        );
  }
}
