import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/persona/bloc/persona_bloc.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class PersonaBody extends StatefulWidget {
  const PersonaBody({super.key});

  @override
  State<PersonaBody> createState() => _PersonaBodyState();
}

class _PersonaBodyState extends State<PersonaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _idpersona = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _fechanacimiento = TextEditingController();
  final TextEditingController _idGenero = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correoelectronico = TextEditingController();
  final TextEditingController _idEstadoCivil = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<PersonaListModel> personas;

  late bool _isEdit;
  late int _personaId;

  @override
  void initState() {
    _isEdit = false;
    personas = [];
    super.initState();
    _getPersonaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _personaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<PersonaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (PersonaSuccess):
              final loadedState = state as PersonaSuccess;
              setState(() => personas = loadedState.personas);
              break;
            case const (PersonaCreatedSuccess):
              _getPersonaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Personas',
                description: 'Persona creada',
              );
              break;
            case const (PersonaEditedSuccess):
              _getPersonaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Personas',
                description: 'Persona editada',
              );
              break;
            case const (PersonaDeletedSuccess):
              _getPersonaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Personas',
                description: 'Persona borrada',
              );
              break;
            case const (PersonaError):
              final stateError = state as PersonaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Personas',
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
              pageTitle: 'Personas',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getPersonaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _idpersona.clear();
                  _nombre.clear();
                  _apellido.clear();
                  _fechanacimiento.clear();
                  _idGenero.clear();
                  _direccion.clear();
                  _telefono.clear();
                  _correoelectronico.clear();
                  _idEstadoCivil.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre persona',
                'Dirección',
                'Usuario',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: personas.map<Widget>((persona) {
                final index = personas.indexOf(persona);
                return MouseRegion(
                  onEnter: (event) => setState(() => persona.isHover = true),
                  onExit: (event) => setState(() => persona.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: persona.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${persona.idPersona}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(persona.nombre),
                        ),
                        Expanded(
                          child: Text(persona.fechacreacion),
                        ),
                        Expanded(
                          child: Text(persona.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(persona.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(persona.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deletePersona(
                                id: persona.idPersona,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _isEdit = false;
                                _idpersona.text = persona.idPersona.toString();
                                _nombre.text = persona.nombre;
                                _apellido.text = persona.apellido;
                                _fechanacimiento.text = persona.fechaNacimiento;
                                _idGenero.text = persona.idGenero.toString();
                                _direccion.text = persona.direccion;
                                _telefono.text = persona.telefono;
                                _correoelectronico.text =
                                    persona.correoElectronico;
                                _idEstadoCivil.text =
                                    persona.idEstadoCivil.toString();
                                _personaId = persona.idPersona;
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
            BlocBuilder<PersonaBloc, BaseState>(
              builder: (context, state) {
                if (state is PersonaInProgress) {
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

  Widget _personaForm() {
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
                _isEdit ? 'Editar Persona' : 'Nueva Persona',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Nombre',
                controller: _nombre,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Apellido',
                controller: _apellido,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Fecha de nacimiento',
                controller: _fechanacimiento,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Genero',
                controller: _idGenero,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Direccion',
                controller: _direccion,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Telefono',
                controller: _telefono,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Correo Electronico',
                controller: _correoelectronico,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Estado Civil',
                controller: _idEstadoCivil,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editPersona(id: _personaId);
                    } else {
                      _saveNewPersona();
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
      personas = personas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getPersonaList() {
    context.read<PersonaBloc>().add(
          PersonaShown(),
        );
  }

  void _saveNewPersona() {
    context.read<PersonaBloc>().add(
          PersonaSaved(
            nombre: _nombre.text,
            apellido: _apellido.text,
            fechaNacimiento: _fechanacimiento.text,
            idGenero: int.parse(_idGenero.text),
            direccion: _direccion.text,
            telefono: _telefono.text,
            correoElectronico: _correoelectronico.text,
            idEstadoCivil: int.parse(_idEstadoCivil.text),
          ),
        );
  }

  void _deletePersona({required int id}) {
    context.read<PersonaBloc>().add(
          PersonaDeleted(
            id: id,
          ),
        );
  }

  void _editPersona({required int id}) {
    context.read<PersonaBloc>().add(
          PersonaEdited(
            fechacreacion: '${DateTime.now()}',
            usuariocreacion: '',
            fechamodificacion: '${DateTime.now()}',
            usuariomodificacion: '',
            idpersona: int.parse(_idpersona.text),
            nombre: _nombre.text,
            apellido: _apellido.text,
            fechanacimiento: _fechanacimiento.text,
            idGenero: int.parse(_idGenero.text),
            direccion: _direccion.text,
            telefono: _telefono.text,
            correoelectronico: _correoelectronico.text,
            idEstadoCivil: int.parse(_idEstadoCivil.text),
          ),
        );
  }
}
