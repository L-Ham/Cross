import 'package:flutter/material.dart';

class CommunityNameTextBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onClear;

  const CommunityNameTextBox({super.key, 
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixText: 'r/',
        hintText: 'Community_name',
        suffixText: '${21 - controller.text.length}',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: onClear,
        ),
      ),
      onChanged: onChanged,
    );
  }
}