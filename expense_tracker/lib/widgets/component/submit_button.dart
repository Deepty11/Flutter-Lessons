import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final void Function() _onSubmit;
  final void Function() _onPressed;

  const SubmitButton(this._onSubmit, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: _onPressed,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _onSubmit,
          child: const Text('Save Expense'),
        )
      ],
    );
  }
}
