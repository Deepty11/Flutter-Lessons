// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class FilterOption extends StatelessWidget {
  FilterOption({
    super.key,
    required this.enabled,
    required this.subtitle,
    required this.title,
    required this.onChangeValue,
  });

  final bool enabled;
  final String title;
  final String subtitle;
  void Function(bool val) onChangeValue;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: enabled,
      onChanged: onChangeValue,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
