import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.onSelectItem,
  });

  final IconData iconData;
  final String title;
  final void Function() onSelectItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
      onTap: onSelectItem,
    );
  }
}
