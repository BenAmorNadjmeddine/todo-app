import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class MyCloseButton extends StatelessWidget {
  const MyCloseButton({
    Key? key,
    required this.onTap,
    this.size = 20.0,
  }) : super(key: key);

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.close,
          color: AppCubit.get(context).isDark ? Colors.grey.shade300 : Colors.black87,
          size: size,
        ),
      ),
    );
  }
}
