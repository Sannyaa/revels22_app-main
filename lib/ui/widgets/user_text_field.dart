import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String label;
  final String value;
  const UserTextField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      enabled: false,
      controller: TextEditingController(text: value),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(label),
        border: InputBorder.none,
      ),
    );
  }
}
