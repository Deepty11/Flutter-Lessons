import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit
                  .fill, // without setting this to `fill` the width value will not be active
              width: double.infinity, // take as much as width
              height: 200,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis, // very long text ...
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          /* since the row is inside the Column and Column is inside the `Positioned`
                         which has constraints specified, therefore, the this row is also constrained, thus the `Row` inside
                         `MealItemTrait` will also be constrained, so no need of wrapping it with `Expanded` */
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // duration
                            MealItemTrait(
                                iconData: Icons.schedule,
                                label: '${meal.duration} min'),
                            const SizedBox(
                              width: 12,
                            ),
                            // complexity
                            MealItemTrait(
                              iconData: Icons.work,
                              label: meal.complexityText,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            // affordability
                            MealItemTrait(
                                iconData: Icons.attach_money,
                                label: meal.affordabilityText),
                          ],
                        )
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
