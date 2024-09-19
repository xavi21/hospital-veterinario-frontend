import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/sucursal/bloc/sucursal_bloc.dart';
import 'package:paraiso_canino/sucursal/model/sucursal_response.dart';

class SucursalBody extends StatefulWidget {
  const SucursalBody({super.key});

  @override
  State<SucursalBody> createState() => _SucursalBodyState();
}

class _SucursalBodyState extends State<SucursalBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _direction = TextEditingController();
  final TextEditingController _searchOptions = TextEditingController();

  late List<OfficeListModel> sucursales;

  late bool _isEdit;
  late int _sucursalId;

  @override
  void initState() {
    _isEdit = false;
    sucursales = [];
    super.initState();
    _getOfficeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _sucursalForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<SucursalBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (SucursalSuccess):
              final loadedState = state as SucursalSuccess;
              setState(() => sucursales = loadedState.sucursales);
              break;
            case const (SucursalCreatedSuccess):
              _getOfficeList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
                description: 'Sucursal creada',
              );
              break;
            case const (SucursalEditedSuccess):
              _getOfficeList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
                description: 'Sucursal editada',
              );
              break;
            case const (SucursalDeletedSuccess):
              _getOfficeList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
                description: 'Sucursal borrada',
              );
              break;
            case const (SucursalError):
              final stateError = state as SucursalError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
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
              pageTitle: 'Sucursales',
              searchController: _searchOptions,
              onChangeSearchButton: () => _getOfficeList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _direction.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre sucursal',
                'Dirección',
                'Usuario',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: sucursales.map<Widget>((sucursal) {
                final index = sucursales.indexOf(sucursal);
                return MouseRegion(
                  onEnter: (event) => setState(() => sucursal.isHover = true),
                  onExit: (event) => setState(() => sucursal.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: sucursal.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${sucursal.idsucursal}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(sucursal.name),
                        ),
                        Expanded(
                          child: Text(sucursal.direccion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuario),
                        ),
                        Expanded(
                          child: Text(sucursal.fechacreacion),
                        ),
                        Expanded(
                          child: Text(sucursal.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.see) {
                              _showGoogleMapLocation();
                            }
                            if (value == TableRowActions.delete) {
                              _deleteSucursal(
                                id: sucursal.idsucursal,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = sucursal.name;
                                _direction.text = sucursal.direccion;
                                _sucursalId = sucursal.idsucursal;
                              });
                              _scaffoldKey.currentState!.openEndDrawer();
                            }
                          },
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: TableRowActions.see,
                                child: Text('Ver'),
                              ),
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
            BlocBuilder<SucursalBloc, BaseState>(
              builder: (context, state) {
                if (state is SucursalInProgress) {
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

  Widget _sucursalForm() {
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
                _isEdit ? 'Editar Sucursal' : 'Nueva Sucursal',
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
                labelText: 'Dirección',
                controller: _direction,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editSucursal(id: _sucursalId);
                    } else {
                      _saveNewSucursal();
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

  void _showGoogleMapLocation() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Center(
          child: Text('Dialogo'),
        ),
      ),
    );
  }

  void _filterTable() {
    setState(() {
      sucursales = sucursales
          .where(
            (element) => element.name.toLowerCase().contains(
                  _searchOptions.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getOfficeList() {
    context.read<SucursalBloc>().add(
          OfficeShown(),
        );
  }

  void _saveNewSucursal() {
    context.read<SucursalBloc>().add(
          OfficeSaved(
            name: _name.text,
            direction: _direction.text,
          ),
        );
  }

  void _deleteSucursal({required int id}) {
    context.read<SucursalBloc>().add(
          OfficeDeleted(
            officeID: id,
          ),
        );
  }

  void _editSucursal({required int id}) {
    context.read<SucursalBloc>().add(
          OfficeEdited(
            id: id,
            name: _name.text,
            direction: _direction.text,
          ),
        );
  }
}
