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
import 'package:paraiso_canino/usuario/bloc/usuario_bloc.dart';
import 'package:paraiso_canino/usuario/model/usuario_list_model.dart';

class UsuarioBody extends StatefulWidget {
  const UsuarioBody({super.key});

  @override
  State<UsuarioBody> createState() => _UsuarioBodyState();
}

class _UsuarioBodyState extends State<UsuarioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchUsuarios = TextEditingController();

  late List<UsuarioListModel> usuarios;

  late bool _isEdit;

  @override
  void initState() {
    _isEdit = false;
    usuarios = [];
    _getUsuarioList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _personaForm(),
      backgroundColor: fillInputSelect,
      body: Center(
        child: BlocListener<UsuarioBloc, BaseState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case const (UsuarioSuccess):
                final loadedState = state as UsuarioSuccess;
                setState(() => usuarios = loadedState.usuarios);
                break;
              case const (UsuarioError):
                final stateError = state as UsuarioError;
                CustomStateDialog.showAlertDialog(
                  context,
                  title: 'Usuarios',
                  description: stateError.message,
                  isError: true,
                );
                break;
              case const (ServerClientError):
                CustomStateDialog.showAlertDialog(
                  context,
                  title: 'Error',
                  description:
                      'En este momento no podemos atender tu solicitud.',
                  isWarning: true,
                );
                break;
            }
          },
          child: Stack(
            children: [
              CustomTable(
                pageTitle: 'Usuarios',
                searchController: _searchUsuarios,
                onChangeSearchButton: () => _getUsuarioList(),
                onTapSearchButton: () => _filterTable(),
                onTapAddButton: () {
                  setState(() {
                    _name.clear();
                  });
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                headers: const [
                  'ID',
                  'Usuario',
                  'Sucursal',
                  'Password',
                  'Status',
                  'Intentos de acceso',
                  '',
                ],
                rows: usuarios.map<Widget>((usuario) {
                  final index = usuarios.indexOf(usuario);
                  return MouseRegion(
                    onEnter: (event) => setState(() => usuario.isHover = true),
                    onExit: (event) => setState(() => usuario.isHover = false),
                    child: Container(
                      height: 60.0,
                      color: usuario.isHover
                          ? blue.withOpacity(0.1)
                          : index % 2 == 0
                              ? fillInputSelect
                              : white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${usuario.idsucursal}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(usuario.idusuario),
                          ),
                          Expanded(
                            child: Text(usuario.sucursal),
                          ),
                          Expanded(
                            child: Text(usuario.password),
                          ),
                          Expanded(
                            child: Text(usuario.statusUsuario),
                          ),
                          Expanded(
                            child: Text('${usuario.intentosdeacceso}'),
                          ),
                          PopupMenuButton(
                            color: white,
                            onSelected: (value) {
                              if (value == TableRowActions.delete) {
                                // _deleteUsuario(
                                //   id: usuario.idsucursal,
                                // );
                              }
                              if (value == TableRowActions.edit) {
                                setState(() {
                                  _isEdit = true;
                                  _name.text = usuario.idusuario;
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
              BlocBuilder<UsuarioBloc, BaseState>(
                builder: (context, state) {
                  if (state is UsuarioInProgress) {
                    return const Loader();
                  }
                  return Container();
                },
              ),
            ],
          ),
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
                _isEdit ? 'Editar Usuario' : 'Nueva Usuario',
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
                      // _editUsuario(id: _personaId);
                    } else {
                      // _saveNewUsuario();
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
      usuarios = usuarios
          .where(
            (element) => element.idusuario.toLowerCase().contains(
                  _searchUsuarios.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getUsuarioList() {
    context.read<UsuarioBloc>().add(
          UsuarioShown(),
        );
  }
}
