import 'package:flutter/material.dart';
import 'package:paraiso_canino/opciones/opciones_page.dart';
import 'package:paraiso_canino/sucursal/sucursal_page.dart';
import 'package:paraiso_canino/usuario/usuario_page.dart';

final Map<String, Widget> routes = {
  '': Container(),
  'Usuario': const UsuarioPage(),
  'Sucursal': const SucursalPage(),
  'Opcion': const OpcionesPage(),
  'Menu': Container(),
  'OpciondeUsuario': Container(),
  'Cita': Container(),
  'Consulta': Container(),
  'Hospitalización': Container(),
  'Grooming': Container(),
  'Laboratorio': Container(),
  'Cliente': Container(),
  'Mascota': Container(),
  'Talla': Container(),
  'Color': Container(),
  'Medicamento': Container(),
};
