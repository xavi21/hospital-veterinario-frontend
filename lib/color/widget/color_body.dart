import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/color/bloc/color_bloc.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';

class ColorBody extends StatefulWidget {
  const ColorBody({super.key});

  @override
  State<ColorBody> createState() => _ColorBodyState();
}

class _ColorBodyState extends State<ColorBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchColors = TextEditingController();

  late List<ColorListModel> colores;

  late bool _isEdit;
  late int _coloresId;

  @override
  void initState() {
    _isEdit = false;
    colores = [];
    super.initState();
    _getColorsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<ColorBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ColorSuccess):
              final loadedState = state as ColorSuccess;
              setState(() => colores = loadedState.colores);
              break;
            case const (ColorCreatedSuccess):
              _getColorsList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Color',
                description: 'Color creado',
              );
              break;
            case const (ColorEditedSuccess):
              _getColorsList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Color',
                description: 'Color editado',
              );
              break;
            case const (ColorDeletedSuccess):
              _getColorsList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Color',
                description: 'Color borrado',
              );
              break;
            case const (ColorError):
              final stateError = state as ColorError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Color',
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
              pageTitle: 'Colores',
              searchController: _searchColors,
              onChangeSearchButton: () => _getColorsList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID',
                'Nombre color',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: colores.map<Widget>((color) {
                final index = colores.indexOf(color);
                return MouseRegion(
                  onEnter: (event) => setState(() => color.isHover = true),
                  onExit: (event) => setState(() => color.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: color.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${color.idColor}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(color.nombre),
                        ),
                        Expanded(
                          child: Text(color.fechacreacion),
                        ),
                        Expanded(
                          child: Text(color.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(color.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(color.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteColor(
                                id: color.idColor,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = color.nombre;
                                _coloresId = color.idColor;
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
            BlocBuilder<ColorBloc, BaseState>(
              builder: (context, state) {
                if (state is ColorInProgress) {
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
                _isEdit ? 'Editar Color' : 'Nueva Color',
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
                      _updateColor(id: _coloresId);
                    } else {
                      _saveNewColor();
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
      colores = colores
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchColors.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getColorsList() {
    context.read<ColorBloc>().add(
          ColorShown(),
        );
  }

  void _saveNewColor() {
    context.read<ColorBloc>().add(
          ColorSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteColor({required int id}) {
    context.read<ColorBloc>().add(
          ColorDeleted(
            colorId: id,
          ),
        );
  }

  void _updateColor({required int id}) {
    context.read<ColorBloc>().add(
          ColorEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
