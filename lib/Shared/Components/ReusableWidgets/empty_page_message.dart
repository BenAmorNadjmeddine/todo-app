import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class EmptyPageMessage extends StatelessWidget {
  const EmptyPageMessage({
    super.key,
    required this.cubit,
    this.icon = Icons.menu,
    this.message = "No tasks yet.",
  });

  final AppCubit cubit;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 65.0, color: Colors.grey),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
