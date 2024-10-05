import 'package:flutter/material.dart';
import 'package:paraiso_canino/ambulancia/ambulancia_page.dart';
import 'package:paraiso_canino/cita/cita_page.dart';
import 'package:paraiso_canino/color/color_page.dart';
import 'package:paraiso_canino/consulta/consulta_page.dart';
import 'package:paraiso_canino/empleado/empleado_page.dart';
import 'package:paraiso_canino/grooming/grooming_page.dart';
import 'package:paraiso_canino/hospitalizacion/hospitalizacion_page.dart';
import 'package:paraiso_canino/jaula/jaula_page.dart';
import 'package:paraiso_canino/laboratorio/laboratorio_page.dart';
import 'package:paraiso_canino/persona/persona_page.dart';
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
  'Ambulancia': const AmbulanciaPage(),
  'Talla': const TallaPage(),
  'Jaula': const JaulaPage(),
  'TipoMascota': Container(), // 1
  'EstadoCivil': Container(), // 2
  'TipoDocumento': Container(), //3
  'Genero': Container(), // 4
  'Color': const ColorPage(),
  'EstatusCita': Container(), //5
  'CasaMedica': Container(), //6
  'ComponentePrincipal': Container(), //7
  'TipoMedidaPeso': Container(), //8
  'Laboratorio': const LaboratorioPage(),
  'Menu': const MenuPage(),
  'Opcion': const OpcionesPage(),
  'OpciondeUsuario': const OpcionUsuarioPage(),
  'Persona': const PersonaPage(),
  'Mascota': const TipoMascotaPage(),
  'Empleado': const EmpleadoPage(),
  'Cita': const CitaPage(),
  'Consulta': const ConsultaPage(),
  'Receta': Container(), //9
  'Hospitalización': const HospitalizacionPage(),
  'Grooming': const GroomingPage(), //10
  'Cliente': Container(), //11
  'Medicamento': Container(), //12
};
