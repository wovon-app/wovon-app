import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WovonAppBar extends StatelessWidget {
  const WovonAppBar({super.key});

  static const filters = [
    "Accidente de tránsito",
    "Corte de servicio",
    "Manifestación",
    "Problema en transporte público",
    "Robo",
    "Ruidos molestos"
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Material(
      elevation: 2,
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Center(
              child: Text(
                'Wovon',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          _filterList(context),
        ],
      ),
    );
  }

  Widget _filterList(BuildContext context) {
    var theme = Theme.of(context);
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Chip(
            backgroundColor: theme.colorScheme.surfaceVariant,
            label: Text(
              filters[index],
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        itemCount: filters.length,
      ),
    );
  }
}
