import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/jaula/bloc/jaula_bloc.dart';
import 'package:paraiso_canino/jaula/model/jaula_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class JaulaBody extends StatefulWidget {
  const JaulaBody({super.key});

  @override
  State<JaulaBody> createState() => _JaulaBodyState();
}

class _JaulaBodyState extends State<JaulaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<JaulaListModel> jaulas;

  late bool _isEdit;
  late int _jaulaId;

  @override
  void initState() {
    _isEdit = false;
    jaulas = [];
    super.initState();
    _getJaulaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _jaulaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<JaulaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (JaulaSuccess):
              final loadedState = state as JaulaSuccess;
              setState(() => jaulas = loadedState.jaulas);
              break;
            case const (JaulaCreatedSuccess):
              _getJaulaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Jaulas',
                description: 'Jaula creada',
              );
              break;
            case const (JaulaEditedSuccess):
              _getJaulaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Jaulas',
                description: 'Jaula editada',
              );
              break;
            case const (JaulaDeletedSuccess):
              _getJaulaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Jaulas',
                description: 'Jaula borrada',
              );
              break;
            case const (JaulaError):
              final stateError = state as JaulaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Jaulas',
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
              pageTitle: 'Jaulas',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getJaulaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _description.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Descripcion',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: jaulas.map<Widget>((jaula) {
                final index = jaulas.indexOf(jaula);
                return MouseRegion(
                  onEnter: (event) => setState(() => jaula.isHover = true),
                  onExit: (event) => setState(() => jaula.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: jaula.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${jaula.idJaula}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(jaula.descripcion),
                        ),
                        Expanded(
                          child: Text(jaula.fechacreacion),
                        ),
                        Expanded(
                          child: Text(jaula.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(jaula.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(jaula.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteJaula(
                                id: jaula.idJaula,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _description.text = jaula.descripcion;
                                _jaulaId = jaula.idJaula;
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
            BlocBuilder<JaulaBloc, BaseState>(
              builder: (context, state) {
                if (state is JaulaInProgress) {
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

  Widget _jaulaForm() {
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
                _isEdit ? 'Editar Jaula' : 'Nueva Jaula',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Nombre',
                controller: _description,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editJaula(id: _jaulaId);
                    } else {
                      _saveNewJaula();
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
      jaulas = jaulas
          .where(
            (element) => element.descripcion.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getJaulaList() {
    context.read<JaulaBloc>().add(
          JaulaShown(),
        );
  }

  void _saveNewJaula() {
    context.read<JaulaBloc>().add(
          JaulaSaved(
            descripcion: _description.text,
          ),
        );
  }

  void _deleteJaula({required int id}) {
    context.read<JaulaBloc>().add(
          JaulaDeleted(
            jaulaID: id,
          ),
        );
  }

  void _editJaula({required int id}) {
    context.read<JaulaBloc>().add(
          JaulaEdited(
            idJaula: id,
            descripcion: _description.text,
          ),
        );
  }
}
