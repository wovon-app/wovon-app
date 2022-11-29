import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              FractionallySizedBox(
                widthFactor: 0.4,
                child: Center(
                  child: Image.asset('assets/images/logo_fc.png',),
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

  @override
  State<_FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<_FilterList> {
  List<Category>? categories;
  List<bool>? selected;

  @override
  void initState() {
    super.initState();

    setState(() {
      categories = Categories.getCategories();
    });
    setState(() {
      selected = [false, false, false, false, false, false];
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ActionChip(
            side: const BorderSide(style: BorderStyle.none),
            elevation: 2,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            backgroundColor: selected![index] ? categories![index].darkColor : categories![index].lightColor,
            label: Text(
              categories![index].name,
              style: theme.textTheme.labelLarge!.copyWith(
                color: selected![index] ? const Color(0xFFFFFFFF) : categories![index].darkColor,
              ),
            ),
            onPressed: () {
              setState(() {
                selected![index] = !selected![index];
              });
            },
          ),
        ),
        itemCount: categories!.length,
      ),
    );
  }
}
