import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({
    super.key,
    required this.meals,
    this.title,
    required this.onToggleFavoriteMeal,
  });

  final String? title;
  final List<Meal> meals;

  void Function(Meal meal) onToggleFavoriteMeal;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MealDetails(
                meal: meal,
                onToggleFavoriteMeal: (meal) {
                  onToggleFavoriteMeal(meal);
                },
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = Center(
      child: Column(children: [
        Text(
          'No meal found',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Try selecting a different category!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ]),
    );

    if (meals.isNotEmpty) {
      mainWidget = ListView.builder(
          itemCount: meals.length,
          itemBuilder: ((context, index) => MealItem(
                meal: meals[index],
                onSelectMeal: (Meal meal) {
                  _selectMeal(context, meal);
                },
              )));
    }
    if (title == null) {
      return mainWidget;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: mainWidget);
  }
}
