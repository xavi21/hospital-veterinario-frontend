import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/receta/model/receta_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CrearRecetaBody extends StatefulWidget {
  const CrearRecetaBody({super.key});

  @override
  State<CrearRecetaBody> createState() => _CrearRecetaBodyState();
}

class _CrearRecetaBodyState extends State<CrearRecetaBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _observacionesController =
      TextEditingController();
  final TextEditingController _medicamentoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _indicacionesController = TextEditingController();

  List<RecetaListModel> _recetasList = [];
  final List<String> _medicamentosList = [
    'Carprofeno',
    'Amoxicilina',
    'Fenbendazol',
    'Difenhidramina',
    'Prednisona',
    'Pimobendano',
    'Fluoxetina',
    'Glucosamina',
    'Fenobarbital',
    'Omeprazol',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _recetaForm(),
      backgroundColor: fillInputSelect,
      body: CustomForm(
        title: 'Receta',
        formContent: Column(
          children: [
            CustomTextArea(
              controller: _observacionesController,
              labelText: 'Observaciones',
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {},
                  text: 'PDF',
                ),
                const SizedBox(
                  width: 12.0,
                ),
                CustomButton(
                  onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
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
                              '${receta.idreceta}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(receta.medicamento),
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

  Widget _recetaForm() {
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
                valueItems: _medicamentosList,
                displayItems: _medicamentosList,
                onSelected: (medicamento) {},
                controller: _medicamentoController,
              ),
              const SizedBox(height: 12.0),
              CustomInputSelect(
                title: 'Cantidad',
                valueItems: _cantidad(),
                displayItems: _cantidad(),
                onSelected: (cantidad) {},
                controller: _cantidadController,
              ),
              const SizedBox(height: 12.0),
              CustomTextArea(
                controller: _indicacionesController,
                labelText: 'Indicaciones',
              ),
              const SizedBox(height: 12.0),
              CustomButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    setState(() {
                      _recetasList.add(
                        RecetaListModel(
                          medicamento: _medicamentoController.text,
                          indicaciones: _indicacionesController.text,
                          cantidad: int.parse(_cantidadController.text),
                          idreceta: _recetasList.length + 1,
                        ),
                      );
                    });
                    _medicamentoController.clear();
                    _indicacionesController.clear();
                    _cantidadController.clear();
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

  List<String> _cantidad() {
    List<String> cantidad = [];
    for (var i = 0; i < 50; i++) {
      cantidad.add('$i');
    }
    return cantidad;
  }
}
