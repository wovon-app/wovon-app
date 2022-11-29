import 'package:flutter/material.dart';
import 'package:wovon_app/api/post.dart';
import 'package:wovon_app/colors/categories.dart';

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
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final TextStyle distanceStyle = TextStyle(
      fontSize: 12.0,
      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.87),
    );
    const TextStyle categoryStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    );

    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Categories.getCategory(post.category).darkColor,
            width: 2.0
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      elevation: 3,
      shadowColor: Categories.getCategory(post.category).darkColor,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: Text(post.title, style: titleStyle),
                        )
                    ),
                    Text(_distanceString(), style: distanceStyle),
                  ],
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(6))
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
          ),
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
                color: Categories.getCategory(post.category).darkColor,
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))
            ),
            child: Center(child: Text(post.category.toUpperCase(), style: categoryStyle))
          ),
        ],
      )




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
