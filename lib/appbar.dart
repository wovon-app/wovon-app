import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wovon_app/appbloc.dart';
import 'package:wovon_app/colors/categories.dart';

class WovonAppBar extends StatelessWidget {
  const WovonAppBar({super.key});

  static var filters = Categories.getCategories();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Material(
          elevation: 2,
          shadowColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_fc.png',
                    ),
                  ),
                ),
              ),
              const _FilterList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterList extends StatefulWidget {
  const _FilterList({super.key});

  static final List<Category> categories = Categories.getCategories();

  @override
  State<_FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<_FilterList> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<AppBloc, AppState>(
      builder: (ctx, appState) {
        return Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _FilterList.categories.length,
            itemBuilder: (context, index) {
              final category = _FilterList.categories[index];
              final isSelected = appState.isSelected(category.name);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ActionChip(
                  side: const BorderSide(style: BorderStyle.none),
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  backgroundColor:
                      isSelected ? category.darkColor : category.lightColor,
                  label: Text(
                    category.name,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: isSelected
                          ? const Color(0xFFFFFFFF)
                          : category.darkColor,
                    ),
                  ),
                  onPressed: () {
                    ctx.read<AppBloc>().add(ToggleFilterEvent(category.name));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
