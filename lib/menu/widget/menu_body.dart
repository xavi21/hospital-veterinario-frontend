import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
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
  final TextEditingController _searchMenu = TextEditingController();
  List<MenuModel> menuList = [];

  @override
  void initState() {
    _getMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<MenuBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (MenuListSuccess):
              final loadedState = state as MenuListSuccess;
              setState(() => menuList = loadedState.menuList);
              break;
            case const (MenuServiceError):
              final stateError = state as MenuServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
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
              headers: const [
                'id Menu',
                'Nombre',
                'Orden Menu',
                'Fecha de creacion',
                'Fecha de modificacion',
                'Usuario creacion',
                'Usuario modificacion',
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
                      ],
                    ),
                  ),
                );
              }).toList(),
              onTapSearchButton: () {},
              onTapAddButton: () {},
              pageTitle: 'Menu',
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

  void _getMenuList() {
    context.read<MenuBloc>().add(
          MenuListShown(),
        );
  }
}
