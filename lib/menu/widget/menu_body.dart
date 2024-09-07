import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/menu/bloc/menu_bloc.dart';
import 'package:paraiso_canino/menu/model/menu_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({super.key});

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ordenMenu = TextEditingController();
  final TextEditingController _searchMenu = TextEditingController();

  late List<MenuModel> menuList;

  late bool _isEdit;
  late int _menuId;

  @override
  void initState() {
    _isEdit = false;
    menuList = [];
    _getMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _formDrawer(),
      backgroundColor: fillInputSelect,
      body: BlocListener<MenuBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (MenuListSuccess):
              final loadedState = state as MenuListSuccess;
              setState(() => menuList = loadedState.menuList);
              break;
            case const (MenuCreatedSuccess):
              _getMenuList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Menu',
                description: 'Menu creado',
              );
              break;
            case const (MenuEditedSuccess):
              _getMenuList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Menu',
                description: 'Menu editado',
              );
              break;
            case const (MenuDeletedSuccess):
              _getMenuList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Menu',
                description: 'Menu eliminado',
              );
              break;
            case const (MenuServiceError):
              final stateError = state as MenuServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Menu',
                description: stateError.message,
                isError: true,
              );
              break;
            case const (ServerClientError):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Error',
                description: 'En este momento no podemos atender tu solicitud.',
                isError: true,
              );
              break;
          }
        },
        child: Stack(
          children: [
            CustomTable(
              searchController: _searchMenu,
              onChangeSearchButton: () => _getMenuList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _ordenMenu.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              pageTitle: 'Menu',
              headers: const [
                'id Menu',
                'Nombre',
                'Orden Menu',
                'Fecha de creacion',
                'Fecha de modificacion',
                'Usuario creacion',
                'Usuario modificacion',
                '',
              ],
              rows: menuList.map<Widget>((menuItem) {
                final index = menuList.indexOf(menuItem);
                return MouseRegion(
                  onEnter: (event) => setState(() => menuItem.isHover = true),
                  onExit: (event) => setState(() => menuItem.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: menuItem.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${menuItem.idmenu}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(menuItem.name),
                        ),
                        Expanded(
                          child: Text(
                            '${menuItem.ordenmenu}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(menuItem.fechacreacion),
                        ),
                        Expanded(
                          child: Text(menuItem.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(menuItem.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(menuItem.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteMenu(
                                id: menuItem.idmenu,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = menuItem.name;
                                _ordenMenu.text = menuItem.ordenmenu.toString();
                                _menuId = menuItem.idmenu;
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
            BlocBuilder<MenuBloc, BaseState>(
              builder: (context, state) {
                if (state is MenuInProgress) {
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

  Widget _formDrawer() {
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
                _isEdit ? 'Editar Menu' : 'Nuevo Menu',
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
                labelText: 'Orden menú',
                controller: _ordenMenu,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editMenu(id: _menuId);
                    } else {
                      _createeMenu();
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
      menuList = menuList
          .where(
            (element) => element.name.toLowerCase().contains(
                  _searchMenu.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getMenuList() {
    context.read<MenuBloc>().add(
          MenuListShown(),
        );
  }

  void _createeMenu() {
    context.read<MenuBloc>().add(
          MenuSaved(
            name: _name.text,
            orderMenu: int.parse(_ordenMenu.text),
          ),
        );
  }

  void _deleteMenu({required int id}) {
    context.read<MenuBloc>().add(
          MenuDeleted(
            menuID: id,
          ),
        );
  }

  void _editMenu({required int id}) {
    context.read<MenuBloc>().add(
          MenuEdited(
            id: id,
            name: _name.text,
            orderMenu: int.parse(_ordenMenu.text),
          ),
        );
  }
}
