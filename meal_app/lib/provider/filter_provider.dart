import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meals_provoider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; // not allowed, mutable, we must do it in a immutable way

    state = {
      ...state,
      filter: isActive,
    }; // spread operator makes a copy of state and then add the filter,
    //the filter will then be overridden in th copy of the state
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final filters = ref.watch(filterProvider);

  return meals.where((meal) {
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
});
