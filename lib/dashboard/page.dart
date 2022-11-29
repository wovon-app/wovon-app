import 'package:flutter/material.dart';
import '../api/post.dart';
import 'package:geolocator/geolocator.dart';
import 'incident_list_item.dart';
import '../api/api.dart' as api;
import '../gps.dart' as gps;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  final title = "Dashboard";

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Wovpost>? _wovposts;

  Position? _gpsPos;

  @override
  void initState() {
    super.initState();

    gps.determinePosition().then((value) {
      setState(() {
        _gpsPos = value;
      });

      api.getAllPosts().then((posts) {
        setState(() {
          _wovposts = posts;
        });
      });
    }).onError((error, stackTrace) {
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
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_wovposts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [incidentList()],
    );
  }

  Widget incidentList() => Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var wovpost = _wovposts![index];
          return IncidentListItem(
              post: wovpost, distance: _distanceTo(wovpost));
        },
        itemCount: _wovposts!.length,
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        clipBehavior: Clip.none,
        shrinkWrap: true,
      )
  );

  int _distanceTo(Wovpost wovpost) {
    return Geolocator.distanceBetween(_gpsPos!.latitude, _gpsPos!.longitude,
            wovpost.latitude, wovpost.longitude)
        .toInt();
  }
}
