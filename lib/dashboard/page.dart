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

    Future.wait([
      gps.determinePosition().onError((error, stackTrace) {
        showErrorDialog("Couldn't get GPS location", error.toString());
        throw error!;
      }),
      api.getAllPosts().onError((error, stackTrace) {
        showErrorDialog("Couldn't get posts", error.toString());
        throw error!;
      }),
    ]).then((values) {
      var pos = values[0] as Position;
      var posts = values[1] as List<Wovpost>;

      posts.sort((a, b) => _distanceTo(a, pos) - _distanceTo(b, pos));

      setState(() {
        _gpsPos = pos;
        _wovposts = posts;
      });
    }).onError((error, stackTrace) => null);
  }

  void showErrorDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
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
              post: wovpost, distance: _distanceTo(wovpost, _gpsPos!));
        },
        itemCount: _wovposts!.length,
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        clipBehavior: Clip.none,
        shrinkWrap: true,
      ));

  int _distanceTo(Wovpost wovpost, Position currentPos) {
    return Geolocator.distanceBetween(currentPos.latitude, currentPos.longitude,
            wovpost.latitude, wovpost.longitude)
        .toInt();
  }
}
