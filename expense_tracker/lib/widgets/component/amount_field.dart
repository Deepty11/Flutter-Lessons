import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountField extends StatelessWidget {
  final TextEditingController _amountController;
  const AmountField(this._amountController, {super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixText: '\$',
        label: Text(
          'Amount',
          style: GoogleFonts.lato(fontSize: 14),
        ),
      ),
    );
  }
}
