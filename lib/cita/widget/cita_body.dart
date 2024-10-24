import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cita/bloc/cita_bloc.dart';
import 'package:paraiso_canino/cita/model/cita_list_model.dart';
import 'package:paraiso_canino/cita/model/mascota_list_model.dart';
import 'package:paraiso_canino/cita/model/status_cita_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
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
  final TextEditingController _idMascota = TextEditingController();
  final TextEditingController _idStatusCita = TextEditingController();
  final TextEditingController _motivo = TextEditingController();
  final TextEditingController _searchCitas = TextEditingController();

  late List<CitaListModel> citas;
  late List<StatusCitaListModel> statusCitas;
  late List<MascotaListModel> mascotas;

  late bool _isEdit;
  late int _citaId;

  late int _selectedMascotaId;
  late int _selectedStatusCitaId;

  @override
  void initState() {
    _isEdit = false;
    citas = [];
    mascotas = [];
    statusCitas = [];
    _getCitasList();
    _getFormLists();
    super.initState();
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
            case const (StatucCitaSuccess):
              final loadedState = state as StatucCitaSuccess;
              setState(() => statusCitas = loadedState.statusCitas);
              break;
            case const (MascotaSuccess):
              final loadedState = state as MascotaSuccess;
              setState(() => mascotas = loadedState.mascotas);
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
                  _idMascota.clear();
                  _idStatusCita.clear();
                  _motivo.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID Cita',
                'Estatus cita',
                'ID Mascota',
                'Nombre mascota',
                'Motivo',
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
                            '${cita.idcita}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(cita.nombreStatusCita),
                        ),
                        Expanded(
                          child: Text(
                            '${cita.idmascota}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(cita.nombreMascota),
                        ),
                        Expanded(
                          child: Text(cita.motivo),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteCita(
                                id: cita.idcita,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _idMascota.text = cita.nombreMascota;
                                _idStatusCita.text = cita.nombreStatusCita;
                                _motivo.text = cita.motivo;
                                _citaId = cita.idcita;
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
              CustomInputSelect(
                title: 'Mascota',
                hint: 'Selecciona una mascota',
                valueItems: mascotas
                    .map<String>((mascota) => mascota.idmascota.toString())
                    .toList(),
                displayItems: mascotas
                    .map<String>((mascota) => mascota.nombreMascota)
                    .toList(),
                onSelected: (String? mascotaId) {
                  setState(() {
                    _selectedMascotaId = mascotas
                        .firstWhere(
                            (element) => element.nombreMascota == mascotaId)
                        .idmascota;
                  });
                },
                controller: _idMascota,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Estado Cita',
                hint: 'Selecciona un estado',
                valueItems: statusCitas
                    .map<String>((status) => status.idestatuscita.toString())
                    .toList(),
                displayItems:
                    statusCitas.map<String>((status) => status.nombre).toList(),
                onSelected: (String? statusId) {
                  setState(() {
                    _selectedStatusCitaId = statusCitas
                        .firstWhere((element) => element.nombre == statusId)
                        .idestatuscita;
                  });
                },
                controller: _idStatusCita,
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                labelText: 'Motivo',
                controller: _motivo,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _updateCita(id: _citaId);
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
            (element) => element.nombreMascota.toLowerCase().contains(
                  _searchCitas.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getFormLists() {
    context.read<CitaBloc>()
      ..add(
        StatusCitaListShown(),
      )
      ..add(
        MascotaListShown(),
      );
  }

  void _getCitasList() {
    context.read<CitaBloc>().add(
          CitaShown(),
        );
  }

  void _createNewCita() {
    context.read<CitaBloc>().add(
          CitaSaved(
            idMascota: _selectedMascotaId,
            idStatusCita: _selectedStatusCitaId,
            motivo: _motivo.text,
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
            idCita: _citaId,
            idMascota: _selectedMascotaId,
            idStatusCita: _selectedStatusCitaId,
            motivo: _motivo.text,
          ),
        );
  }
}
