import 'dart:async';
import 'dart:html';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';

class GoogleMaps extends StatefulWidget {
  final List<AmbulanciaListModel> ambulancias;
  final String? iconDataUrl;
  final String? iconDataUrlDisable;

  const GoogleMaps({
    super.key,
    required this.ambulancias,
    this.iconDataUrl,
    this.iconDataUrlDisable,
  });

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GMap map;
  late List<Marker> markers = [];
  late Timer _timer;

  final Map<String, List<LatLng>> coordinatesMap = {
    'P758LVV': [
      LatLng(14.542279, -90.405953),
      LatLng(14.542668, -90.405541),
      LatLng(14.543344, -90.404773),
      LatLng(14.542042, -90.405592),
      LatLng(14.542366, -90.405258),
      LatLng(14.543363, -90.405143),
      LatLng(14.542128, -90.406112),
      LatLng(14.542161, -90.408240),
      LatLng(14.545391, -90.408905),
    ],
    'P725KFS': [
      LatLng(14.543949, -90.411196),
      LatLng(14.543048, -90.411306),
      LatLng(14.542473, -90.413009),
      LatLng(14.541476, -90.413202),
      LatLng(14.540833, -90.414168),
      LatLng(14.539685, -90.414999),
      LatLng(14.538352, -90.415572),
      LatLng(14.537383, -90.416050),
      LatLng(14.535908, -90.415982),
    ],
    'P627KVT': [
      LatLng(14.546610, -90.413887),
    ],
  };

  // Mantener el índice actual de cada ambulancia
  final Map<String, int> currentIndexMap = {};

  @override
  void initState() {
    super.initState();
    _initializeMap();
    _startUpdatingMarkers();
  }

  void _initializeMap() {
    String htmlId = 'google-map';
    final latLng = LatLng(14.64072, -90.51327);

    final mapOptions = MapOptions()
      ..zoom = 10
      ..center = latLng;

    final element = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = "none";

    map = GMap(element, mapOptions);
    _addMarkers();

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(htmlId, (int viewId) => element);
  }

  void _addMarkers() {
    // Limpiar marcadores existentes
    for (var marker in markers) {
      marker.map = null; // Remover el marcador del mapa
    }
    markers.clear();

    // Agregar nuevos marcadores
    for (var ambulancia in widget.ambulancias) {
      String placa = ambulancia.placa;
      LatLng newPosition;

      // Obtener el índice actual y la nueva posición
      int currentIndex = currentIndexMap[placa] ?? 0;
      List<LatLng>? coordinates = coordinatesMap[placa];

      // Si hay coordenadas disponibles, cambiar a la siguiente
      if (coordinates != null && coordinates.isNotEmpty) {
        newPosition = coordinates[currentIndex];

        // Incrementar el índice y reiniciar si es necesario
        currentIndex++;
        if (currentIndex >= coordinates.length) {
          currentIndex = 0; // Reiniciar si llega al final
        }
        currentIndexMap[placa] = currentIndex; // Guardar el nuevo índice
      } else {
        continue; // Si no hay coordenadas, saltar
      }

      final marker = Marker(
        MarkerOptions()
          ..position = newPosition
          ..map = map
          ..title = ambulancia.placa
          ..icon = ambulancia.placa == 'P627KVT'
              ? widget.iconDataUrlDisable
              : widget.iconDataUrl,
      );

      final contentString =
          '<div><strong>Ambulancia</strong><br>Marca: ${ambulancia.marca} <br>Modelo: ${ambulancia.modelo} <br>Placas: ${ambulancia.placa} <br></div>';

      final infoWindow =
          InfoWindow(InfoWindowOptions()..content = contentString as JSAny?);

      marker.onClick.listen((myEvent) => infoWindow.open(map, marker));

      markers.add(marker); // Agregar el marcador a la lista
    }
  }

  void _startUpdatingMarkers() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _addMarkers(); // Actualizar marcadores en el mapa
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String htmlId = 'google-map';
    return HtmlElementView(viewType: htmlId);
  }
}
