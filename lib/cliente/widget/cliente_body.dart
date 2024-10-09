import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cliente/bloc/cliente_bloc.dart';
import 'package:paraiso_canino/cliente/model/cliente_response.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';

class ClienteBody extends StatefulWidget {
  const ClienteBody({super.key});

  @override
  State<ClienteBody> createState() => _ClienteBodyState();
}

class _ClienteBodyState extends State<ClienteBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchCliente = TextEditingController();

  late List<ClienteListModel> clientes;

  @override
  void initState() {
    clientes = [];
    super.initState();
    _getClienteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      body: BlocListener<ClienteBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ClienteSuccess):
              final loadedState = state as ClienteSuccess;
              setState(() => clientes = loadedState.clientes);
              break;
            case const (ClienteDeletedSuccess):
              _getClienteList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
                description: 'Cliente borrado',
              );
              break;
            case const (ClienteError):
              final stateError = state as ClienteError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Clientes',
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
              pageTitle: 'Clientes',
              searchController: _searchCliente,
              onChangeSearchButton: () => _getClienteList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const DetalleClientePage(),
                //   ),
                // );
              },
              headers: const [
                'ID Cita',
                'ID Cliente',
                'Nombre mascota',
                'Motivo',
                'ID Empleado',
                'Empleado',
                'Sintomas',
                'Diagnostico',
                '',
              ],
              rows: clientes.map<Widget>((cliente) {
                final index = clientes.indexOf(cliente);
                return MouseRegion(
                  onEnter: (event) => setState(() => cliente.isHover = true),
                  onExit: (event) => setState(() => cliente.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: cliente.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${cliente.idcita}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${cliente.idcliente}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(cliente.nombreMascota),
                        ),
                        Expanded(
                          child: Text(cliente.motivo),
                        ),
                        Expanded(
                          child: Text(
                            '${cliente.idempleado}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${cliente.nombreEmpleado} ${cliente.apellidoEmpleado}',
                          ),
                        ),
                        Expanded(
                          child: Text(cliente.sintomas),
                        ),
                        Expanded(
                          child: Text(cliente.diagnostico),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => DetalleClientePage(
                              //       arguments: cliente,
                              //     ),
                              //   ),
                              // );
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
            BlocBuilder<ClienteBloc, BaseState>(
              builder: (context, state) {
                if (state is ClienteInProgress) {
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
      clientes = clientes
          .where(
            (element) => element.nombreEmpleado.toLowerCase().contains(
                  _searchCliente.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getClienteList() {
    context.read<ClienteBloc>().add(
          ClienteShown(),
        );
  }
}
