import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_meals.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/filter_option.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
    required this.selectedFilter,
  });

  final Map<Filter, bool> selectedFilter;

  @override
  State<StatefulWidget> createState() {
    return _FilterState();
  }
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FilterState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  List<Meal> meals = [];

  @override
  void initState() {
    // NB: widget is a statefulWidget instance with which we can access statefulWidget property
    _isGlutenFree = widget.selectedFilter[Filter.glutenFree]!;
    _isVegan = widget.selectedFilter[Filter.vegan]!;
    _isVegetarian = widget.selectedFilter[Filter.vegetarian]!;
    _isLactoseFree = widget.selectedFilter[Filter.lactoseFree]!;
  }

  void _setMeals() {
    meals = dummyMeals
        .where((meal) =>
            meal.isGlutenFree == _isGlutenFree &&
            meal.isLactoseFree == _isLactoseFree &&
            meal.isVegan == _isVegan &&
            meal.isVegetarian == _isVegetarian)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegan: _isVegan,
            Filter.vegetarian: _isVegetarian,
          });
        },
        child: Column(
          children: [
            FilterOption(
                enabled: _isGlutenFree,
                subtitle: 'Only include gluten-free meals.',
                title: 'Gluten-free',
                onChangeValue: (value) {
                  setState(() {
                    _isGlutenFree = value;
                    _setMeals();
                  });
                }),
            FilterOption(
                enabled: _isLactoseFree,
                subtitle: 'Only include lactose-free meals.',
                title: 'Lactose-free',
                onChangeValue: (value) {
                  setState(() {
                    _isLactoseFree = value;
                    _setMeals();
                  });
                }),
            FilterOption(
                enabled: _isVegan,
                subtitle: 'Only include vegan meals.',
                title: 'Vegan',
                onChangeValue: (value) {
                  setState(() {
                    _isVegan = value;
                    _setMeals();
                  });
                }),
            FilterOption(
                enabled: _isVegetarian,
                subtitle: 'Only include vegetarian meals.',
                title: 'Vegeterian',
                onChangeValue: (value) {
                  setState(() {
                    _isVegetarian = value;
                    _setMeals();
                  });
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
