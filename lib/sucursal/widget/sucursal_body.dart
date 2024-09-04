import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/sucursal/bloc/sucursal_bloc.dart';
import 'package:paraiso_canino/sucursal/model/sucursal_response.dart';

class SucursalBody extends StatefulWidget {
  const SucursalBody({super.key});

  @override
  State<SucursalBody> createState() => _SucursalBodyState();
}

class _SucursalBodyState extends State<SucursalBody> {
  final TextEditingController searchOffices = TextEditingController();
  List<OfficeListModel> sucursales = [
    OfficeListModel(
      fechacreacion: 'fechacreacion',
      usuariocreacion: 'usuariocreacion',
      fechamodificacion: 'fechamodificacion',
      usuariomodificacion: 'usuariomodificacion',
      idsucursal: 1,
      name: 'name',
      direccion: 'direccion',
      usuario: 'usuario',
    ),
    OfficeListModel(
      fechacreacion: 'fechacreacion',
      usuariocreacion: 'usuariocreacion',
      fechamodificacion: 'fechamodificacion',
      usuariomodificacion: 'usuariomodificacion',
      idsucursal: 1,
      name: 'name',
      direccion: 'direccion',
      usuario: 'usuario',
    ),
    OfficeListModel(
      fechacreacion: 'fechacreacion',
      usuariocreacion: 'usuariocreacion',
      fechamodificacion: 'fechamodificacion',
      usuariomodificacion: 'usuariomodificacion',
      idsucursal: 1,
      name: 'name',
      direccion: 'direccion',
      usuario: 'usuario',
    ),
    OfficeListModel(
      fechacreacion: 'fechacreacion',
      usuariocreacion: 'usuariocreacion',
      fechamodificacion: 'fechamodificacion',
      usuariomodificacion: 'usuariomodificacion',
      idsucursal: 1,
      name: 'name',
      direccion: 'direccion',
      usuario: 'usuario',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // _getOfficeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillInputSelect,
      body: BlocListener<SucursalBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (SucursalSuccess):
              final loadedState = state as SucursalSuccess;
              setState(() => sucursales = loadedState.sucursales);
              break;
            case const (SucursalError):
              final stateError = state as SucursalError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Sucursales',
                description: stateError.message,
                isError: true,
              );
              break;
            case const (ServerClientError):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Error',
                description: 'En este momento no podemos atender tu solicitud.',
                isError: true,
              );
              break;
          }
        },
        child: Stack(
          children: [
            CustomTable(
              pageTitle: 'Sucursales',
              searchController: searchOffices,
              onTapSearchButton: () => _getOfficeList(),
              onTapAddButton: () {},
              headers: const [
                'iD',
                'Nombre sucursal',
                'Dirección',
                'Usuario',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
              ],
              rows: sucursales.map<Widget>((sucursal) {
                final index = sucursales.indexOf(sucursal);
                return MouseRegion(
                  onEnter: (event) => setState(() => sucursal.isHover = true),
                  onExit: (event) => setState(() => sucursal.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: sucursal.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('${sucursal.idsucursal}'),
                        ),
                        Expanded(
                          child: Text(sucursal.name),
                        ),
                        Expanded(
                          child: Text(sucursal.direccion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuario),
                        ),
                        Expanded(
                          child: Text(sucursal.fechacreacion),
                        ),
                        Expanded(
                          child: Text(sucursal.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(sucursal.usuariomodificacion),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            BlocBuilder<SucursalBloc, BaseState>(
              builder: (context, state) {
                if (state is SucursalInProgress) {
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

  void _getOfficeList() {
    context.read<SucursalBloc>().add(
          OfficeShown(),
        );
  }
}
