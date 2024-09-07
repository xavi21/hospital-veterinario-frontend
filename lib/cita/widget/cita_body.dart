import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cita/bloc/cita_bloc.dart';
import 'package:paraiso_canino/cita/model/cita_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CitaBody extends StatefulWidget {
  const CitaBody({super.key});

  @override
  State<CitaBody> createState() => _CitaBodyState();
}

class _CitaBodyState extends State<CitaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchCitas = TextEditingController();

  late List<CitaListModel> citas;

  late bool _isEdit;
  late int _ciaId;

  @override
  void initState() {
    _isEdit = false;
    citas = [];
    super.initState();
    _getCitasList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<CitaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (CitaSuccess):
              final loadedState = state as CitaSuccess;
              setState(() => citas = loadedState.citas);
              break;
            case const (CitaCreatedSuccess):
              _getCitasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'citas',
                description: 'Cita creada',
              );
              break;
            case const (CitaEditedSuccess):
              _getCitasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'citas',
                description: 'Cita editada',
              );
              break;
            case const (CitaDeletedSuccess):
              _getCitasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'citas',
                description: 'Cita borrada',
              );
              break;
            case const (CitaError):
              final stateError = state as CitaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'citas',
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
              pageTitle: 'Citas',
              searchController: _searchCitas,
              onChangeSearchButton: () => _getCitasList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'idestatuscita',
                'nombre',
                'fechacreacion',
                'fechamodificacion',
                'usuariocreacion',
                'usuariomodificacion',
                '',
              ],
              rows: citas.map<Widget>((cita) {
                final index = citas.indexOf(cita);
                return MouseRegion(
                  onEnter: (event) => setState(() => cita.isHover = true),
                  onExit: (event) => setState(() => cita.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: cita.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${cita.idestatuscita}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(cita.nombre),
                        ),
                        Expanded(
                          child: Text(cita.fechacreacion),
                        ),
                        Expanded(
                          child: Text(cita.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(cita.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(cita.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteCita(
                                id: cita.idestatuscita,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = cita.nombre;
                                _ciaId = cita.idestatuscita;
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
            BlocBuilder<CitaBloc, BaseState>(
              builder: (context, state) {
                if (state is CitaInProgress) {
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
                _isEdit ? 'Editar Cita' : 'Nueva Cita',
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
                      _updateCita(id: _ciaId);
                    } else {
                      _createNewCita();
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
      citas = citas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchCitas.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getCitasList() {
    context.read<CitaBloc>().add(
          CitaShown(),
        );
  }

  void _createNewCita() {
    context.read<CitaBloc>().add(
          CitaSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteCita({required int id}) {
    context.read<CitaBloc>().add(
          CitaDeleted(
            citaId: id,
          ),
        );
  }

  void _updateCita({required int id}) {
    context.read<CitaBloc>().add(
          CitaEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
