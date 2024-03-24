import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/favorite_providers.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final favoriteMeals = ref.watch(favoriteMealProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isFavorite = ref
                  .read(favoriteMealProvider.notifier)
                  .toggleMealsFavoriteStatus(meal);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorite
                      ? 'Meal added as a favorite'
                      : 'Meal is removed from favorite'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(begin: 0.5, end: 0.6).animate(animation),
                child: child,
              ),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(
                    isFavorite), // key will differentiate that the `Icon` object is different based on `isFavorite` value
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.scaleDown,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Ingredients:
            ...meal.ingredients.map((ingredient) => Text(
                  ingredient,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Steps:
            ...meal.steps.map((step) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Text(
                    step,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
