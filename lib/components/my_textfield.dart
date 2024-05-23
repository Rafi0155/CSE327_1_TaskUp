import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  // final int? maxLines;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.validator,
    // this.maxLines,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  //final _MyTextFieldStateKey = GlobalKey<FormState>();

  // bool _showHelperText = false;
  // String _helperText = '';

  // void showHelperText(String message) {
  //   setState(() {
  //     _showHelperText = true;
  //     _helperText = message;
  //   });
  // }
  //
  // void hideHelperText() {
  //   setState(() {
  //     _showHelperText = false;
  //     _helperText = '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        validator: widget.validator,
        // maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.labelText,
          //helperText: _showHelperText ? _helperText : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
