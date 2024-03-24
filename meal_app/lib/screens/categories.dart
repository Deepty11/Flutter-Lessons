import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Category> _categories;
  const CategoriesScreen(
    this._categories, {
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

/* for multiple animationController, use `TickerProviderStateMixin`
for single animationController, use `SingleTickerProviderStateMixin`*/
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController; // late = lazy initializer

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, // default = 0
      upperBound: 1, // default = 1
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // make sure that `_animationController` will be removed right before this widget is removed
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category selectedCategory) {
    final List<Meal> filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => MealsScreen(
                meals: filteredMeals,
                title: selectedCategory.title,
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      /* child =  this widget will not be rebuilt and re initialized while animation, 
      its value won't change, just a part of the animation */
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: widget._categories
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
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        ),
        child: child,
      ),
    );
  }
}
