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
import 'package:paraiso_canino/talla/bloc/talla_bloc.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';

class TallaBody extends StatefulWidget {
  const TallaBody({super.key});

  @override
  State<TallaBody> createState() => _TallaBodyState();
}

class _TallaBodyState extends State<TallaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchTalla = TextEditingController();

  late List<TallaListModel> tallas;

  late bool _isEdit;
  late int _tallaId;

  @override
  void initState() {
    _isEdit = false;
    tallas = [];
    super.initState();
    _getTallaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _tallaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<TallaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (TallaSuccess):
              final loadedState = state as TallaSuccess;
              setState(() => tallas = loadedState.tallas);
              break;
            case const (TallaCreatedSuccess):
              _getTallaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tallas',
                description: 'Talla creada',
              );
              break;
            case const (TallaEditedSuccess):
              _getTallaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tallas',
                description: 'Talla editada',
              );
              break;
            case const (TallaDeletedSuccess):
              _getTallaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tallas',
                description: 'Talla borrada',
              );
              break;
            case const (TallaError):
              final stateError = state as TallaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tallas',
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
              pageTitle: 'Tallas',
              searchController: _searchTalla,
              onChangeSearchButton: () => _getTallaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre Talla',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: tallas.map<Widget>((talla) {
                final index = tallas.indexOf(talla);
                return MouseRegion(
                  onEnter: (event) => setState(() => talla.isHover = true),
                  onExit: (event) => setState(() => talla.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: talla.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${talla.idTalla}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(talla.nombre),
                        ),
                        Expanded(
                          child: Text(talla.fechacreacion),
                        ),
                        Expanded(
                          child: Text(talla.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(talla.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(talla.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteTalla(
                                id: talla.idTalla,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = talla.nombre;
                                _tallaId = talla.idTalla;
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
            BlocBuilder<TallaBloc, BaseState>(
              builder: (context, state) {
                if (state is TallaInProgress) {
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

  Widget _tallaForm() {
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
                _isEdit ? 'Editar Talla' : 'Nueva Talla',
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
                      _editTalla(id: _tallaId);
                    } else {
                      _saveNewTalla();
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
      tallas = tallas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchTalla.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getTallaList() {
    context.read<TallaBloc>().add(
          TallaShown(),
        );
  }

  void _saveNewTalla() {
    context.read<TallaBloc>().add(
          TallaSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteTalla({required int id}) {
    context.read<TallaBloc>().add(
          TallaDeleted(
            tallaID: id,
          ),
        );
  }

  void _editTalla({required int id}) {
    context.read<TallaBloc>().add(
          TallaEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
