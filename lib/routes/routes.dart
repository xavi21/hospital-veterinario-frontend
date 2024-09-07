import 'package:flutter/material.dart';
import 'package:paraiso_canino/cita/cita_page.dart';
import 'package:paraiso_canino/color/color_page.dart';
import 'package:paraiso_canino/laboratorio/laboratorio_page.dart';
import 'package:paraiso_canino/mascota/mascota_page.dart';
import 'package:paraiso_canino/menu/menu_page.dart';
import 'package:paraiso_canino/opcion_usuario/opcion_usuario_page.dart';
import 'package:paraiso_canino/opciones/opciones_page.dart';
import 'package:paraiso_canino/sucursal/sucursal_page.dart';
import 'package:paraiso_canino/talla/talla_page.dart';
import 'package:paraiso_canino/usuario/usuario_page.dart';

final Map<String, Widget> routes = {
  '': Container(),
  'Usuario': const UsuarioPage(),
  'Sucursal': const SucursalPage(),
  'Opcion': const OpcionesPage(),
  'Menu': const MenuPage(),
  'OpciondeUsuario': const OpcionUsuarioPage(),
  'Cita': const CitaPage(),
  'Consulta': Container(),
  'Hospitalización': Container(),
  'Grooming': Container(),
  'Laboratorio': const LaboratorioPage(),
  'Cliente': Container(),
  'Mascota': const MascotaPage(),
  'Talla': const TallaPage(),
  'Color': const ColorPage(),
  'Medicamento': Container(),
};
