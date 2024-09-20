import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paraiso_canino/ambulancia/bloc/ambulancia_bloc.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/maps/google_maps.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class AmbulanciaBody extends StatefulWidget {
  const AmbulanciaBody({super.key});

  @override
  State<AmbulanciaBody> createState() => _AmbulanciaBodyState();
}

class _AmbulanciaBodyState extends State<AmbulanciaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _placa = TextEditingController();
  final TextEditingController _marca = TextEditingController();
  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _latitud = TextEditingController();
  final TextEditingController _longitud = TextEditingController();
  final TextEditingController _idEmpleado = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<AmbulanciaListModel> ambulancias;

  late bool _isEdit;
  late int _ambulanciaId;

  @override
  void initState() {
    _isEdit = false;
    ambulancias = [];
    _getAmbulanciasList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _ambulanciaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<AmbulanciaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (AmbulanciaListSuccess):
              final loadedState = state as AmbulanciaListSuccess;
              setState(() => ambulancias = loadedState.ambulancias);
              break;
            case const (AmbulanciaCreatedSuccess):
              _getAmbulanciasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ambulancias',
                description: 'Ambulancia creada',
              );
              break;
            case const (AmbulanciaEditedSuccess):
              _getAmbulanciasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ambulancias',
                description: 'Ambulancia editada',
              );
              break;
            case const (AmbulanciaDeletedSuccess):
              _getAmbulanciasList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ambulancias',
                description: 'Ambulancia borrada',
              );
              break;
            case const (AmbulanciaServiceError):
              final stateError = state as AmbulanciaServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ambulancias',
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
              pageTitle: 'Ambulancias',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getAmbulanciasList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _idEmpleado.clear();
                  _marca.clear();
                  _modelo.clear();
                  _placa.clear();
                  _latitud.clear();
                  _longitud.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID Ambulancia',
                'Placas',
                'Marca',
                'Modelo',
                'Latitud',
                'Longitud',
                '',
              ],
              rows: ambulancias.map<Widget>((ambulancia) {
                final index = ambulancias.indexOf(ambulancia);
                return MouseRegion(
                  onEnter: (event) => setState(() => ambulancia.isHover = true),
                  onExit: (event) => setState(() => ambulancia.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: ambulancia.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${ambulancia.idAmbulancia}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(ambulancia.placa),
                        ),
                        Expanded(
                          child: Text(ambulancia.marca),
                        ),
                        Expanded(
                          child: Text(ambulancia.modelo),
                        ),
                        Expanded(
                          child: Text(ambulancia.latitud),
                        ),
                        Expanded(
                          child: Text(ambulancia.longitud),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteAmbulancia(
                                id: ambulancia.idAmbulancia,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _idEmpleado.text =
                                    ambulancia.idAmbulancia.toString();
                                _placa.text = ambulancia.placa;
                                _marca.text = ambulancia.marca;
                                _modelo.text = ambulancia.modelo;
                                _latitud.text = ambulancia.latitud;
                                _longitud.text = ambulancia.longitud;
                                _ambulanciaId = ambulancia.idAmbulancia;
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
            BlocBuilder<AmbulanciaBloc, BaseState>(
              builder: (context, state) {
                if (state is AmbulanciaInProgress) {
                  return const Loader();
                }
                return Container();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: white,
        backgroundColor: blue,
        onPressed: () => _showGoogleMapLocation(),
        label: const Text('Ver ubicaciones'),
        icon: const Icon(Icons.map),
      ),
    );
  }

  Widget _ambulanciaForm() {
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
                _isEdit ? 'Editar Ambulancia' : 'Nueva Ambulancia',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Placa',
                controller: _placa,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Marca',
                controller: _marca,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Modelo',
                controller: _modelo,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Latitud',
                controller: _latitud,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Longitud',
                controller: _longitud,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Empleado ID',
                controller: _idEmpleado,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editAmbulancia(id: _ambulanciaId);
                    } else {
                      _saveNewAmbulancia();
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
      ambulancias = ambulancias
          .where(
            (element) => element.placa.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getAmbulanciasList() {
    context.read<AmbulanciaBloc>().add(
          AmbulanciaListShown(),
        );
  }

  void _saveNewAmbulancia() {
    context.read<AmbulanciaBloc>().add(
          AmbulanciaSaved(
            placa: _placa.text,
            marca: _marca.text,
            modelo: _modelo.text,
            latitud: _latitud.text,
            longitud: _longitud.text,
            idEmpleado: int.parse(_idEmpleado.text),
          ),
        );
  }

  void _deleteAmbulancia({required int id}) {
    context.read<AmbulanciaBloc>().add(
          AmbulanciaDeleted(
            id: id,
          ),
        );
  }

  void _editAmbulancia({required int id}) {
    context.read<AmbulanciaBloc>().add(
          AmbulanciaEdited(
            placa: _placa.text,
            marca: _marca.text,
            modelo: _modelo.text,
            latitud: _latitud.text,
            longitud: _longitud.text,
            idAmbulancia: _ambulanciaId,
            idEmpleado: int.parse(_idEmpleado.text),
          ),
        );
  }

  void _showGoogleMapLocation() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const SizedBox(
                    width: 40.0,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset('${iconPath}arrow_back.svg'),
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    width: 40.0,
                  ),
                  Text(
                    'Ubicaciones de Ambulancias',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: GoogleMaps(
                ambulancias: ambulancias,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
