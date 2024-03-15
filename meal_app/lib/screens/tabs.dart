import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_categories.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleFavoriteMeals(Meal meal) {
    bool isFavoriteMeal = _favoriteMeals.contains(meal);

    if (isFavoriteMeal) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  void _setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = CategoriesScreen(
      availableCategories,
      onToggleFavoriteMeal: (meal) {
        _toggleFavoriteMeals(meal);
      },
    );
    String activeTitle = "Categories";

    if (_selectedIndex == 1) {
      activeWidget = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavoriteMeal: (meal) {
          _toggleFavoriteMeals(meal);
        },
      );
      activeTitle = "Favorite";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activeTitle)),
      body: activeWidget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _setScreen(index);
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'favorites',
          ),
        ],
      ),
    );
  }
}
