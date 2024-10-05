import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/bloc/detallehospitalizacion_bloc.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/jaula_list_model.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/mascota_list_model.dart';
import 'package:paraiso_canino/hospitalizacion/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/hospitalizacion_laboratorio_page.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/hospitalizacion_medicamento_page.dart';
import 'package:paraiso_canino/resources/colors.dart';

class DetallehospitalizacionBody extends StatefulWidget {
  final HospitalizacionListModel? arguments;
  const DetallehospitalizacionBody({super.key, this.arguments});

  @override
  State<DetallehospitalizacionBody> createState() =>
      _DetallehospitalizacionBodyState();
}

class _DetallehospitalizacionBodyState
    extends State<DetallehospitalizacionBody> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _mascotaController = TextEditingController();
  final TextEditingController _jaulaController = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _finalDate = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController _observacionController = TextEditingController();

  List<MascotaModel> _mascotasList = [];
  List<JaulaModel> _jaulasList = [];

  late int _selectedMascotaId;
  late int _selectedJaulaId;
  int? _hospitalizacionId;

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
      body:
          BlocListener<DetallehospitalizacionBloc, DetallehospitalizacionState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (HospitalizacionMascotaSuccess):
              final loadedState = state as HospitalizacionMascotaSuccess;
              setState(() => _mascotasList = loadedState.mascotas);
              break;
            case const (DetalleHospitalizacionJaulaListSuccess):
              final loadedState =
                  state as DetalleHospitalizacionJaulaListSuccess;
              setState(() => _jaulasList = loadedState.jaulas);
              break;
            case const (HospitalizacionCreatedSuccess):
              final newHospitalizacion = state as HospitalizacionCreatedSuccess;
              setState(() {
                _hospitalizacionId = newHospitalizacion.idHospitalizacion;
              });
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Hospitalizacion',
                description: 'Hospitalizacion creada',
              );
              break;
            case const (HospitalizacionEditedSuccess):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Hospitalizacion',
                description: 'Hospitalizacion editada',
              );
              break;
            case const (DetalleHospitalizacionServiceError):
              final stateError = state as DetalleHospitalizacionServiceError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Detalle hospitalizacion',
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
            Form(
              key: _form,
              child: CustomForm(
                title: 'Hospitalizaciones',
                formContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.arguments == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomInputSelect(
                                  title: 'Mascota',
                                  hint: 'Selecciona una mascota',
                                  valueItems: _mascotasList
                                      .map<String>((mascota) =>
                                          mascota.idmascota.toString())
                                      .toList(),
                                  displayItems: _mascotasList
                                      .map<String>(
                                          (mascota) => mascota.nombreMascota)
                                      .toList(),
                                  onSelected: (String? mascotaId) {
                                    setState(() {
                                      _selectedMascotaId = _mascotasList
                                          .firstWhere((val) =>
                                              val.nombreMascota == mascotaId!)
                                          .idmascota;
                                    });
                                  },
                                  controller: _mascotaController,
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: CustomInputSelect(
                                  title: 'Jaula',
                                  hint: 'Selecciona un jaula',
                                  valueItems: _jaulasList
                                      .map<String>(
                                          (jaula) => jaula.idJaula.toString())
                                      .toList(),
                                  displayItems: _jaulasList
                                      .map<String>((jaula) => jaula.descripcion)
                                      .toList(),
                                  onSelected: (String? jaulaId) {
                                    setState(() {
                                      _selectedJaulaId = _jaulasList
                                          .firstWhere((val) =>
                                              val.descripcion == jaulaId!)
                                          .idJaula;
                                    });
                                  },
                                  controller: _jaulaController,
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      _showDateDialog(typeDate: 'start'),
                                  child: CustomInput(
                                    isRequired: true,
                                    isEnabled: false,
                                    controller: _startDate,
                                    labelText: 'Fecha de ingreso',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      _showDateDialog(typeDate: 'final'),
                                  child: CustomInput(
                                    isRequired: true,
                                    isEnabled: false,
                                    controller: _finalDate,
                                    labelText: 'Fecha de salida',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Mascota:'),
                                    Text(
                                      widget.arguments!.nombreMascota,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 80.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Jaula:'),
                                    Text(widget.arguments!.idjaula.toString()),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      _showDateDialog(typeDate: 'start'),
                                  child: CustomInput(
                                    isRequired: true,
                                    isEnabled: false,
                                    controller: _startDate,
                                    labelText: 'Fecha de ingreso',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      _showDateDialog(typeDate: 'final'),
                                  child: CustomInput(
                                    isRequired: true,
                                    isEnabled: false,
                                    controller: _finalDate,
                                    labelText: 'Fecha de salida',
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextArea(
                      labelText: 'Motivo',
                      controller: _motivoController,
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _hospitalizacionId != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HospitalizacionLaboratorioPage(
                                        idHospitalizacion: _hospitalizacionId!,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Laboratorio',
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              CustomButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HospitalizacionMedicamentoPage(
                                        idhospitalizacion: _hospitalizacionId!,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Medicamentos',
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 41.0,
                          ),
                    CustomTextArea(
                      labelText: 'Observaciones',
                      controller: _observacionController,
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            if (widget.arguments == null) {
                              _saveNewHospitalizacion();
                            } else {
                              _editHospitalizacion();
                            }
                          }
                        },
                        text: 'Guardar',
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<DetallehospitalizacionBloc, BaseState>(
                builder: (context, state) {
              if (state is DetalleHospitalizacionInProgress) {
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
      _hospitalizacionId = initValues.idhospitalizacion;
      _selectedMascotaId = initValues.idmascota;
      _selectedJaulaId = initValues.idjaula;
      _startDate.text = initValues.fechaingreso;
      _finalDate.text = initValues.fechasalida;
      _motivoController.text = initValues.motivo;
      _observacionController.text = initValues.observaciones;
    });
  }

  void _getInitialList() {
    context.read<DetallehospitalizacionBloc>()
      ..add(
        MascotasListShown(),
      )
      ..add(
        JaulasListShown(),
      );
  }

  void _saveNewHospitalizacion() {
    context.read<DetallehospitalizacionBloc>().add(
          HospitalizacionSaved(
            idmascota: _selectedMascotaId,
            idjaula: _selectedJaulaId,
            fechaingreso: _startDate.text,
            fechasalida: _finalDate.text,
            motivo: _motivoController.text,
            observaciones: _observacionController.text,
          ),
        );
  }

  void _editHospitalizacion() {
    context.read<DetallehospitalizacionBloc>().add(
          HospitalizacionEdited(
            idhospitalizacion: _hospitalizacionId!,
            idmascota: _selectedMascotaId,
            idjaula: _selectedJaulaId,
            fechaingreso: _startDate.text,
            fechasalida: _finalDate.text,
            motivo: _motivoController.text,
            observaciones: _observacionController.text,
          ),
        );
  }

  void _showDateDialog({required String typeDate}) async {
    final currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(
        currentDate.year + 10,
        currentDate.month,
        currentDate.day,
      ),
      helpText: 'Selecciona la fecha ',
      confirmText: 'Confirmar',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: lightBlue,
              onPrimary: darkBlue,
              onSurface: darkBlue,
              secondary: darkBlue,
              brightness: Brightness.light,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: darkBlue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        if (typeDate == 'start') {
          _startDate.text = formattedDate;
        } else {
          _finalDate.text = formattedDate;
        }
      });
    }
  }
}
