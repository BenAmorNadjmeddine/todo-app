import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class NewSlidableTasksItem extends StatelessWidget {
  const NewSlidableTasksItem({
    Key? key,
    required this.slidableKey,
    this.tasks,
    this.timeColor = Colors.black26,
    this.onPressedOnDuplicate,
    this.onPressedOnEdit,
    this.onPressedOnDone,
    this.onPressedOnDelete,
    required this.onTap,
  }) : super(key: key);

  final Key slidableKey;
  final Map? tasks;
  final Color timeColor;
  final Function(BuildContext)? onPressedOnDuplicate, onPressedOnEdit, onPressedOnDone, onPressedOnDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppCubit.get(context).isDark ? Colors.black38 : Colors.grey.shade300,
      ),
      child: Slidable(
        key: slidableKey,
        closeOnScroll: true,
        startActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: onPressedOnDuplicate,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.black87,
              icon: Icons.copy,
              label: 'Duplicate',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
            ),
            SlidableAction(
              onPressed: onPressedOnEdit,
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black87,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: onPressedOnDone,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Done',
            ),
            SlidableAction(
              onPressed: onPressedOnDelete,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTasksItemDetails(context),
                buildTimeBox(context),
              ],
            ),
          ),
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
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 5),
          Text(
            "${tasks!["date"]}",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Container buildTimeBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: timeColor,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "${tasks!["time"]}",
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
      ),
    );
  }
}
