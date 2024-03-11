import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_meals.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> _categories;
  const CategoriesScreen(this._categories, {super.key});

  void _selectCategory(BuildContext context, Category selectedCategory) {
    final List<Meal> filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) =>
              MealsScreen(meals: filteredMeals, title: selectedCategory.title)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: _categories
            .map(
              (selectedCategory) => CategoryGridItem(
                category: selectedCategory,
                onSelect: () {
                  _selectCategory(context, selectedCategory);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
