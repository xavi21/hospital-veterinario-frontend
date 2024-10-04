import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/detalle_hospitalizacion_page.dart';
import 'package:paraiso_canino/hospitalizacion/bloc/hospitalizacion_bloc.dart';
import 'package:paraiso_canino/hospitalizacion/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/resources/colors.dart';

class HospitalizacionBody extends StatefulWidget {
  const HospitalizacionBody({super.key});

  @override
  State<HospitalizacionBody> createState() => _HospitalizacionBodyState();
}

class _HospitalizacionBodyState extends State<HospitalizacionBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchHospitalizacion = TextEditingController();

  late List<HospitalizacionListModel> hospitalizaciones;

  @override
  void initState() {
    hospitalizaciones = [];
    super.initState();
    _getHospitalizacionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      body: BlocListener<HospitalizacionBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (HospitalizacionSuccess):
              final loadedState = state as HospitalizacionSuccess;
              setState(() => hospitalizaciones = loadedState.hospitalizaciones);
              break;
            case const (HospitalizacionEditedSuccess):
              _getHospitalizacionList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Hospitalizaciones',
                description: 'Hospitalizacion borrada',
              );
              break;
            case const (HospitalizacionError):
              final stateError = state as HospitalizacionError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Hospitalizaciones',
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
              pageTitle: 'Hospitalizaciones',
              searchController: _searchHospitalizacion,
              onChangeSearchButton: () => _getHospitalizacionList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetalleHospitalizacionPage(),
                  ),
                );
              },
              headers: const [
                'Mascota',
                'Genero',
                'Tipo Mascota',
                'Talla',
                'Color',
                'Peso',
                'Propietario',
                'Motivo',
                'Observaciones',
                '',
              ],
              rows: hospitalizaciones.map<Widget>((hospital) {
                final index = hospitalizaciones.indexOf(hospital);
                return MouseRegion(
                  onEnter: (event) => setState(() => hospital.isHover = true),
                  onExit: (event) => setState(() => hospital.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: hospital.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(hospital.nombreMascota),
                        ),
                        Expanded(
                          child: Text(hospital.nombreGenero),
                        ),
                        Expanded(
                          child: Text(hospital.nombreTipoMascota),
                        ),
                        Expanded(
                          child: Text(hospital.nombreTalla),
                        ),
                        Expanded(
                          child: Text(hospital.nombreColor),
                        ),
                        Expanded(
                          child: Text('${hospital.peso}'),
                        ),
                        Expanded(
                          child: Text(
                            '${hospital.nombrePropietario} ${hospital.apellidoPropietario}',
                          ),
                        ),
                        Expanded(
                          child: Text(hospital.motivo),
                        ),
                        Expanded(
                          child: Text(hospital.observaciones),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetalleHospitalizacionPage(
                                    arguments: hospital,
                                  ),
                                ),
                              );
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
            BlocBuilder<HospitalizacionBloc, BaseState>(
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

  void _filterTable() {
    setState(() {
      hospitalizaciones = hospitalizaciones
          .where(
            (element) => element.nombreMascota.toLowerCase().contains(
                  _searchHospitalizacion.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getHospitalizacionList() {
    context.read<HospitalizacionBloc>().add(
          HospitalizacionShown(),
        );
  }
}
