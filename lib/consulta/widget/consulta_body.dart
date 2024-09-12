import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/consulta/bloc/consulta_bloc.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/resources/colors.dart';

class ConsultaBody extends StatefulWidget {
  const ConsultaBody({super.key});

  @override
  State<ConsultaBody> createState() => _ConsultaBodyState();
}

class _ConsultaBodyState extends State<ConsultaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _idCita = TextEditingController();
  final TextEditingController _idEmpleado = TextEditingController();
  final TextEditingController _sintomas = TextEditingController();
  final TextEditingController _diagnostico = TextEditingController();
  final TextEditingController _searchConsulta = TextEditingController();

  late List<ConsultaListModel> consultas;

  late bool _isEdit;
  late int _consultaId;

  @override
  void initState() {
    _isEdit = false;
    consultas = [];
    super.initState();
    _getConsultaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _consultaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<ConsultaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ConsultaSuccess):
              final loadedState = state as ConsultaSuccess;
              setState(() => consultas = loadedState.consultas);
              break;
            case const (ConsultaCreatedSuccess):
              _getConsultaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta creada',
              );
              break;
            case const (ConsultaEditedSuccess):
              _getConsultaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta editada',
              );
              break;
            case const (ConsultaDeletedSuccess):
              _getConsultaList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta borrada',
              );
              break;
            case const (ConsultaError):
              final stateError = state as ConsultaError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
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
              pageTitle: 'Consultas',
              searchController: _searchConsulta,
              onChangeSearchButton: () => _getConsultaList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _idCita.clear();
                  _idEmpleado.clear();
                  _sintomas.clear();
                  _diagnostico.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'iD',
                'Nombre consulta',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: consultas.map<Widget>((consulta) {
                final index = consultas.indexOf(consulta);
                return MouseRegion(
                  onEnter: (event) => setState(() => consulta.isHover = true),
                  onExit: (event) => setState(() => consulta.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: consulta.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${consulta.idConsulta}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(consulta.nombre),
                        ),
                        Expanded(
                          child: Text(consulta.fechacreacion),
                        ),
                        Expanded(
                          child: Text(consulta.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(consulta.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(consulta.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteConsulta(
                                id: consulta.idConsulta,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _idCita.text = 'consulta';
                                _idEmpleado.text = 'consulta';
                                _sintomas.text = 'consulta';
                                _diagnostico.text = 'consulta';
                                _consultaId = consulta.idConsulta;
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
            BlocBuilder<ConsultaBloc, BaseState>(
              builder: (context, state) {
                if (state is ConsultaInProgress) {
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

  Widget _consultaForm() {
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
                _isEdit ? 'Editar Consulta' : 'Nueva Consulta',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInput(
                labelText: 'Id Cita',
                controller: _idCita,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Id Empleado',
                controller: _idEmpleado,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Sintomas',
                controller: _sintomas,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInput(
                labelText: 'Diagnostico',
                controller: _diagnostico,
                textInputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editConsulta(id: _consultaId);
                    } else {
                      _saveNewConsulta();
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
      consultas = consultas
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchConsulta.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getConsultaList() {
    context.read<ConsultaBloc>().add(
          ConsultaShown(),
        );
  }

  void _saveNewConsulta() {
    context.read<ConsultaBloc>().add(
          ConsultaSaved(
            idcita: int.parse(_idCita.text),
            idempleado: int.parse(_idEmpleado.text),
            sintomas: _sintomas.text,
            diagnostico: _diagnostico.text,
          ),
        );
  }

  void _deleteConsulta({required int id}) {
    context.read<ConsultaBloc>().add(
          ConsultaDeleted(
            consultaID: id,
          ),
        );
  }

  void _editConsulta({required int id}) {
    context.read<ConsultaBloc>().add(
          ConsultaEdited(
            idconsulta: _consultaId,
            idcita: int.parse(_idCita.text),
            idempleado: int.parse(_idEmpleado.text),
            sintomas: _sintomas.text,
            diagnostico: _diagnostico.text,
          ),
        );
  }
}
