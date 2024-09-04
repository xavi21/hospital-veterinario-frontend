import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _searchOptions = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _orderMenu = TextEditingController();
  final TextEditingController _pagina = TextEditingController();
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
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      drawer: _newOptionForm(),
      body: BlocListener<OpcionesBloc, BaseState>(
        listener: (context, state) {
          if (state is OpcionesListSuccess) {
            setState(() {
              optionList = state.optionList;
            });
          }
          if (state is OpcionesAddNewSuccess) {
            _getOptionList();
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Opcion creada',
              description: state.message,
            );
          }
          if (state is OpcionesServiceError) {
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
              onTapAddButton: () => _scaffoldKey.currentState!.openDrawer(),
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
                          onSelected: (value) {
                            print('$value');
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

  Widget _newOptionForm() {
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
                'Nueva Opción',
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
                labelText: 'Orden',
                controller: _orderMenu,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Página',
                controller: _pagina,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    _saveNewOption();
                  }
                },
                text: 'Guardar',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getOptionList() {
    context.read<OpcionesBloc>().add(
          OptionsShown(),
        );
  }

  void _saveNewOption() {
    context.read<OpcionesBloc>().add(
          OptionAddNew(
            name: _name.text,
            orderMenu: int.parse(_orderMenu.text),
            page: _pagina.text,
          ),
        );
  }
}
