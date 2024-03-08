import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleField extends StatelessWidget {
  final TextEditingController _titleController;
  const TitleField(this._titleController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        label: Text(
          'Title',
          style: GoogleFonts.lato(fontSize: 14),
        ),
      ),
    );
  }
}
