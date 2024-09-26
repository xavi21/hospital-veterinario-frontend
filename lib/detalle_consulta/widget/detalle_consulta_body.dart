import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/consulta_laboratorio/consulta_laboratorio_page.dart';
import 'package:paraiso_canino/detalle_consulta/bloc/detalleconsulta_bloc.dart';
import 'package:paraiso_canino/detalle_consulta/model/cita_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/model/empleado_list_model.dart';
import 'package:paraiso_canino/receta/receta_page.dart';
import 'package:paraiso_canino/resources/colors.dart';

class DetalleConsultaBody extends StatefulWidget {
  final ConsultaListModel? arguments;
  const DetalleConsultaBody({
    super.key,
    this.arguments,
  });

  @override
  State<DetalleConsultaBody> createState() => _DetalleConsultaBodyState();
}

class _DetalleConsultaBodyState extends State<DetalleConsultaBody> {
  final TextEditingController _citaController = TextEditingController();
  final TextEditingController _empleadoController = TextEditingController();
  final TextEditingController _sintomaController = TextEditingController();
  final TextEditingController _diagnosticoController = TextEditingController();

  List<CitaModel> _citasList = [];
  List<EmpleadoModel> _empleadosList = [];

  late String _selectedCitaId;
  late String _selectedEmpleadoId;
  int? _consultaId;

  @override
  void initState() {
    if (widget.arguments == null) {
      _getInitialList();
    } else {
      _setInitalValues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<DetalleconsultaBloc, DetalleconsultaState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (DetalleconsultaCitaListSuccess):
              final loadedState = state as DetalleconsultaCitaListSuccess;
              setState(() => _citasList = loadedState.citas);
              break;
            case const (DetalleconsultaEmpleadoListSuccess):
              final loadedState = state as DetalleconsultaEmpleadoListSuccess;
              setState(() => _empleadosList = loadedState.empleados);
              break;
            case const (ConsultaCreatedSuccess):
              final newConsulta = state as ConsultaCreatedSuccess;
              setState(() {
                _consultaId = newConsulta.idConsulta;
              });
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta creada',
              );
              break;
            case const (ConsultaEditedSuccess):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Consultas',
                description: 'Consulta editada',
              );
              break;
            case const (DetalleconsultaServiceError):
              final stateError = state as DetalleconsultaServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Detalle consulta',
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
            CustomForm(
              title: 'Detalle consulta',
              formContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.arguments == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomInputSelect(
                              title: 'Cita',
                              hint: 'Selecciona una cita',
                              valueItems: _citasList
                                  .map<String>((cita) => cita.idcita.toString())
                                  .toList(),
                              displayItems: _citasList
                                  .map<String>((cita) => cita.motivo)
                                  .toList(),
                              onSelected: (String? citaId) {
                                setState(() {
                                  _selectedCitaId = _citasList
                                      .firstWhere(
                                          (val) => val.motivo == citaId!)
                                      .idcita
                                      .toString();
                                });
                              },
                              controller: _citaController,
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            CustomInputSelect(
                              title: 'Empleado',
                              hint: 'Selecciona un empleado',
                              valueItems: _empleadosList
                                  .map<String>((empleado) =>
                                      empleado.idpuesto.toString())
                                  .toList(),
                              displayItems: _empleadosList
                                  .map<String>(
                                    (empleado) =>
                                        '${empleado.nombreEmpleado} ${empleado.apellidoEmpleado}',
                                  )
                                  .toList(),
                              onSelected: (String? empleadoId) {
                                setState(() {
                                  _selectedEmpleadoId = _empleadosList
                                      .firstWhere(
                                        (val) =>
                                            '${val.nombreEmpleado} ${val.apellidoEmpleado}' ==
                                            empleadoId!,
                                      )
                                      .idempleado
                                      .toString();
                                });
                              },
                              controller: _empleadoController,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Doctor:'),
                                Text(widget.arguments!.nombreEmpleado),
                              ],
                            ),
                            const SizedBox(
                              width: 80.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Cita:'),
                                Text(widget.arguments!.motivo),
                              ],
                            )
                          ],
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextArea(
                    labelText: 'Sintomas',
                    controller: _sintomaController,
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _consultaId != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ConsultaLaboratorioPage(),
                                ),
                              ),
                              text: 'Laboratorio',
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            CustomButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CrearRecetaPage(),
                                ),
                              ),
                              text: 'Receta',
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 41.0,
                        ),
                  CustomTextArea(
                    labelText: 'Diagnostico',
                    controller: _diagnosticoController,
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        if (widget.arguments == null) {
                          _saveNewConsulta();
                        } else {
                          _editConsulta();
                        }
                      },
                      text: 'Guardar',
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<DetalleconsultaBloc, BaseState>(
                builder: (context, state) {
              if (state is DetalleconsultaInProgress) {
                return const Loader();
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }

  void _setInitalValues() {
    final initValues = widget.arguments!;
    setState(() {
      _consultaId = initValues.idconsulta;
      _selectedCitaId = initValues.idcita.toString();
      _selectedEmpleadoId = initValues.idempleado.toString();
      _sintomaController.text = initValues.sintomas;
      _diagnosticoController.text = initValues.diagnostico;
    });
  }

  void _getInitialList() {
    context.read<DetalleconsultaBloc>()
      ..add(
        CitasListShown(),
      )
      ..add(
        EmpleadosListShown(),
      );
  }

  void _saveNewConsulta() {
    context.read<DetalleconsultaBloc>().add(
          ConsultaSaved(
            idcita: int.parse(_selectedCitaId),
            idempleado: int.parse(_selectedEmpleadoId),
            sintomas: _sintomaController.text,
            diagnostico: _diagnosticoController.text,
          ),
        );
  }

  void _editConsulta() {
    context.read<DetalleconsultaBloc>().add(
          ConsultaEdited(
            idconsulta: _consultaId!,
            idcita: int.parse(_selectedCitaId),
            idempleado: int.parse(_selectedEmpleadoId),
            sintomas: _sintomaController.text,
            diagnostico: _diagnosticoController.text,
          ),
        );
  }
}
