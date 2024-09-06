import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
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
  final TextEditingController _searchUserOption = TextEditingController();

  List<OpcionUsuarioModel> opcionUsuarioList = [];

  @override
  void initState() {
    _getOptionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<OpcionUsuarioBloc, BaseState>(
        listener: (context, state) {
          if (state is OpcionUsuarioListSuccess) {
            setState(() {
              opcionUsuarioList = state.opcionesList;
            });
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
              searchController: _searchUserOption,
              headers: const [
                'iD Opción',
                'nombre de opción',
                'iD Menú',
                'Nombre de menú',
                'iD Usuario',
                'Permisos de alta',
                'Permisos de baja',
                'Permisos de edición',
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
                      ],
                    ),
                  ),
                );
              }).toList(),
              onTapSearchButton: () {},
              onTapAddButton: () {},
              pageTitle: 'Opción de usuario',
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

  void _getOptionList() {
    context.read<OpcionUsuarioBloc>().add(
          UserOptionsShown(),
        );
  }
}
