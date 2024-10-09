import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/enum/action_emum.dart';
import 'package:paraiso_canino/common/table/custom_table.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/usuario/model/usuario_list_model.dart';

class UsuarioBody extends StatefulWidget {
  const UsuarioBody({super.key});

  @override
  State<UsuarioBody> createState() => _UsuarioBodyState();
}

class _UsuarioBodyState extends State<UsuarioBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _searchUsuarios = TextEditingController();

  late List<UsuarioListModel> usuarios;

  late bool _isEdit;
  late int _usuariosId;

  @override
  void initState() {
    _isEdit = false;
    usuarios = [];
    _getUsuariosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CustomTable(
              pageTitle: 'Usuarios',
              searchController: _searchUsuarios,
              onChangeSearchButton: () => _getUsuariosList(),
              onTapSearchButton: () => _filterTable(),
              onTapAddButton: () {
                setState(() {
                  _name.clear();
                });
                _scaffoldKey.currentState!.openEndDrawer();
              },
              headers: const [
                'ID',
                'Usuario',
                'Fecha creación',
                'Fecha modificación',
                'Usuario creador',
                'Usuario modificador',
                '',
              ],
              rows: usuarios.map<Widget>((usuario) {
                final index = usuarios.indexOf(usuario);
                return MouseRegion(
                  onEnter: (event) => setState(() => usuario.isHover = true),
                  onExit: (event) => setState(() => usuario.isHover = false),
                  child: Container(
                    height: 60.0,
                    color: usuario.isHover
                        ? blue.withOpacity(0.1)
                        : index % 2 == 0
                            ? fillInputSelect
                            : white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${usuario.idusuario}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(usuario.nombre),
                        ),
                        Expanded(
                          child: Text(usuario.fechacreacion),
                        ),
                        Expanded(
                          child: Text(usuario.fechamodificacion),
                        ),
                        Expanded(
                          child: Text(usuario.usuariocreacion),
                        ),
                        Expanded(
                          child: Text(usuario.usuariomodificacion),
                        ),
                        PopupMenuButton(
                          color: white,
                          onSelected: (value) {
                            if (value == TableRowActions.delete) {
                              _deleteUsuario(
                                id: usuario.idusuario,
                              );
                            }
                            if (value == TableRowActions.edit) {
                              setState(() {
                                _isEdit = true;
                                _name.text = usuario.nombre;
                                _usuariosId = usuario.idusuario;
                              });
                              _scaffoldKey.currentState!.openEndDrawer();
                            }
                          },
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
          ],
        ),
      ),
    );
  }

  void _filterTable() {
    setState(() {
      usuarios = usuarios
          .where(
            (element) => element.nombre.toLowerCase().contains(
                  _searchUsuarios.text.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  void _getUsuariosList() {
    // context.read<UsuarioBloc>().add(
    //       UsuarioShown(),
    //     );
  }

  void _saveNewUsuario() {
    // context.read<UsuarioBloc>().add(
    //       UsuarioSaved(
    //         name: _name.text,
    //       ),
    //     );
  }

  void _deleteUsuario({required int id}) {
    // context.read<UsuarioBloc>().add(
    //       UsuarioDeleted(
    //         usuarioId: id,
    //       ),
    //     );
  }

  void _updateUsuario({required int id}) {
    // context.read<UsuarioBloc>().add(
    //       UsuarioEdited(
    //         id: id,
    //         name: _name.text,
    //       ),
    //     );
  }
}
