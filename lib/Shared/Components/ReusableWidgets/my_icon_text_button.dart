import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    this.onTap,
    this.icon = Icons.abc,
    this.text = "DO",
  }) : super(key: key);

  final VoidCallback? onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 22.0),
          const SizedBox(height: 5.0),
          Text(text, style: Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }
}
