import 'package:flutter/material.dart';
import 'package:wovon_app/api/post.dart';

class IncidentListItem extends StatelessWidget {
  final Wovpost post;
  final int distance;

  const IncidentListItem(
      {super.key, required this.post, required this.distance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextStyle titleStyle = TextStyle(
      fontSize: 20.0,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final TextStyle distanceStyle = TextStyle(
      fontSize: 13.0,
      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.87),
    );
    final TextStyle typeStyle = TextStyle(
      fontSize: 13.0,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceVariant,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: titleStyle),
                Text(_distanceString(), style: distanceStyle),
              ],
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Image.network(
              "https://media.npr.org/assets/img/2021/06/08/20210607_184450-2e240569e1dc66bcff31f74bc88fb1d5c301686b.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }

  String _distanceString() {
    if (distance < 1000) {
      return "$distance m";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)} km";
    }
  }
}
