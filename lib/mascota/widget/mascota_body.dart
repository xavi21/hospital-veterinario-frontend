import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/mascota/bloc/mascota_bloc.dart';
import 'package:paraiso_canino/mascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class MascotaBody extends StatefulWidget {
  const MascotaBody({super.key});

  @override
  State<MascotaBody> createState() => _MascotaBodyState();
}

class _MascotaBodyState extends State<MascotaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchMascotas = TextEditingController();

  late List<MascotaListModel> mascotas;

  late bool _isEdit;
  late int _mascotaId;

  @override
  void initState() {
    _isEdit = false;
    mascotas = [];
    super.initState();
    _getMascotasList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<MascotaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (MascotaSuccess):
              final loadedState = state as MascotaSuccess;
              setState(() => mascotas = loadedState.mascotas);
              break;
            case const (MascotaCreatedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'mascotas',
                description: 'Mascota creada',
              );
              break;
            case const (MascotaEditedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'mascotas',
                description: 'Mascota editada',
              );
              break;
            case const (MascotaDeletedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'mascotas',
                description: 'Mascota borrada',
              );
              break;
            case const (MascotaError):
              final stateError = state as MascotaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'mascotas',
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
              pageTitle: 'Mascotas',
              searchController: _searchMascotas,
              onChangeSearchButton: () => _getMascotasList(),
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
                'Nombre Mascota',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: mascotas.map<Widget>((mascota) {
                final index = mascotas.indexOf(mascota);
                return MouseRegion(
                  onEnter: (event) => setState(() => mascota.isHover = true),
                  onExit: (event) => setState(() => mascota.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: mascota.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${mascota.idTipoMascota}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(mascota.nombre),
                        ),
                        Expanded(
                          child: Text(mascota.fechacreacion),
                        ),
                        Expanded(
                          child: Text(mascota.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(mascota.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(mascota.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteMascota(
                                id: mascota.idTipoMascota,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = mascota.nombre;
                                _mascotaId = mascota.idTipoMascota;
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
            BlocBuilder<MascotaBloc, BaseState>(
              builder: (context, state) {
                if (state is MascotaInProgress) {
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
                _isEdit ? 'Editar Mascota' : 'Nueva Mascota',
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
                      _editMascota(id: _mascotaId);
                    } else {
                      _saveNewMascota();
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
      mascotas = mascotas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchMascotas.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getMascotasList() {
    context.read<MascotaBloc>().add(
          MascotaShown(),
        );
  }

  void _saveNewMascota() {
    context.read<MascotaBloc>().add(
          MascotaSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteMascota({required int id}) {
    context.read<MascotaBloc>().add(
          MascotaDeleted(
            mascotaId: id,
          ),
        );
  }

  void _editMascota({required int id}) {
    context.read<MascotaBloc>().add(
          MascotaEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
