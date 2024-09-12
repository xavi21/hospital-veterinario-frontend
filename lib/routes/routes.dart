import 'package:flutter/material.dart';
import 'package:paraiso_canino/cita/cita_page.dart';
import 'package:paraiso_canino/color/color_page.dart';
import 'package:paraiso_canino/consulta/consulta_page.dart';
import 'package:paraiso_canino/laboratorio/laboratorio_page.dart';
import 'package:paraiso_canino/statusEmpleado/status_empleado_page.dart';
import 'package:paraiso_canino/statusUsuario/status_usuario_page.dart';
import 'package:paraiso_canino/tipoMascota/mascota_page.dart';
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
  'StatusUsuario': const StatusUsuarioPage(),
  'StatusEmpleado': const StatusEmpleadoPage(),
  'Ambulancias': Container(),
  'Talla': const TallaPage(),
  'Jaula': Container(), // T
  'TipoMascota': Container(), // T
  'EstadoCivil': Container(), // T
  'TipoDocumento': Container(),
  'Genero': Container(), // T
  'Color': const ColorPage(),
  'EstatusCita': Container(),
  'CasaMedica': Container(),
  'ComponentePrincipal': Container(),
  'TipoMedidaPeso': Container(),
  'Laboratorio': const LaboratorioPage(),
  'Menu': const MenuPage(),
  'Opcion': const OpcionesPage(),
  'OpciondeUsuario': const OpcionUsuarioPage(),
  'Persona': Container(), // T
  'Mascota': const TipoMascotaPage(),
  'Empleado': Container(),
  'Cita': const CitaPage(),
  'Consulta': const ConsultaPage(),
  'Receta': Container(),
  'Hospitalización': Container(),
  'Grooming': Container(),
  'Cliente': Container(),
  'Medicamento': Container(),
};
