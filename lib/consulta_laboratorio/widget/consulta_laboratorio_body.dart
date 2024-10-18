import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/consulta_laboratorio/bloc/consultalaboratorio_bloc.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/consulta_laboratorio_model.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:intl/intl.dart';
import 'package:paraiso_canino/resources/constants.dart';

import 'package:pdf/widgets.dart' as pw;

class ConsultaLaboratorioBody extends StatefulWidget {
  final int idConsulta;
  const ConsultaLaboratorioBody({
    super.key,
    required this.idConsulta,
  });

  @override
  State<ConsultaLaboratorioBody> createState() =>
      _ConsultaLaboratorioBodyState();
}

class _ConsultaLaboratorioBodyState extends State<ConsultaLaboratorioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _requestDate = TextEditingController();
  final TextEditingController _resultDate = TextEditingController();
  final TextEditingController _labController = TextEditingController();
  final TextEditingController _description = TextEditingController();

  List<LaboratorioListModel> _laboratoriosSelectList = [];
  List<ConsultaLaboratorioModel> _laboratoriosList = [];

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
      body: BlocListener<ConsultalaboratorioBloc, ConsultalaboratorioState>(
        listener: (context, state) {
          if (state is ConsultalaboratorioListSuccess) {
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
          if (state is ConsultalaboratorioByConsultaSuccess) {
            setState(() {
              _laboratoriosList = state.laboratorios;
            });
          }
          if (state is ConsultalaboratorioServiceError) {
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
                              onPressed: () => _generatePDF(),
                              text: 'Generar PDF'),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
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
                      children: _laboratoriosList.map<Widget>((receta) {
                        final index = _laboratoriosList.indexOf(receta);
                        return MouseRegion(
                          onEnter: (event) =>
                              setState(() => receta.isHover = true),
                          onExit: (event) =>
                              setState(() => receta.isHover = false),
                          child: Container(
                            height: 60.0,
                            color: receta.isHover
                                ? blue.withOpacity(0.1)
                                : index % 2 == 0
                                    ? fillInputSelect
                                    : white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${receta.idlaboratorio}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(receta.nombre),
                                ),
                                Expanded(
                                  child: Text(receta.descripcion),
                                ),
                                Expanded(
                                  child: Text(receta.fechasolicitud),
                                ),
                                Expanded(
                                  child: Text(receta.fecharesultado),
                                ),
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
            BlocBuilder<ConsultalaboratorioBloc, BaseState>(
              builder: (context, state) {
                if (state is ConsultalaboratorioInProgress) {
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
                controller: _description,
                labelText: 'Descripcion',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    _createLaboratorio();
                    _labController.clear();
                    _description.clear();
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

  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    final ByteData logoBytes = await rootBundle.load('${imagePath}logo.jpg');
    final Uint8List imageData = logoBytes.buffer.asUint8List();
    final pw.ImageProvider logo = pw.MemoryImage(imageData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Image(logo, height: 130),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Examenes de laboratorio',
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text(
                  'Paciente: _______________',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 5.0),
                pw.Text(
                  'Doctor: __________________',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Divider(),
                pw.SizedBox(height: 5.0),
                pw.Text(
                  'Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Laboratorios :',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.ListView.builder(
                  itemCount: _laboratoriosList.length,
                  itemBuilder: (context, index) {
                    return pw.Bullet(
                      text: '${_laboratoriosList[index].nombre} - '
                          '${_laboratoriosList[index].descripcion}',
                    );
                  },
                ),
                pw.SizedBox(height: 120),
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

  void _createLaboratorio() {
    context.read<ConsultalaboratorioBloc>().add(
          LaboratorioCreated(
            idconsulta: widget.idConsulta,
            idlaboratorio: _idLaboratorio!,
            resultado: _description.text,
            fechasolicitud: _requestDate.text,
            fecharesultado: _resultDate.text,
          ),
        );
  }

  void _getLaboratorioByConsulta() {
    context.read<ConsultalaboratorioBloc>().add(
          LaboratorioByConsultaShown(
            idConsulta: widget.idConsulta,
          ),
        );
  }

  void _getLaboratorios() {
    context.read<ConsultalaboratorioBloc>().add(
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
