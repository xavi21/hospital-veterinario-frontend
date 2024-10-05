import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/bloc/hospitalizacionmedicamento_bloc.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/hospitalizacion_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/medicina_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

import 'package:pdf/widgets.dart' as pw;

class HospitalizacionMedicamentoBody extends StatefulWidget {
  final int idhospitalizacion;
  const HospitalizacionMedicamentoBody({
    super.key,
    required this.idhospitalizacion,
  });

  @override
  State<HospitalizacionMedicamentoBody> createState() =>
      _HospitalizacionMedicamentoBodyState();
}

class _HospitalizacionMedicamentoBodyState
    extends State<HospitalizacionMedicamentoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _observacionesController =
      TextEditingController();
  final TextEditingController _medicamentoController = TextEditingController();

  List<HospitalizacionListModel> _hospitalizacionsList = [];
  List<MedicinaListModel> _medicamentosList = [];

  late int? _idMedicamento;

  @override
  void initState() {
    _idMedicamento = null;
    _getHospitalizacion();
    _getMedicamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _hospitalizacionForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<HospitalizacionmedicamentoBloc, BaseState>(
        listener: (context, state) {
          if (state is HospitalizacionListSuccess) {
            setState(() {
              _hospitalizacionsList = state.hospitalizaciones;
            });
          }
          if (state is MedicinasListSuccess) {
            setState(() {
              _medicamentosList = state.medicinas;
            });
          }
          if (state is HospitalCreatedSuccess) {
            _getHospitalizacion();
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Hospitalizacion',
              description: 'Hospitalizacion creada correctamente.',
            );
          }
          if (state is HospitalEditedSuccess) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Hospitalizacion',
              description: 'Hospitalizacion editada correctamente.',
            );
          }
          if (state is HospitalizacionError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: state.message,
              isWarning: true,
            );
          }
          if (state is ServerClientError) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: 'En este momento no podemos atender tu solicitud.',
              isError: true,
            );
          }
        },
        child: Stack(
          children: [
            CustomForm(
              title: 'Medicamento',
              formContent: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _idMedicamento != null
                          ? CustomButton(
                              onPressed: () => _generatePDF(),
                              text: 'PDF',
                            )
                          : const SizedBox(height: 40),
                      const SizedBox(
                        width: 12.0,
                      ),
                      CustomButton(
                        onPressed: () =>
                            _scaffoldKey.currentState!.openEndDrawer(),
                        text: 'Agregar',
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
                      'Medicamento',
                      'Casa medica',
                      'Nombre comercial',
                      'observaciones',
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
                      children:
                          _hospitalizacionsList.map<Widget>((hospitalizacion) {
                        final index =
                            _hospitalizacionsList.indexOf(hospitalizacion);
                        return MouseRegion(
                          onEnter: (event) =>
                              setState(() => hospitalizacion.isHover = true),
                          onExit: (event) =>
                              setState(() => hospitalizacion.isHover = false),
                          child: Container(
                            height: 60.0,
                            color: hospitalizacion.isHover
                                ? blue.withOpacity(0.1)
                                : index % 2 == 0
                                    ? fillInputSelect
                                    : white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    hospitalizacion.nombre,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(hospitalizacion.nombreCasaMedica),
                                ),
                                Expanded(
                                  child: Text(hospitalizacion.nombrecomercial),
                                ),
                                Expanded(
                                  child: Text(hospitalizacion.observaciones),
                                ),
                                PopupMenuButton(
                                  color: white,
                                  onSelected: (value) {},
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
                  ),
                ],
              ),
            ),
            BlocBuilder<HospitalizacionmedicamentoBloc, BaseState>(
              builder: (context, state) {
                if (state is HospitalizacionInProgress) {
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

  Widget _hospitalizacionForm([HospitalizacionListModel? model]) {
    if (model != null) {
      setState(() {
        _medicamentoController.text = model.nombre;
        _observacionesController.text = model.observaciones;
      });
    }
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
                'Nuevo Medicamento',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInputSelect(
                title: 'Medicamento',
                valueItems: _medicamentosList
                    .map((medicamento) => medicamento.idmedicamento.toString())
                    .toList(),
                displayItems: _medicamentosList
                    .map((medicamento) => medicamento.nombre)
                    .toList(),
                onSelected: (String? medicamento) {
                  setState(() {
                    _idMedicamento = _medicamentosList
                        .firstWhere(
                            (medicina) => medicina.nombre == medicamento)
                        .idmedicamento;
                  });
                },
                controller: _medicamentoController,
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                isRequired: true,
                controller: _observacionesController,
                labelText: 'Observaciones',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate() &&
                      _medicamentoController.text.isNotEmpty) {
                    context.read<HospitalizacionmedicamentoBloc>().add(
                          HospitalizacionSaved(
                            idhospitalizacion: widget.idhospitalizacion,
                            idMedicamento: _idMedicamento!,
                            observaciones: _observacionesController.text,
                          ),
                        );
                    _medicamentoController.clear();
                    _observacionesController.clear();
                    Navigator.pop(context);
                  }
                },
                text: model != null ? 'Editar' : 'Guardar',
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'RECETA MÉDICA',
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Prescripción:',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                pw.Divider(),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Medicamentos:',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.ListView.builder(
                  itemCount: _hospitalizacionsList.length,
                  itemBuilder: (context, index) {
                    return pw.Bullet(
                      text: '${_hospitalizacionsList[index].nombre}-'
                          '${_hospitalizacionsList[index].nombreComponentePrincipal},'
                          '${_hospitalizacionsList[index].observaciones}',
                    );
                  },
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Observaciones:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  _observacionesController.text,
                  style: const pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 40),
                pw.Text(
                  'Firma: _______________________',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ],
            ),
          ); // Center
        },
      ),
    );

    final Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', 'hospitalizacion_medica.pdf')
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  void _getHospitalizacion() {
    context.read<HospitalizacionmedicamentoBloc>().add(
          HospitalizacionShown(
            idhospitalizacion: widget.idhospitalizacion,
          ),
        );
  }

  void _getMedicamentos() {
    context.read<HospitalizacionmedicamentoBloc>().add(
          MedicinasListShown(),
        );
  }

  void _saveHospitalizacion() {
    context.read<HospitalizacionmedicamentoBloc>().add(
          HospitalizacionSaved(
            idhospitalizacion: widget.idhospitalizacion,
            idMedicamento: 0,
            observaciones: _observacionesController.text,
          ),
        );
  }
}
