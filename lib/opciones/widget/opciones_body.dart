import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/opciones/bloc/bloc/opciones_bloc.dart';
import 'package:paraiso_canino/opciones/model/opciones_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class OpcionesBody extends StatefulWidget {
  const OpcionesBody({super.key});

  @override
  State<OpcionesBody> createState() => _OpcionesBodyState();
}

class _OpcionesBodyState extends State<OpcionesBody> {
  final TextEditingController _searchOptions = TextEditingController();
  late List<OpcionesListModel> optionList;

  @override
  void initState() {
    optionList = [];
    _getOptionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<OpcionesBloc, BaseState>(
        listener: (context, state) {
          if (state is OpcionesListSuccess) {
            setState(() {
              optionList = state.optionList;
            });
          }
        },
        child: Stack(
          children: [
            CustomTable(
              pageTitle: 'Opciones',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getOptionList(),
              onTapSearchButton: () {
                setState(() {
                  optionList = optionList
                      .where(
                        (element) => element.name.toLowerCase().contains(
                              _searchOptions.text.toLowerCase(),
                            ),
                      )
                      .toList();
                });
              },
              headers: const [
                'Opcion ID',
                'Nombre',
                'Página',
                'Orden del Menu',
                'Fecha creacion',
                'Fecha modificacion',
                'Usuario creacion',
                'Usuario modificacion',
                '',
              ],
              rows: optionList.map<Widget>((option) {
                final index = optionList.indexOf(option);
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
                          child: Text(option.name),
                        ),
                        Expanded(
                          child: Text(option.pagina),
                        ),
                        Expanded(
                          child: Text('${option.ordenmenu}'),
                        ),
                        Expanded(
                          child: Text(option.fechacreacion),
                        ),
                        Expanded(
                          child: Text(option.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(option.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(option.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {},
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: TableRowActions.see,
                                child: Text('Ver'),
                              ),
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
            BlocBuilder<OpcionesBloc, BaseState>(
              builder: (context, state) {
                if (state is OpcionesInProgress) {
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
    context.read<OpcionesBloc>().add(
          OptionsShown(),
        );
  }
}
