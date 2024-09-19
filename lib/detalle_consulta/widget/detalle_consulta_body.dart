import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/form/custom_form.dart';
import 'package:paraiso_canino/common/input/custom_input_select.dart';
import 'package:paraiso_canino/common/input/custom_text_area.dart';
import 'package:paraiso_canino/consulta_laboratorio/consulta_laboratorio_page.dart';
import 'package:paraiso_canino/receta/receta_page.dart';
import 'package:paraiso_canino/detalle_consulta/model/cita_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/model/empleado_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class DetalleConsultaBody extends StatefulWidget {
  const DetalleConsultaBody({super.key});

  @override
  State<DetalleConsultaBody> createState() => _DetalleConsultaBodyState();
}

class _DetalleConsultaBodyState extends State<DetalleConsultaBody> {
  final TextEditingController _citaController = TextEditingController();
  final TextEditingController _empleadoController = TextEditingController();
  final TextEditingController _sintomaController = TextEditingController();
  final TextEditingController _diagnosticoController = TextEditingController();

  final List<CitaListModel> _citasList = [
    CitaListModel(idestatuscita: 1, nombre: 'Lesión muscular'),
    CitaListModel(idestatuscita: 2, nombre: 'Dolor de oido'),
    CitaListModel(idestatuscita: 3, nombre: 'Chequeo medico'),
    CitaListModel(idestatuscita: 4, nombre: 'Radiografia'),
    CitaListModel(idestatuscita: 5, nombre: 'Endoscopia'),
    CitaListModel(idestatuscita: 6, nombre: 'Lesión muscular'),
    CitaListModel(idestatuscita: 7, nombre: 'Dolor de oido'),
    CitaListModel(idestatuscita: 8, nombre: 'Chequeo medico'),
    CitaListModel(idestatuscita: 9, nombre: 'Radiografia'),
    CitaListModel(idestatuscita: 10, nombre: 'Endoscopia'),
  ];
  final List<EmpleadoListModel> _empleadosList = [
    EmpleadoListModel(nombre: 'Jorge', apellido: 'Mendizabal', idpuesto: 1),
    EmpleadoListModel(nombre: 'Armando', apellido: 'Paredes', idpuesto: 1),
    EmpleadoListModel(nombre: 'Jessica', apellido: 'Rodriguez', idpuesto: 1),
    EmpleadoListModel(nombre: 'Pedro', apellido: 'Alvarado', idpuesto: 1),
    EmpleadoListModel(nombre: 'Mario', apellido: 'Perez', idpuesto: 1),
    EmpleadoListModel(nombre: 'Jorge', apellido: 'Mendizabal', idpuesto: 1),
    EmpleadoListModel(nombre: 'Armando', apellido: 'Paredes', idpuesto: 1),
    EmpleadoListModel(nombre: 'Jessica', apellido: 'Rodriguez', idpuesto: 1),
    EmpleadoListModel(nombre: 'Pedro', apellido: 'Alvarado', idpuesto: 1),
    EmpleadoListModel(nombre: 'Mario', apellido: 'Perez', idpuesto: 1),
  ];

  late String _selectedCitaId;
  late String _selectedEmpleadoId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: CustomForm(
        title: 'Detalle consulta',
        formContent: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInputSelect(
                  title: 'Cita',
                  hint: 'Selecciona una cita',
                  valueItems: _citasList
                      .map<String>((cita) => cita.idestatuscita.toString())
                      .toList(),
                  displayItems:
                      _citasList.map<String>((cita) => cita.nombre).toList(),
                  onSelected: (String? citaId) {
                    setState(() {
                      _selectedCitaId = citaId!;
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
                      .map<String>((empleado) => empleado.idpuesto.toString())
                      .toList(),
                  displayItems: _empleadosList
                      .map<String>(
                        (empleado) => '${empleado.nombre} ${empleado.apellido}',
                      )
                      .toList(),
                  onSelected: (String? empleadoId) {
                    setState(() {
                      _selectedEmpleadoId = empleadoId!;
                    });
                  },
                  controller: _empleadoController,
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ConsultaLaboratorioPage(),
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
                onPressed: () {},
                text: 'Guardar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
