import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';
import 'package:paraiso_canino/tipoMascota/bloc/mascota_bloc.dart';
import 'package:paraiso_canino/tipoMascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/tipoMascota/model/tipo_mascota_list_model.dart';

class TipoMascotaBody extends StatefulWidget {
  const TipoMascotaBody({super.key});

  @override
  State<TipoMascotaBody> createState() => _TipoMascotaBodyState();
}

class _TipoMascotaBodyState extends State<TipoMascotaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _peso = TextEditingController();
  final TextEditingController _tipoMascotaController = TextEditingController();
  final TextEditingController _personaController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _tallaController = TextEditingController();
  final TextEditingController _searchMascotas = TextEditingController();

  late List<TipoMascotaListModel> tipoMascotas;
  late List<GeneroListModel> generos;
  late List<PersonaListModel> personas;
  late List<ColorListModel> colores;
  late List<TallaListModel> tallas;
  late List<MascotaListModel> mascotas;

  late bool _isEdit;
  late int? _tipoMascotaId;
  late int? _generoId;
  late int? _personaId;
  late int? _colorId;
  late int? _tallaId;
  late int _mascotaId;

  @override
  void initState() {
    _isEdit = false;
    tipoMascotas = [];
    generos = [];
    personas = [];
    colores = [];
    tallas = [];
    mascotas = [];
    _tipoMascotaId = null;
    _generoId = null;
    _personaId = null;
    _colorId = null;
    _tallaId = null;
    super.initState();
    _getFormLists();
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
            case const (GeneroSuccess):
              final loadedState = state as GeneroSuccess;
              setState(() {
                generos = loadedState.genero;
                _generoId = loadedState.genero.first.idGenero;
              });
              break;
            case const (PersonaSuccess):
              final loadedState = state as PersonaSuccess;
              setState(() {
                personas = loadedState.personas;
                _personaId = loadedState.personas.first.idpersona;
              });
              break;
            case const (ColorSuccess):
              final loadedState = state as ColorSuccess;
              setState(() {
                colores = loadedState.colores;
                _colorId = loadedState.colores.first.idColor;
              });
              break;
            case const (TallaSuccess):
              final loadedState = state as TallaSuccess;
              setState(() {
                tallas = loadedState.tallas;
                _tallaId = loadedState.tallas.first.idTalla;
              });
              break;
            case const (MascotaSuccess):
              final loadedState = state as MascotaSuccess;
              setState(() => mascotas = loadedState.mascotas);
              break;
            case const (TipoMascotaCreatedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipomascotas',
                description: 'TipoMascota creada',
              );
              break;
            case const (TipoMascotaEditedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipomascotas',
                description: 'TipoMascota editada',
              );
              break;
            case const (TipoMascotaDeletedSuccess):
              _getMascotasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Tipomascotas',
                description: 'TipoMascota borrada',
              );
              break;
            case const (TipoMascotaError):
              final stateError = state as TipoMascotaError;
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
                'Nombre propietario',
                'Tipo de mascota',
                'Color',
                'Peso',
                'Talla',
                'Genero',
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
                          child: Text(mascota.nombreMascota),
                        ),
                        Expanded(
                          child: Text(
                            '${mascota.nombrePropietario} ${mascota.apellidoPropietario}',
                          ),
                        ),
                        Expanded(
                          child: Text(mascota.nombreTipoMascota),
                        ),
                        Expanded(
                          child: Text(mascota.nombreColor),
                        ),
                        Expanded(
                          child: Text('${mascota.peso} LBs'),
                        ),
                        Expanded(
                          child: Text(mascota.nombreTalla),
                        ),
                        Expanded(
                          child: Text(mascota.nombreGenero),
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
                                _name.text = mascota.nombreMascota;
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
                              // PopupMenuItem(
                              //   value: TableRowActions.delete,
                              //   child: Text('Eliminar'),
                              // ),
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
              CustomInput(
                labelText: 'Peso',
                controller: _peso,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Propietario',
                hint: 'Selecciona una persona',
                valueItems: personas
                    .map<String>((persona) => persona.idpersona.toString())
                    .toList(),
                displayItems:
                    personas.map<String>((persona) => persona.nombre).toList(),
                onSelected: (String? newPersona) {
                  setState(() {
                    _personaId = personas
                        .firstWhere((persona) => persona.nombre == newPersona)
                        .idpersona;
                  });
                },
                controller: _personaController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Tipo Mascota',
                hint: 'Selecciona un tipo',
                valueItems: tipoMascotas
                    .map<String>((mascota) => mascota.idTipoMascota.toString())
                    .toList(),
                displayItems: tipoMascotas
                    .map<String>((mascota) => mascota.nombre)
                    .toList(),
                onSelected: (String? newMascota) {
                  setState(() {
                    _tipoMascotaId = tipoMascotas
                        .firstWhere((mascota) => mascota.nombre == newMascota)
                        .idTipoMascota;
                  });
                },
                controller: _tipoMascotaController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Genero',
                hint: 'Selecciona un genero',
                valueItems: generos
                    .map<String>((genero) => genero.idGenero.toString())
                    .toList(),
                displayItems:
                    generos.map<String>((genero) => genero.nombre).toList(),
                onSelected: (String? newGenero) {
                  setState(() {
                    _generoId = generos
                        .firstWhere((genero) => genero.nombre == newGenero)
                        .idGenero;
                  });
                },
                controller: _generoController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Color',
                hint: 'Selecciona un color',
                valueItems: colores
                    .map<String>((color) => color.idColor.toString())
                    .toList(),
                displayItems:
                    colores.map<String>((color) => color.nombre).toList(),
                onSelected: (String? newColor) {
                  setState(() {
                    _colorId = colores
                        .firstWhere((color) => color.nombre == newColor)
                        .idColor;
                  });
                },
                controller: _colorController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Talla',
                hint: 'Selecciona un talla',
                valueItems: tallas
                    .map<String>((talla) => talla.idTalla.toString())
                    .toList(),
                displayItems:
                    tallas.map<String>((talla) => talla.nombre).toList(),
                onSelected: (String? newTalla) {
                  setState(() {
                    _tallaId = tallas
                        .firstWhere((talla) => talla.nombre == newTalla)
                        .idTalla;
                  });
                },
                controller: _tallaController,
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
            (element) => element.nombreMascota.toLowerCase().contains(
                  _searchMascotas.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getFormLists() {
    context.read<TipoMascotaBloc>()
      ..add(
        TipoMascotaShown(),
      )
      ..add(
        GeneroShown(),
      )
      ..add(
        PersonaShown(),
      )
      ..add(
        ColorShown(),
      )
      ..add(
        TallaShown(),
      );
  }

  void _getMascotasList() {
    context.read<TipoMascotaBloc>().add(
          MascotaShown(),
        );
  }

  void _saveNewMascota() {
    context.read<TipoMascotaBloc>().add(
          MascotaSaved(
            idTipoMascota: _tipoMascotaId!,
            idGenero: _generoId!,
            idPersona: _personaId!,
            idColor: _colorId!,
            idTalla: _tallaId!,
            name: _name.text,
            peso: _peso.text,
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
            idTipoMascota: _tipoMascotaId!,
            idGenero: _generoId!,
            idPersona: _personaId!,
            idColor: _colorId!,
            idTalla: _tallaId!,
            name: _name.text,
            peso: _peso.text,
          ),
        );
  }
}
