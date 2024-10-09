import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/genero/bloc/genero_bloc.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/resources/colors.dart';

class GeneroBody extends StatefulWidget {
  const GeneroBody({super.key});

  @override
  State<GeneroBody> createState() => _GeneroBodyState();
}

class _GeneroBodyState extends State<GeneroBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchGenero = TextEditingController();

  late List<GeneroListModel> generos;

  @override
  void initState() {
    generos = [];
    super.initState();
    _getGeneroList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: fillInputSelect,
      body: BlocListener<GeneroBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (GeneroSuccess):
              final loadedState = state as GeneroSuccess;
              setState(() => generos = loadedState.genero);
              break;
            case const (GeneroDeletedSuccess):
              _getGeneroList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Genero',
                description: 'Genero borrado',
              );
              break;
            case const (GeneroError):
              final stateError = state as GeneroError;
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Genero',
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
              pageTitle: 'Genero',
              searchController: _searchGenero,
              onChangeSearchButton: () => _getGeneroList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const DetalleGeneroPage(),
                //   ),
                // );
              },
              headers: const [
                'ID Genero',
                'Nombre',
                'Fecha de creación',
                '',
              ],
              rows: generos.map<Widget>((genero) {
                final index = generos.indexOf(genero);
                return MouseRegion(
                  onEnter: (event) => setState(() => genero.isHover = true),
                  onExit: (event) => setState(() => genero.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: genero.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${genero.idGenero}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            genero.nombre,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(genero.fechacreacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.edit) {
                              // Navigator.of(context).push(
                              // MaterialPageRoute(
                              //   builder: (context) => DetalleGeneroPage(
                              //     arguments: genero,
                              //   ),
                              // ),
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
            BlocBuilder<GeneroBloc, BaseState>(
              builder: (context, state) {
                if (state is GeneroInProgress) {
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
      generos = generos
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchGenero.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getGeneroList() {
    context.read<GeneroBloc>().add(
          GeneroShown(),
        );
  }
}
