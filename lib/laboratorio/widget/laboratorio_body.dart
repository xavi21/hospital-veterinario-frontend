import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/laboratorio/bloc/laboratorio_bloc.dart';
import 'package:paraiso_canino/laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class LaboratorioBody extends StatefulWidget {
  const LaboratorioBody({super.key});

  @override
  State<LaboratorioBody> createState() => _LaboratorioBodyState();
}

class _LaboratorioBodyState extends State<LaboratorioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<LaboratorioListModel> laboratorios;

  late bool _isEdit;
  late int _laboratorioId;

  @override
  void initState() {
    _isEdit = false;
    laboratorios = [];
    super.initState();
    _getLaboratoriosList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<LaboratorioBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (LaboratorioSuccess):
              final loadedState = state as LaboratorioSuccess;
              setState(() => laboratorios = loadedState.laboratorios);
              break;
            case const (LaboratorioCreatedSuccess):
              _getLaboratoriosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Laboratorios',
                description: 'Laboratorio creado',
              );
              break;
            case const (LaboratorioEditedSuccess):
              _getLaboratoriosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Laboratorios',
                description: 'Laboratorio editado',
              );
              break;
            case const (LaboratorioDeletedSuccess):
              _getLaboratoriosList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Laboratorios',
                description: 'Laboratorio borrado',
              );
              break;
            case const (LaboratorioError):
              final stateError = state as LaboratorioError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'laboratorios',
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
              pageTitle: 'Laboratorios',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getLaboratoriosList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _descripcion.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre Laboratorio',
                'Descripcion',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: laboratorios.map<Widget>((laboratorio) {
                final index = laboratorios.indexOf(laboratorio);
                return MouseRegion(
                  onEnter: (event) =>
                      setState(() => laboratorio.isHover = true),
                  onExit: (event) =>
                      setState(() => laboratorio.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: laboratorio.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${laboratorio.idLaboratorio}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(laboratorio.nombre),
                        ),
                        Expanded(
                          child: Text(laboratorio.descripcion),
                        ),
                        Expanded(
                          child: Text(laboratorio.fechacreacion),
                        ),
                        Expanded(
                          child: Text(laboratorio.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(laboratorio.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(laboratorio.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteLaboratorio(
                                id: laboratorio.idLaboratorio,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = laboratorio.nombre;
                                _descripcion.text = laboratorio.descripcion;
                                _laboratorioId = laboratorio.idLaboratorio;
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
            BlocBuilder<LaboratorioBloc, BaseState>(
              builder: (context, state) {
                if (state is LaboratorioInProgress) {
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
                _isEdit ? 'Editar Laboratorio' : 'Nuevo Laboratorio',
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
                labelText: 'Descripcion',
                controller: _descripcion,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editLaboratorio(id: _laboratorioId);
                    } else {
                      _saveNewLaboratorio();
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
      laboratorios = laboratorios
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getLaboratoriosList() {
    context.read<LaboratorioBloc>().add(
          LaboratorioShown(),
        );
  }

  void _saveNewLaboratorio() {
    context.read<LaboratorioBloc>().add(
          LaboratorioSaved(
            name: _name.text,
            descripcion: _descripcion.text,
          ),
        );
  }

  void _deleteLaboratorio({required int id}) {
    context.read<LaboratorioBloc>().add(
          LaboratorioDeleted(
            laboratorioId: id,
          ),
        );
  }

  void _editLaboratorio({required int id}) {
    context.read<LaboratorioBloc>().add(
          LaboratorioEdited(
            id: id,
            name: _name.text,
            descripcion: _descripcion.text,
          ),
        );
  }
}
