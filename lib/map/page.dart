import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wovon_app/colors/categories.dart';

import '../gps.dart' as gps;
import '../api/api.dart' as api;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  static const markerSize = 12.0;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<CircleMarker>? _incidents;

  LatLng? _gpsPos;

  @override
  void initState() {
    gps
        .determinePosition()
        .then((value) => setState(() {
              _gpsPos = LatLng(value.latitude, value.longitude);
            }))
        .onError((error, stackTrace) => {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Couldn't get GPS position"),
                        content: Text(error.toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"))
                        ],
                      ))
            });

    api.getAllPosts().then((value) => setState(() {
          _incidents = value
              .map((i) => CircleMarker(
                  point: LatLng(i.latitude, i.longitude),
                  color: Categories.getCategory(i.category).darkColor,
                  radius: MapPage.markerSize,
                  borderStrokeWidth: 3.0,
                  borderColor: Colors.white))
              .toList();
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_gpsPos == null || _incidents == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FlutterMap(
      options: MapOptions(center: _gpsPos, zoom: 15),
      nonRotatedChildren: [
        attribution(),
      ],
      children: [
        TileLayer(
            // urlTemplate: 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'app.wovon'),
        CircleLayer(
          circles: [
            ..._incidents!,
            CircleMarker(
              point: _gpsPos!,
              color: Colors.blue,
              borderColor: Colors.white,
              borderStrokeWidth: 2,
              radius: 8,
            ),
          ],
        )
      ],
    );
  }

  Widget attribution() {
    return AttributionWidget(attributionBuilder: (context) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
              color: Color.fromRGBO(255, 255, 255, 0.75)),
          child: const Text('© OpenStreetMap contributors'));
    });
  }
}
