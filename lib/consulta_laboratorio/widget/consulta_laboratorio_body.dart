import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:intl/intl.dart';

class ConsultaLaboratorioBody extends StatefulWidget {
  const ConsultaLaboratorioBody({super.key});

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

  final List<String> _laboratoriosList = [
    'Zona 1',
    'Fraijanes',
    'Pinula',
    'Pradera Vistares',
    'Vista hermosa',
    'Villa nueva',
    'El progreso',
    'Gustatoya',
    'Test',
  ];

  final List<LaboratorioListModel> _labDataList = [];

  @override
  void initState() {
    setState(() {
      _requestDate.text = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _laboratorioForm(),
      backgroundColor: fillInputSelect,
      body: CustomForm(
        title: 'Consulta laboratorio',
        formContent: Column(
          children: [
            Row(
              children: [
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
                  child: CustomInput(
                    controller: _resultDate,
                    labelText: 'Fecha resultado',
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
                children: _labDataList.map<Widget>((receta) {
                  final index = _labDataList.indexOf(receta);
                  return MouseRegion(
                    onEnter: (event) => setState(() => receta.isHover = true),
                    onExit: (event) => setState(() => receta.isHover = false),
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
                              '${receta.idLaboratorio}',
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
                            child: Text(receta.fechaSolicitud),
                          ),
                          Expanded(
                            child: Text(receta.fechaResultado),
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
            ),
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
                'Nueva Receta',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20.0),
              CustomInputSelect(
                title: 'Medicamento',
                valueItems: _laboratoriosList,
                displayItems: _laboratoriosList,
                onSelected: (laboratorio) {},
                controller: _labController,
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                controller: _description,
                labelText: 'Descripcion',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    setState(() {
                      _labDataList.add(
                        LaboratorioListModel(
                          fechaSolicitud: _requestDate.text,
                          fechaResultado: _resultDate.text,
                          idLaboratorio: _labDataList.length + 1,
                          nombre: _labController.text,
                          descripcion: _description.text,
                        ),
                      );
                    });
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
}
