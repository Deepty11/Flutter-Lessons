import 'package:flutter/material.dart';
import 'package:meal_app/widgets/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key, required this.onSelectScreen});

  void Function(String title) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
              ]),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Cooking...',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          DrawerItem(
              iconData: Icons.restaurant,
              title: 'Meal',
              onSelectItem: () {
                onSelectScreen('meal');
              }),
          DrawerItem(
              iconData: Icons.settings,
              title: 'Filter',
              onSelectItem: () {
                onSelectScreen('filter');
              }),
        ],
      ),
    );
  }
}
