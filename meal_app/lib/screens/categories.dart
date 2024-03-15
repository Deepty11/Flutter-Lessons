import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_meals.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> _categories;
  CategoriesScreen(this._categories,
      {super.key, required this.onToggleFavoriteMeal});

  void Function(Meal meal) onToggleFavoriteMeal;

  void _selectCategory(BuildContext context, Category selectedCategory) {
    final List<Meal> filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => MealsScreen(
                meals: filteredMeals,
                title: selectedCategory.title,
                onToggleFavoriteMeal: onToggleFavoriteMeal,
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
    );
  }
}
