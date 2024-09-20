import 'dart:html';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';

class GoogleMaps extends StatelessWidget {
  final List<AmbulanciaListModel> ambulancias;

  const GoogleMaps({
    super.key,
    required this.ambulancias,
  });

  @override
  Widget build(BuildContext context) {
    String htmlId = 'google-map';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final latLng = LatLng(14.64072, -90.51327);

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = latLng;

      final element = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = "none";

      final map = GMap(element, mapOptions);

      for (var ambulancia in ambulancias) {
        final ambLatLng = LatLng(
          double.parse(ambulancia.latitud),
          double.parse(ambulancia.longitud),
        );

        final marker = Marker(
          MarkerOptions()
            ..position = ambLatLng
            ..map = map
            ..title = ambulancia.placa,
        );

        final contentString =
            '<div><strong>Ambulancia</strong><br>Marca: ${ambulancia.marca} <br>Modelo ${ambulancia.modelo} <br>Placas ${ambulancia.placa} <br></div>';

        final infoWindow =
            InfoWindow(InfoWindowOptions()..content = contentString as JSAny?);

        marker.onClick.listen((myEvent) => infoWindow.open(map, marker));
      }

      return element;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
