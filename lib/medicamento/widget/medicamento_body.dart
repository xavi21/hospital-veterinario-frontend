import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/medicamento/bloc/medicamento_bloc.dart';
import 'package:paraiso_canino/medicamento/model/casa_medica_model.dart';
import 'package:paraiso_canino/medicamento/model/componente_principal_model.dart';
import 'package:paraiso_canino/medicamento/model/medicamento_response.dart';
import 'package:paraiso_canino/resources/colors.dart';

class MedicamentoBody extends StatefulWidget {
  const MedicamentoBody({super.key});

  @override
  State<MedicamentoBody> createState() => _MedicamentoBodyState();
}

class _MedicamentoBodyState extends State<MedicamentoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _casaMedicaController = TextEditingController();
  final TextEditingController _componentePrincipalController =
      TextEditingController();
  final TextEditingController _searchMedicamento = TextEditingController();

  late List<MedicamentoListModel> medicamentos;
  late List<CasaMedicaListModel> casaMedica;
  late List<ComponentePrincipalListModel> componentePrincipal;

  late bool _isEdit;
  late int? _medicamentoId;
  late int? _casaMedicaId;
  late int? _componentePrincipalId;

  @override
  void initState() {
    _isEdit = false;
    _medicamentoId = null;
    _casaMedicaId = null;
    _componentePrincipalId = null;
    casaMedica = [];
    componentePrincipal = [];
    medicamentos = [];
    super.initState();
    _getMedicamentoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawerForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<MedicamentoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (MedicamentoSuccess):
              final loadedState = state as MedicamentoSuccess;
              setState(() => medicamentos = loadedState.medicamentos);
              break;
            case const (CasaMedicaSuccess):
              final loadedState = state as CasaMedicaSuccess;
              setState(() {
                casaMedica = loadedState.casasMedicas;
                _casaMedicaId = loadedState.casasMedicas.first.idcasamedica;
              });
              break;
            case const (ComponentePrincipalSuccess):
              final loadedState = state as ComponentePrincipalSuccess;
              setState(() {
                componentePrincipal = loadedState.componentePrincipal;
                _componentePrincipalId =
                    loadedState.componentePrincipal.first.idComponentePrincipal;
              });
              break;
            case const (MedicamentoCreatedSuccess):
              _getMedicamentoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
                description: 'Medicamento creado correctamente',
              );
              break;
            case const (MedicamentoUpdatedSuccess):
              _getMedicamentoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
                description: 'Medicamento modificado correctamente',
              );
              break;
            case const (MedicamentoDeletedSuccess):
              _getMedicamentoList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
                description: 'Medicamento borrado',
              );
              break;
            case const (MedicamentoError):
              final stateError = state as MedicamentoError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Medicamentos',
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
              pageTitle: 'Medicamentos',
              searchController: _searchMedicamento,
              onChangeSearchButton: () => _getMedicamentoList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _isEdit = false;
                  _name.clear();
                  _description.clear();
                  _casaMedicaId = casaMedica.first.idcasamedica;
                  _componentePrincipalId =
                      componentePrincipal.first.idComponentePrincipal;
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID medicamento',
                'nombre',
                'Componente principal',
                'nombre comercial',
                'nombre de casa medica',
                'descripcion',
                '',
              ],
              rows: medicamentos.map<Widget>((medicamento) {
                final index = medicamentos.indexOf(medicamento);
                return MouseRegion(
                  onEnter: (event) =>
                      setState(() => medicamento.isHover = true),
                  onExit: (event) =>
                      setState(() => medicamento.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: medicamento.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${medicamento.idmedicamento}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            medicamento.nombre,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(medicamento.nombreComponentePrincipal),
                        ),
                        Expanded(
                          child: Text(medicamento.nombrecomercial),
                        ),
                        Expanded(
                          child: Text(
                            medicamento.nombreCasaMedica,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(medicamento.descripcion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _medicamentoId = medicamento.idmedicamento;
                                _name.text = medicamento.nombre;
                                _description.text = medicamento.descripcion;
                                _casaMedicaId = medicamento.idcasamedica;
                                _componentePrincipalId =
                                    medicamento.idcomponenteprincipal;
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
                            ];
                          },
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            BlocBuilder<MedicamentoBloc, BaseState>(
              builder: (context, state) {
                if (state is MedicamentoInProgress) {
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
                _isEdit ? 'Editar Medicamento' : 'Nuevo Medicamento',
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
                labelText: 'Descripcion',
                controller: _description,
                isRequired: true,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Casa Medica',
                hint: 'Selecciona una casa',
                valueItems: casaMedica
                    .map<String>((casa) => casa.idcasamedica.toString())
                    .toList(),
                displayItems:
                    casaMedica.map<String>((casa) => casa.nombre).toList(),
                onSelected: (String? newCasa) {
                  setState(() {
                    _casaMedicaId = casaMedica
                        .firstWhere((casa) => casa.nombre == newCasa)
                        .idcasamedica;
                  });
                },
                controller: _casaMedicaController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Componente Principal',
                hint: 'Selecciona un componente',
                valueItems: componentePrincipal
                    .map<String>((componente) =>
                        componente.idComponentePrincipal.toString())
                    .toList(),
                displayItems: componentePrincipal
                    .map<String>((componente) => componente.nombre)
                    .toList(),
                onSelected: (String? newComponente) {
                  setState(() {
                    _componentePrincipalId = componentePrincipal
                        .firstWhere(
                            (componente) => componente.nombre == newComponente)
                        .idComponentePrincipal;
                  });
                },
                controller: _componentePrincipalController,
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Navigator.pop(context);
                    if (_isEdit) {
                      _editMedicamento(id: _medicamentoId!);
                    } else {
                      _saveNewMedicamento();
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
      medicamentos = medicamentos
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchMedicamento.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _saveNewMedicamento() {
    context.read<MedicamentoBloc>().add(
          MedicamentoSaved(
            name: _name.text,
            description: _description.text,
            idCasaMeidca: _casaMedicaId!,
            idComponentePrincipal: _componentePrincipalId!,
          ),
        );
  }

  void _editMedicamento({required int id}) {
    context.read<MedicamentoBloc>().add(
          MedicamentoUpdated(
            id: id,
            name: _name.text,
            description: _description.text,
            idCasaMeidca: _casaMedicaId!,
            idComponentePrincipal: _componentePrincipalId!,
          ),
        );
  }

  void _getMedicamentoList() {
    context.read<MedicamentoBloc>()
      ..add(
        MedicamentoShown(),
      )
      ..add(
        CasaMedicaShown(),
      )
      ..add(
        ComponentePrincipalShown(),
      );
  }
}
