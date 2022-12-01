import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:wovon_app/colors/categories.dart';

import '../api/post.dart';
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
    super.initState();

    Future.wait([gps.determinePosition(), api.getAllPosts()]).then((value) {
      var pos = value[0] as Position;
      var posts = value[1] as List<Wovpost>;

      setState(() {
        _gpsPos = LatLng(pos.latitude, pos.longitude);
        _incidents = posts
            .map((i) => CircleMarker(
                point: LatLng(i.latitude, i.longitude),
                color: Categories.getCategory(i.category).darkColor,
                radius: MapPage.markerSize,
                borderStrokeWidth: 3.0,
                borderColor: Colors.white))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gpsPos == null || _incidents == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FlutterMap(
      options: MapOptions(center: _gpsPos, zoom: 15),
      children: [
        TileLayer(
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
}
