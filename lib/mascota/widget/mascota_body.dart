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
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/mascota/model/tipo_mascota_list_model.dart';

class TipoMascotaBody extends StatefulWidget {
  const TipoMascotaBody({super.key});

  @override
  State<TipoMascotaBody> createState() => _TipoMascotaBodyState();
}

class _TipoMascotaBodyState extends State<TipoMascotaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchMascotas = TextEditingController();

  late List<TipoMascotaListModel> tipoMascotas;

  late bool _isEdit;
  late int? _tipoMascotaId;

  @override
  void initState() {
    _isEdit = false;
    tipoMascotas = [];
    _tipoMascotaId = null;
    super.initState();
    _getMascotasList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<TipoMascotaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (TipoMascotaSuccess):
              final loadedState = state as TipoMascotaSuccess;
              setState(() {
                tipoMascotas = loadedState.tipoMascotas;
                _tipoMascotaId = loadedState.tipoMascotas.first.idTipoMascota;
              });
              break;
            case const (TipoMascotaCreatedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipo Mascotas',
                description: 'Tipo Mascota creada',
              );
              break;
            case const (TipoMascotaEditedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipo Mascotas',
                description: 'Tipo Mascota editada',
              );
              break;
            case const (TipoMascotaDeletedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipo Mascotas',
                description: 'Tipo Mascota borrada',
              );
              break;
            case const (TipoMascotaError):
              final stateError = state as TipoMascotaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipo Mascota',
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
              pageTitle: 'Tipo de Mascotas',
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
                'Tipo de mascota',
                '',
              ],
              rows: tipoMascotas.map<Widget>((mascota) {
                final index = tipoMascotas.indexOf(mascota);
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
                                _tipoMascotaId = mascota.idTipoMascota;
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
            BlocBuilder<TipoMascotaBloc, BaseState>(
              builder: (context, state) {
                if (state is TipoMascotaInProgress) {
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
                      _editMascota(id: _tipoMascotaId!);
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
      tipoMascotas = tipoMascotas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchMascotas.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getMascotasList() {
    context.read<TipoMascotaBloc>().add(
          TipoMascotaShown(),
        );
  }

  void _saveNewMascota() {
    context.read<TipoMascotaBloc>().add(
          MascotaSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteMascota({required int id}) {
    context.read<TipoMascotaBloc>().add(
          MascotaDeleted(
            mascotaId: id,
          ),
        );
  }

  void _editMascota({required int id}) {
    context.read<TipoMascotaBloc>().add(
          MascotaEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
