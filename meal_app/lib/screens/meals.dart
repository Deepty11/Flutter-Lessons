import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    required this.title,
  });

  final String title;
  final List<Meal> meals;

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
        itemBuilder: ((context, index) => MealItem(meal: meals[index])),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: mainWidget);
  }
}
