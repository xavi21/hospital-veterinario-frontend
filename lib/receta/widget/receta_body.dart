import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/receta/bloc/receta_bloc.dart';
import 'package:paraiso_canino/receta/model/medicina_list_model.dart';
import 'package:paraiso_canino/receta/model/receta_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

import 'package:pdf/widgets.dart' as pw;

class CrearRecetaBody extends StatefulWidget {
  final int idConsulta;
  const CrearRecetaBody({
    super.key,
    required this.idConsulta,
  });

  @override
  State<CrearRecetaBody> createState() => _CrearRecetaBodyState();
}

class _CrearRecetaBodyState extends State<CrearRecetaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<FormState> _form0 = GlobalKey<FormState>();
  final TextEditingController _observacionesController =
      TextEditingController();
  final TextEditingController _medicamentoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _indicacionesController = TextEditingController();

  List<RecetaListModel> _recetasList = [];
  List<MedicinaListModel> _medicamentosList = [];

  late int? _idReceta;
  late int? _idMedicamento;
  late String _mascota;
  late String _medico;

  @override
  void initState() {
    _idReceta = null;
    _idMedicamento = null;
    _mascota = emptyString;
    _medico = emptyString;
    _getReceta();
    _getMedicamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _recetaForm(),
      backgroundColor: fillInputSelect,
      body: BlocListener<RecetaBloc, BaseState>(
        listener: (context, state) {
          if (state is ConsultaSuccess) {
            final data = state.consulta;
            setState(() {
              _idReceta = data.idreceta;
              _mascota = data.nombreMascota;
              _medico = '${data.nombreEmpleado} ${data.apellidoEmpleado}';
              _observacionesController.text = data.observaciones;
            });
            _getDetalleReceta();
          }
          if (state is RecetaMedicinasListSuccess) {
            setState(() {
              _medicamentosList = state.medicinas;
            });
          }
          if (state is RecetaCreatedSuccess) {
            _getReceta();
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Receta creada',
              description: 'Receta creada correctamente.',
            );
          }
          if (state is DetalleRecetaCreatedSuccess) {
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Detalle de Receta creada',
              description: 'Receta creada correctamente.',
            );
            _getDetalleReceta();
          }
          if (state is DetalleRecetasListSuccess) {
            setState(() {
              _recetasList = state.recetas;
            });
          }
          if (state is RecetaServiceError) {
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
              title: 'Receta',
              formContent: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          if (_form0.currentState!.validate()) {
                            _saveReceta();
                          }
                        },
                        text: 'Guardar',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _form0,
                    child: CustomTextArea(
                      isRequired: true,
                      controller: _observacionesController,
                      labelText: 'Observaciones',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _idReceta != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              onPressed: () => _generatePDF(),
                              text: 'PDF',
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            CustomButton(
                              onPressed: () =>
                                  _scaffoldKey.currentState!.openEndDrawer(),
                              text: 'Agregar',
                            ),
                          ],
                        )
                      : const SizedBox(height: 40),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      'ID Receta',
                      'Medicamento',
                      'Cantidad',
                      'Indicaciones',
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
                      children: _recetasList.map<Widget>((receta) {
                        final index = _recetasList.indexOf(receta);
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
                                    '${receta.idreceta}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(receta.nombreMedicamento),
                                ),
                                Expanded(
                                  child: Text(receta.cantidad.toString()),
                                ),
                                Expanded(
                                  child: Text(receta.indicaciones),
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
            BlocBuilder<RecetaBloc, BaseState>(
              builder: (context, state) {
                if (state is RecetaInProgress) {
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

  Widget _recetaForm([RecetaListModel? model]) {
    if (model != null) {
      setState(() {
        _medicamentoController.text = model.nombreMedicamento;
        _cantidadController.text = model.cantidad.toString();
        _indicacionesController.text = model.indicaciones;
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
                'Nueva Receta',
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
              CustomInput(
                isRequired: true,
                controller: _cantidadController,
                labelText: 'Cantidad',
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                isRequired: true,
                controller: _indicacionesController,
                labelText: 'Indicaciones',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate() &&
                      _medicamentoController.text.isNotEmpty) {
                    if (model != null) {
                      //TODO implementarendpoint de actualizar
                    } else {
                      context.read<RecetaBloc>().add(
                            DetalleRecetaSaved(
                              cantidad: int.parse(_cantidadController.text),
                              idReceta: _idReceta!,
                              idMedicamento: _idMedicamento!,
                              indicaciones: _indicacionesController.text,
                            ),
                          );
                    }
                    _medicamentoController.clear();
                    _indicacionesController.clear();
                    _cantidadController.clear();
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
                pw.Text(
                  'Paciente: $_mascota',
                  style: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Doctor: $_medico',
                  style: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
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
                  itemCount: _recetasList.length,
                  itemBuilder: (context, index) {
                    return pw.Bullet(
                      text: '${_recetasList[index].cantidad}-'
                          '${_recetasList[index].nombreMedicamento},'
                          '${_recetasList[index].indicaciones}',
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
      ..setAttribute('download', 'receta_medica.pdf')
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  void _getReceta() {
    context.read<RecetaBloc>().add(
          RecetaShown(
            idconsulta: widget.idConsulta,
          ),
        );
  }

  void _getMedicamentos() {
    context.read<RecetaBloc>().add(
          MedicinasListShown(),
        );
  }

  void _saveReceta() {
    context.read<RecetaBloc>().add(
          RecetaSaved(
            idconsulta: widget.idConsulta,
            observaciones: _observacionesController.text,
          ),
        );
  }

  void _getDetalleReceta() {
    context.read<RecetaBloc>().add(
          DetalleRecetaShown(
            idReceta: _idReceta!,
          ),
        );
  }
}
