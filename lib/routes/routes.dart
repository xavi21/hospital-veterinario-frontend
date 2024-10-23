import 'package:flutter/material.dart';
import 'package:paraiso_canino/ambulancia/ambulancia_page.dart';
import 'package:paraiso_canino/cita/cita_page.dart';
import 'package:paraiso_canino/cliente/cliente_page.dart';
import 'package:paraiso_canino/color/color_page.dart';
import 'package:paraiso_canino/consulta/consulta_page.dart';
import 'package:paraiso_canino/dashboard/dashboard_page.dart';
import 'package:paraiso_canino/empleado/empleado_page.dart';
import 'package:paraiso_canino/genero/genero_page.dart';
import 'package:paraiso_canino/grooming/grooming_page.dart';
import 'package:paraiso_canino/hospitalizacion/hospitalizacion_page.dart';
import 'package:paraiso_canino/jaula/jaula_page.dart';
import 'package:paraiso_canino/laboratorio/laboratorio_page.dart';
import 'package:paraiso_canino/medicamento/medicamento_page.dart';
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
  'Dashboard': const DashboardPage(),
  'Usuario': const UsuarioPage(),
  'Sucursal': const SucursalPage(),
  'StatusUsuario': const StatusUsuarioPage(),
  'StatusEmpleado': const StatusEmpleadoPage(),
  'Ambulancia': const AmbulanciaPage(),
  'Talla': const TallaPage(),
  'Jaula': const JaulaPage(),
  'TipoMascota': const TipoMascotaPage(),
  'EstadoCivil': Container(),
  'TipoDocumento': Container(),
  'Genero': const GeneroPage(),
  'Color': const ColorPage(),
  'EstatusCita': Container(),
  'CasaMedica': Container(),
  'ComponentePrincipal': Container(),
  'TipoMedidaPeso': Container(),
  'Laboratorio': const LaboratorioPage(),
  'Menu': const MenuPage(),
  'Opcion': const OpcionesPage(),
  'OpciondeUsuario': const OpcionUsuarioPage(),
  'Persona': const PersonaPage(),
  'Mascota': const TipoMascotaPage(),
  'Empleado': const EmpleadoPage(),
  'Cita': const CitaPage(),
  'Consulta': const ConsultaPage(),
  'Receta': Container(),
  'Hospitalización': const HospitalizacionPage(),
  'Grooming': const GroomingPage(),
  'Cliente': const ClientePage(),
  'Medicamento': const MedicamentoPage(),
};
