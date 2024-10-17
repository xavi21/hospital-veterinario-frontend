import 'dart:html';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';
import 'dart:convert';

import 'package:paraiso_canino/resources/constants.dart';

class GoogleMaps extends StatefulWidget {
  final List<AmbulanciaListModel> ambulancias;

  const GoogleMaps({
    super.key,
    required this.ambulancias,
  });

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  String? iconDataUrl;

  @override
  void initState() {
    super.initState();
    _loadIcon();
  }

  Future<void> _loadIcon() async {
    final ByteData bytes = await rootBundle.load('${imagePath}ambulance.png');
    final Uint8List buffer = bytes.buffer.asUint8List();
    final String base64String = base64Encode(buffer);
    setState(() {
      iconDataUrl = 'data:image/png;base64,$base64String';
    });
  }

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

      for (var ambulancia in widget.ambulancias) {
        final ambLatLng = LatLng(
          double.parse(ambulancia.latitud),
          double.parse(ambulancia.longitud),
        );

        final marker = Marker(
          MarkerOptions()
            ..position = ambLatLng
            ..map = map
            ..title = ambulancia.placa
            ..icon = iconDataUrl,
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
