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
import 'package:paraiso_canino/statusUsuario/bloc/statususuario_bloc.dart';
import 'package:paraiso_canino/statusUsuario/model/status_usuario_response.dart';

class StatusUsuarioBody extends StatefulWidget {
  const StatusUsuarioBody({super.key});

  @override
  State<StatusUsuarioBody> createState() => _StatusUsuarioBodyState();
}

class _StatusUsuarioBodyState extends State<StatusUsuarioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchStatusUser = TextEditingController();

  late List<StatusUsuarioListModel> userStatusList;

  late bool _isEdit;
  late int _statusUsuarioId;

  @override
  void initState() {
    _isEdit = false;
    userStatusList = [];
    super.initState();
    _getUserStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<StatusUsuarioBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (StatusUsuarioSuccess):
              final loadedState = state as StatusUsuarioSuccess;
              setState(() => userStatusList = loadedState.statusUsuarios);
              break;
            case const (StatusUsuarioCreatedSuccess):
              _getUserStatusList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusUsuarios',
                description: 'StatusUsuario creada',
              );
              break;
            case const (StatusUsuarioEditedSuccess):
              _getUserStatusList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusUsuarios',
                description: 'StatusUsuario editada',
              );
              break;
            case const (StatusUsuarioDeletedSuccess):
              _getUserStatusList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusUsuarios',
                description: 'StatusUsuario borrada',
              );
              break;
            case const (StatusUsuarioError):
              final stateError = state as StatusUsuarioError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'StatusUsuarios',
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
              pageTitle: 'StatusUsuarios',
              searchController: _searchStatusUser,
              onChangeSearchButton: () => _getUserStatusList(),
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
                'Nombre StatusUsuario',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: userStatusList.map<Widget>((userStatus) {
                final index = userStatusList.indexOf(userStatus);
                return MouseRegion(
                  onEnter: (event) => setState(() => userStatus.isHover = true),
                  onExit: (event) => setState(() => userStatus.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: userStatus.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${userStatus.idstatususuario}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(userStatus.name),
                        ),
                        Expanded(
                          child: Text(userStatus.fechacreacion),
                        ),
                        Expanded(
                          child: Text(userStatus.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(userStatus.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(userStatus.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteStatusUsuario(
                                id: userStatus.idstatususuario,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = userStatus.name;
                                _statusUsuarioId = userStatus.idstatususuario;
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
            BlocBuilder<StatusUsuarioBloc, BaseState>(
              builder: (context, state) {
                if (state is StatusUsuarioInProgress) {
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
                _isEdit ? 'Editar StatusUsuario' : 'Nueva StatusUsuario',
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
                      _editStatusUsuario(id: _statusUsuarioId);
                    } else {
                      _saveNewStatusUsuario();
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
      userStatusList = userStatusList
          .where(
            (element) => element.name.toLowerCase().contains(
                  _searchStatusUser.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getUserStatusList() {
    context.read<StatusUsuarioBloc>().add(
          StatusUsuarioShown(),
        );
  }

  void _saveNewStatusUsuario() {
    context.read<StatusUsuarioBloc>().add(
          StatusUsuarioSaved(
            name: _name.text,
          ),
        );
  }

  void _deleteStatusUsuario({required int id}) {
    context.read<StatusUsuarioBloc>().add(
          StatusUsuarioDeleted(
            statusUsuarioId: id,
          ),
        );
  }

  void _editStatusUsuario({required int id}) {
    context.read<StatusUsuarioBloc>().add(
          StatusUsuarioEdited(
            id: id,
            name: _name.text,
          ),
        );
  }
}
