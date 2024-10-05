import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/bloc/hospitalizacion_laboratorio_bloc.dart';

import 'package:paraiso_canino/hospitalizacion_laboratorio/model/lab_hospital_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class HospitalizacionLaboratorioBody extends StatefulWidget {
  final int idHospitalizacion;
  const HospitalizacionLaboratorioBody({
    super.key,
    required this.idHospitalizacion,
  });

  @override
  State<HospitalizacionLaboratorioBody> createState() =>
      _HospitalizacionLaboratorioBodyState();
}

class _HospitalizacionLaboratorioBodyState
    extends State<HospitalizacionLaboratorioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _requestDate = TextEditingController();
  final TextEditingController _resultDate = TextEditingController();
  final TextEditingController _labController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  List<LaboratorioListModel> _laboratoriosSelectList = [];
  List<LabHospitalListModel> _laboratoriosList = [];

  late int? _idLaboratorio;

  @override
  void initState() {
    _idLaboratorio = null;
    setState(() {
      _requestDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
    _getLaboratorioByConsulta();
    _getLaboratorios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _laboratorioForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<HospitalizacionLaboratorioBloc,
          HospitalizacionLaboratorioState>(
        listener: (context, state) {
          if (state is HospitalizacionLaboratorioListSuccess) {
            setState(() {
              _laboratoriosSelectList = state.laboratorios;
            });
          }
          if (state is LaboratorioCreatedSuccess) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'laboratorios',
              description: 'Laboratorio creado correctamente',
            );
            _getLaboratorioByConsulta();
          }
          if (state is HospitalizacionLaboratorioByConsultaSuccess) {
            setState(() {
              _laboratoriosList = state.laboratorios;
            });
          }
          if (state is HospitalizacionLaboratorioServiceError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'laboratorios',
              description: state.message,
              isError: true,
            );
          }
          if (state is ServerClientError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: 'En este momento no podemos atender tu solicitud.',
              isWarning: true,
            );
          }
        },
        child: Stack(
          children: [
            CustomForm(
              title: 'Consulta laboratorio',
              formContent: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: CustomInput(
                          controller: _requestDate,
                          labelText: 'Fecha solicitud',
                          isEnabled: false,
                        ),
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 90.0,
                          child: CustomButton(
                            onPressed: () =>
                                _scaffoldKey.currentState!.openEndDrawer(),
                            text: 'Agregar',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      'ID Laboratorio',
                      'Nombre',
                      'Descripcion',
                      'Fecha solicitud',
                      'Fecha resultado',
                      '',
                    ]
                        .map<Widget>(
                          (header) => Expanded(
                            child: Text(
                              header,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: _laboratoriosList.map<Widget>((lab) {
                        final index = _laboratoriosList.indexOf(lab);
                        return MouseRegion(
                          onEnter: (event) =>
                              setState(() => lab.isHover = true),
                          onExit: (event) =>
                              setState(() => lab.isHover = false),
                          child: Container(
                            height: 60.0,
                            color: lab.isHover
                                ? blue.withOpacity(0.1)
                                : index % 2 == 0
                                    ? fillInputSelect
                                    : white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${lab.idlaboratorio}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(lab.nombre),
                                ),
                                Expanded(
                                  child: Text(lab.descripcion),
                                ),
                                Expanded(
                                  child: Text(lab.fechasolicitud),
                                ),
                                Expanded(
                                  child: Text(lab.fecharesultado),
                                ),
                                PopupMenuButton(
                                  color: white,
                                  onSelected: (value) {
                                    if (value == TableRowActions.see) {
                                      _generatePdf();
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return const [
                                      PopupMenuItem(
                                        value: TableRowActions.see,
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
                  ),
                ],
              ),
            ),
            BlocBuilder<HospitalizacionLaboratorioBloc, BaseState>(
              builder: (context, state) {
                if (state is HospitalizacionLaboratorioInProgress) {
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

  Widget _laboratorioForm() {
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
                'Nuevo laboratorio',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () => _showDateDialog(),
                child: CustomInput(
                  isRequired: true,
                  isEnabled: false,
                  controller: _resultDate,
                  labelText: 'Fecha resultado',
                ),
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Laboratorio',
                valueItems: _laboratoriosSelectList
                    .map((laboratorio) => laboratorio.idLaboratorio.toString())
                    .toList(),
                displayItems: _laboratoriosSelectList
                    .map((laboratorio) => laboratorio.nombre)
                    .toList(),
                onSelected: (String? laboratorio) {
                  setState(() {
                    _idLaboratorio = _laboratoriosSelectList
                        .firstWhere((lab) => lab.nombre == laboratorio)
                        .idLaboratorio;
                  });
                },
                controller: _labController,
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                isRequired: true,
                controller: _resultController,
                labelText: 'Descripcion',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    _createLaboratorio();
                    _labController.clear();
                    _resultController.clear();
                    Navigator.pop(context);
                  }
                },
                text: 'Guardar',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _generatePdf() {}

  void _createLaboratorio() {
    context.read<HospitalizacionLaboratorioBloc>().add(
          LaboratorioCreated(
            idhospitalizacion: widget.idHospitalizacion,
            idlaboratorio: _idLaboratorio!,
            resultado: _resultController.text,
            fechasolicitud: _requestDate.text,
            fecharesultado: _resultDate.text,
          ),
        );
  }

  void _getLaboratorioByConsulta() {
    context.read<HospitalizacionLaboratorioBloc>().add(
          LaboratorioByHospitalShown(
            idhospitalizacion: widget.idHospitalizacion,
          ),
        );
  }

  void _getLaboratorios() {
    context.read<HospitalizacionLaboratorioBloc>().add(
          LaboratorioShown(),
        );
  }

  void _showDateDialog() async {
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
        _resultDate.text = formattedDate;
      });
    }
  }
}
