import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Styles/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.height = 45.0,
    this.width = double.infinity,
    this.borderRadius = 5.0,
    this.text = "Do",
    this.textColor = Colors.white,
    this.buttonColor = defaultColor,
    required this.onPressed,
  }) : super(key: key);

  final double height, width, borderRadius;
  final String text;
  final Color textColor, buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor),
        ),
      ),
    );
  }
}
