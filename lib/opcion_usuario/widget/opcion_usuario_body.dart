import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/opcion_usuario/bloc/opcion_usuario_bloc.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class OpcionUsuarioBody extends StatefulWidget {
  const OpcionUsuarioBody({super.key});

  @override
  State<OpcionUsuarioBody> createState() => _OpcionUsuarioBodyState();
}

class _OpcionUsuarioBodyState extends State<OpcionUsuarioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _idUsuario = TextEditingController();
  final TextEditingController _idMenu = TextEditingController();
  final TextEditingController _idOpcion = TextEditingController();
  final TextEditingController _alta = TextEditingController();
  final TextEditingController _baja = TextEditingController();
  final TextEditingController _cambio = TextEditingController();
  final TextEditingController _searchUserOption = TextEditingController();

  late List<OpcionUsuarioModel> opcionUsuarioList;

  late bool _isEdit;

  @override
  void initState() {
    _isEdit = false;
    opcionUsuarioList = [];
    _getOptionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<OpcionUsuarioBloc, BaseState>(
        listener: (context, state) {
          if (state is OpcionUsuarioListSuccess) {
            setState(() {
              opcionUsuarioList = state.opcionesList;
            });
          }
          if (state is OpcionUsuarioCreatedSuccess) {
            _getOptionList();
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Opción de usuario',
              description: 'Opcion de usuario creada',
            );
          }
          if (state is OpcionUsuarioEditedSuccess) {
            _getOptionList();

            CustomStateDialog.showAlertDialog(
              context,
              title: 'Opción de usuario',
              description: 'Opcion de usuario editada',
            );
          }
          if (state is OpcionUsuarioDeletedSuccess) {
            _getOptionList();
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Opción de usuario',
              description: 'Opcion de usuario eliminada',
            );
          }
          if (state is OpcionUsuarioServiceError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: state.message,
              isWarning: true,
            );
          }
          if (state is ServerClientError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: 'En este momento no podemos atender tu solicitud.',
              isError: true,
            );
          }
        },
        child: Stack(
          children: [
            CustomTable(
              pageTitle: 'Opción de usuario',
              searchController: _searchUserOption,
              onChangeSearchButton: () => _getOptionList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _idUsuario.clear();
                  _idMenu.clear();
                  _idOpcion.clear();
                  _alta.clear();
                  _baja.clear();
                  _cambio.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD Opción',
                'nombre de opción',
                'iD Menú',
                'Nombre de menú',
                'iD Usuario',
                'Permisos de alta',
                'Permisos de baja',
                'Permisos de edición',
                ''
              ],
              rows: opcionUsuarioList.map<Widget>((option) {
                final index = opcionUsuarioList.indexOf(option);
                return MouseRegion(
                  onEnter: (event) => setState(() => option.isHover = true),
                  onExit: (event) => setState(() => option.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: option.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${option.idopcion}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(option.opcionNombre),
                        ),
                        Expanded(
                          child: Text(
                            '${option.idmenu}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(option.menuNombre),
                        ),
                        Expanded(
                          child: Text(option.idusuario),
                        ),
                        Expanded(
                          child: Text(
                            '${option.alta}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${option.baja}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${option.cambio}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteUserOption(
                                idUsuario: option.idusuario,
                                idMenu: option.idmenu,
                                idOpcion: option.idopcion,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _idUsuario.text = option.idusuario;
                                _idMenu.text = option.idmenu.toString();
                                _idOpcion.text = option.idopcion.toString();
                                _alta.text = option.alta.toString();
                                _baja.text = option.baja.toString();
                                _cambio.text = option.cambio.toString();
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
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            BlocBuilder<OpcionUsuarioBloc, BaseState>(
              builder: (context, state) {
                if (state is OpcionUsuarioInProgress) {
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
                _isEdit ? 'Editar Opcion' : 'Nueva Opcioon',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Id usuario',
                controller: _idUsuario,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Menu',
                controller: _idMenu,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Opción',
                controller: _idOpcion,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Alta',
                controller: _alta,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Baja',
                controller: _baja,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Cambio',
                controller: _cambio,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editUserOption();
                    } else {
                      _saveNewUserOption();
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
      opcionUsuarioList = opcionUsuarioList
          .where(
            (element) => element.menuNombre.toLowerCase().contains(
                  _searchUserOption.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getOptionList() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionsShown(),
        );
  }

  void _saveNewUserOption() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionSaved(
            idUsuario: _idUsuario.text,
            idMenu: int.parse(_idMenu.text),
            idOpcion: int.parse(_idOpcion.text),
            alta: int.parse(_alta.text),
            baja: int.parse(_baja.text),
            cambio: int.parse(_cambio.text),
          ),
        );
  }

  void _deleteUserOption({
    required String idUsuario,
    required int idMenu,
    required int idOpcion,
  }) {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionDeleted(
            idUsuario: idUsuario,
            idMenu: idMenu,
            idOpcion: idOpcion,
          ),
        );
  }

  void _editUserOption() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionEdited(
            idUsuario: _idUsuario.text,
            idMenu: int.parse(_idMenu.text),
            idOpcion: int.parse(_idOpcion.text),
            alta: int.parse(_alta.text),
            baja: int.parse(_baja.text),
            cambio: int.parse(_cambio.text),
          ),
        );
  }
}
