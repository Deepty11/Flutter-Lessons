import 'package:meal_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelect});
  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  final void Function() onSelect;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.99),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: borderRadius,
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
