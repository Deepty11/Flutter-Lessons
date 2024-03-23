import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dummy_categories.dart';
import 'package:meal_app/provider/favorite_providers.dart';
import 'package:meal_app/provider/filter_provider.dart';
import 'package:meal_app/provider/meals_provoider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filter.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/filter_provider.dart';

final Map<Filter, bool> kSelectedFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _onSelectScreen(String title) async {
    Navigator.of(context).pop();

    if (title == 'filter') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FilterScreen(),
        ),
      );
    }
  }

  void _setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final filters = ref.watch(filterProvider);

    final availableMeals = meals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget activeWidget = CategoriesScreen(
      availableCategories,
      availableMeals: availableMeals,
    );

    String activeTitle = "Categories";

    if (_selectedIndex == 1) {
      activeWidget = MealsScreen(
        meals: ref.watch(favoriteMealProvider),
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
