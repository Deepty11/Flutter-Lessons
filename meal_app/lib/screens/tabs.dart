import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_categories.dart';
import 'package:meal_app/data/dummy_meals.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filter.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

final Map<Filter, bool> kSelectedFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

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
  Map<Filter, bool> _selectedFilters = kSelectedFilters;

  void _onSelectScreen(String title) async {
    Navigator.of(context).pop();

    if (title == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FilterScreen(
            selectedFilter: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kSelectedFilters;
      });
    }
  }

  void _toggleFavoriteMeals(Meal meal) {
    bool isFavoriteMeal = _favoriteMeals.contains(meal);

    if (isFavoriteMeal) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal no longer a favorite');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Meal is successfully added to favorites!');
      });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();
    Widget activeWidget = CategoriesScreen(
      availableCategories,
      availableMeals: availableMeals,
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
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _onSelectScreen,
      ),
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
