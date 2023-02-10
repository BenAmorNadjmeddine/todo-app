import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class MyTextArea extends StatelessWidget {
  const MyTextArea({
    Key? key,
    required this.textController,
    this.textInputAction = TextInputAction.newline,
    this.text = "Description",
  }) : super(key: key);

  final TextEditingController textController;
  final TextInputAction textInputAction;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      textInputAction: textInputAction,
      keyboardType: TextInputType.multiline,
      cursorColor: AppCubit.get(context).isDark ? Colors.grey.shade300 : Colors.black87,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: text,
        focusColor: Colors.grey.shade300,
        fillColor: Colors.grey.shade300,
        hoverColor: Colors.grey.shade300,
      ),
    );
  }
}
