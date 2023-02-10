import 'package:flutter/material.dart';

class TasksItem extends StatelessWidget {
  const TasksItem({
    Key? key,
    this.tasks,
    required this.onPressedOnTask,
    required this.onPressedOnIcon,
    this.boxColor = Colors.black87,
    this.icon,
    this.iconText,
    required this.isDate,
    required this.isTime,
  }) : super(key: key);

  final Map? tasks;
  final VoidCallback onPressedOnTask, onPressedOnIcon;
  final Color boxColor;
  final IconData? icon;
  final String? iconText;
  final bool isDate, isTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedOnTask,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTasksItemDetails(context),
            buildIconButton(context),
          ],
        ),
      ),
    );
  }

  Expanded buildTasksItemDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${tasks!["task"]}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          isDate || isTime
              ? Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        isDate
                            ? Row(
                                children: [
                                  buildBoxShape(
                                    context,
                                    Text(
                                      "${tasks!["date"]}",
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                              )
                            : const SizedBox(),
                        isTime
                            ? buildBoxShape(
                                context,
                                Text(
                                  "${tasks!["time"]}",
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Container buildBoxShape(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: boxColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      child: Center(
        child: child,
      ),
    );
  }

  Widget buildIconButton(BuildContext context) {
    return GestureDetector(
      onTap: onPressedOnIcon,
      child: Column(
        children: [
          Icon(icon, size: 22.0),
          Text(iconText ?? "", style: Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }
}
