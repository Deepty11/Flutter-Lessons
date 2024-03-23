import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_meals.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/filter_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  FilterScreen({super.key});

  List<Meal> meals = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: [
          FilterOption(
              enabled: activeFilters[Filter.glutenFree]!,
              subtitle: 'Only include gluten-free meals.',
              title: 'Gluten-free',
              onChangeValue: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.glutenFree, value);
              }),
          FilterOption(
              enabled: activeFilters[Filter.lactoseFree]!,
              subtitle: 'Only include lactose-free meals.',
              title: 'Lactose-free',
              onChangeValue: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.lactoseFree, value);
              }),
          FilterOption(
              enabled: activeFilters[Filter.vegan]!,
              subtitle: 'Only include vegan meals.',
              title: 'Vegan',
              onChangeValue: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegan, value);
              }),
          FilterOption(
              enabled: activeFilters[Filter.vegetarian]!,
              subtitle: 'Only include vegetarian meals.',
              title: 'Vegeterian',
              onChangeValue: (value) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegetarian, value);
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
