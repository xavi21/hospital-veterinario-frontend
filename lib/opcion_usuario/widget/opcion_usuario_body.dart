import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/opcion_usuario/bloc/opcion_usuario_bloc.dart';
import 'package:paraiso_canino/opcion_usuario/model/menu_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opciones_list_model.dart';
import 'package:paraiso_canino/repository/user_repository.dart';
import 'package:paraiso_canino/resources/colors.dart';

class OpcionUsuarioBody extends StatefulWidget {
  const OpcionUsuarioBody({super.key});

  @override
  State<OpcionUsuarioBody> createState() => _OpcionUsuarioBodyState();
}

class _OpcionUsuarioBodyState extends State<OpcionUsuarioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _idMenuController = TextEditingController();
  final TextEditingController _idOpcionController = TextEditingController();
  final TextEditingController _searchUserOption = TextEditingController();

  List<OpcionesListModel> _optionsList = [];
  List<MenuModel> _menuList = [];

  bool _alta = false;
  bool _baja = false;
  bool _cambio = false;

  late List<OpcionUsuarioModel> opcionUsuarioList;

  late bool _isEdit;

  late String _idUsuario;
  late String _idOpcion;
  late String _idMenu;

  @override
  void initState() {
    _isEdit = false;
    opcionUsuarioList = [];
    _getOptionList();
    _getInitialLists();
    _getCurrentUser();
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
          if (state is OptionsListSuccess) {
            setState(() {
              _optionsList = state.optionList;
            });
          }
          if (state is MenuListSuccess) {
            setState(() {
              _menuList = state.menuList;
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
                  _idMenuController.clear();
                  _idOpcionController.clear();
                  _alta = false;
                  _baja = false;
                  _cambio = false;
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
                          child: Icon(
                            option.alta == 1
                                ? Icons.check_circle
                                : Icons.close_rounded,
                            color: option.alta == 1 ? Colors.green : Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            option.baja == 1
                                ? Icons.check_circle
                                : Icons.close_rounded,
                            color: option.baja == 1 ? Colors.green : Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            option.cambio == 1
                                ? Icons.check_circle
                                : Icons.close_rounded,
                            color:
                                option.cambio == 1 ? Colors.green : Colors.red,
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
                                _idMenu = option.idmenu.toString();
                                _idOpcion = option.idopcion.toString();
                                _idMenuController.text = option.menuNombre;
                                _idOpcionController.text = option.opcionNombre;
                                _alta = option.alta == 1;
                                _baja = option.baja == 1;
                                _cambio = option.cambio == 1;
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
                _isEdit ? 'Editar Opcion' : 'Nueva Opcion',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInputSelect(
                title: 'Menu',
                hint: 'Selecciona un menu',
                valueItems: _menuList
                    .map<String>((menu) => menu.idmenu.toString())
                    .toList(),
                displayItems: _menuList.map((menu) => menu.name).toList(),
                onSelected: (String? menu) {
                  setState(() {
                    _idMenu = _menuList
                        .firstWhere((val) => val.name == menu!)
                        .idmenu
                        .toString();
                  });
                },
                controller: _idMenuController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Opcion',
                hint: 'Selecciona una opcion',
                valueItems: _optionsList
                    .map<String>((option) => option.idopcion.toString())
                    .toList(),
                displayItems:
                    _optionsList.map((option) => option.name).toList(),
                onSelected: (String? option) {
                  setState(() {
                    _idOpcion = _optionsList
                        .firstWhere((val) => val.name == option!)
                        .idopcion
                        .toString();
                  });
                },
                controller: _idOpcionController,
              ),
              const SizedBox(height: 12.0),
              const Text('Alta'),
              Switch.adaptive(
                value: _alta,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) => setState(() => _alta = value),
              ),
              const SizedBox(height: 12.0),
              const Text('Baja'),
              Switch.adaptive(
                value: _baja,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) => setState(() => _baja = value),
              ),
              const SizedBox(height: 12.0),
              const Text('Cambio'),
              Switch.adaptive(
                value: _cambio,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) => setState(() => _cambio = value),
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

  void _getCurrentUser() async {
    final String currentUser = await UserRepository().getReminderEmail();
    setState(() {
      _idUsuario = currentUser;
    });
  }

  void _getInitialLists() {
    context.read<OpcionUsuarioBloc>()
      ..add(
        OptionsListShown(),
      )
      ..add(
        MenuListShown(),
      );
  }

  void _getOptionList() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionsShown(),
        );
  }

  void _saveNewUserOption() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionSaved(
            idUsuario: _idUsuario,
            idMenu: int.parse(_idMenu),
            idOpcion: int.parse(_idOpcion),
            alta: _alta ? 1 : 0,
            baja: _baja ? 1 : 0,
            cambio: _cambio ? 1 : 0,
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
            idUsuario: _idUsuario,
            idMenu: int.parse(_idMenu),
            idOpcion: int.parse(_idOpcion),
            alta: _alta ? 1 : 0,
            baja: _baja ? 1 : 0,
            cambio: _cambio ? 1 : 0,
          ),
        );
  }
}
