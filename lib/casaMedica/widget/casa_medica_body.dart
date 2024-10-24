import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/casaMedica/bloc/casamedica_bloc.dart';
import 'package:paraiso_canino/casaMedica/model/cada_medica_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CasaMedicaBody extends StatefulWidget {
  const CasaMedicaBody({super.key});

  @override
  State<CasaMedicaBody> createState() => _CasaMedicaBodyState();
}

class _CasaMedicaBodyState extends State<CasaMedicaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _comercialName = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<CasaMedicaListModel> casaMedicas;

  late bool _isEdit;
  late int _casaMedicaId;

  @override
  void initState() {
    _isEdit = false;
    casaMedicas = [];
    _getCasaMedicaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<CasamedicaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (CasaMedicaSuccess):
              final loadedState = state as CasaMedicaSuccess;
              setState(() => casaMedicas = loadedState.casasMedicas);
              break;
            case const (CasaMedicaCreatedSuccess):
              _getCasaMedicaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Casa Medicas',
                description: 'Casa Medica creada',
              );
              break;
            case const (CasaMedicaEditedSuccess):
              _getCasaMedicaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Casa Medicas',
                description: 'Casa Medica editada',
              );
              break;
            case const (CasaMedicaDeletedSuccess):
              _getCasaMedicaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Casa Medicas',
                description: 'Casa Medica borrada',
              );
              break;
            case const (CasaMedicaError):
              final stateError = state as CasaMedicaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Casa Medica',
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
              pageTitle: 'Casas Medicas',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getCasaMedicaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _comercialName.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre',
                'Nombre Comercial',
                '',
              ],
              rows: casaMedicas.map<Widget>((casaMedica) {
                final index = casaMedicas.indexOf(casaMedica);
                return MouseRegion(
                  onEnter: (event) => setState(() => casaMedica.isHover = true),
                  onExit: (event) => setState(() => casaMedica.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: casaMedica.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${casaMedica.idcasamedica}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(casaMedica.nombre),
                        ),
                        Expanded(
                          child: Text(casaMedica.nombrecomercial),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteCasaMedica(
                                id: casaMedica.idcasamedica,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _casaMedicaId = casaMedica.idcasamedica;
                                _name.text = casaMedica.nombre;
                                _comercialName.text =
                                    casaMedica.nombrecomercial;
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
            BlocBuilder<CasamedicaBloc, BaseState>(
              builder: (context, state) {
                if (state is CasaMedicaInProgress) {
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
                _isEdit ? 'Editar CasaMedica' : 'Nuevo CasaMedica',
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
                labelText: 'Nombre Comercial',
                controller: _comercialName,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editCasaMedica(id: _casaMedicaId);
                    } else {
                      _saveNewCasaMedica();
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
      casaMedicas = casaMedicas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getCasaMedicaList() {
    context.read<CasamedicaBloc>().add(
          CasaMedicaShown(),
        );
  }

  void _saveNewCasaMedica() {
    context.read<CasamedicaBloc>().add(
          CasaMedicaSaved(
            name: _name.text,
            nombreComercial: _comercialName.text,
          ),
        );
  }

  void _deleteCasaMedica({required int id}) {
    context.read<CasamedicaBloc>().add(
          CasaMedicaDeleted(
            id: id,
          ),
        );
  }

  void _editCasaMedica({required int id}) {
    context.read<CasamedicaBloc>().add(
          CasaMedicaEdited(
            id: id,
            name: _name.text,
            nombreComercial: _comercialName.text,
          ),
        );
  }
}
