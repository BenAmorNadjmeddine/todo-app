import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = Colors.black87,
    this.text = "Something",
    this.icon = Icons.abc,
    this.enabled = true,
    required this.onChanged,
    required this.validator,
    this.onTap,
  }) : super(key: key);

  final TextEditingController textController;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Color cursorColor;
  final String text;
  final IconData icon;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final String? Function(String?) validator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: textController,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: cursorColor,
        enabled: enabled,
        autofocus: false,
        decoration: InputDecoration(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(text),
          ),
          prefixIcon: Icon(icon),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
