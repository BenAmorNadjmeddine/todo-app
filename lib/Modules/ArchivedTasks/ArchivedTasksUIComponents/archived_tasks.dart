import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/my_icon_text_button.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/separator.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/tasks_item.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildTasksItem(index, context),
      separatorBuilder: (context, index) => const Separator(),
      itemCount: cubit.archivedTasks.length,
    );
  }

  TasksItem buildTasksItem(int index, BuildContext context) {
    return TasksItem(
      tasks: cubit.archivedTasks[index],
      isDate: cubit.archivedTasks[index]['date'] == "" ? false : true,
      isTime: cubit.archivedTasks[index]['time'] == "" ? false : true,
      onPressedOnTask: () {
        onPressedOnTask(context, index);
      },
      onPressedOnIcon: () {},
    );
  }

  void onPressedOnTask(context, index) {
    cubit.taskController.text = cubit.archivedTasks[index]['task'];
    cubit.descriptionController.text = cubit.archivedTasks[index]['description'];
    cubit.dateController.text = cubit.archivedTasks[index]['date'];
    cubit.timeController.text = cubit.archivedTasks[index]['time'];
    showTaskDialogBox(
      context: context,
      id: cubit.archivedTasks[index]['id'],
      taskController: cubit.taskController,
      descriptionController: cubit.descriptionController,
      dateController: cubit.dateController,
      timeController: cubit.timeController,
      status: cubit.archivedTasks[index]['status'],
      isDate: cubit.archivedTasks[index]['date'] == "" ? false : true,
      isTime: cubit.archivedTasks[index]['time'] == "" ? false : true,
      iconButtons: [
        Expanded(
          child: MyIconButton(
            icon: Icons.copy,
            text: "Duplicate",
            onTap: () {
              cubit.taskController.text = cubit.archivedTasks[index]['task'];
              cubit.descriptionController.text = cubit.archivedTasks[index]['description'];
              cubit.dateController.text = cubit.archivedTasks[index]['date'];
              cubit.timeController.text = cubit.archivedTasks[index]['time'];
              Navigator.pop(context);
              addTaskDialogBox(
                context: context,
                cubit: cubit,
                taskController: cubit.taskController,
                descriptionController: cubit.descriptionController,
                dateController: cubit.dateController,
                timeController: cubit.timeController,
              );
            },
          ),
        ),
        Expanded(
          child: MyIconButton(
            icon: Icons.unarchive,
            text: "Unarchived",
            onTap: () {
              Navigator.pop(context);
              cubit.updateDataBaseTaskStatus(
                id: cubit.archivedTasks[index]['id'],
                status: "done",
                context: context,
              );
              showSnackBar(
                context: context,
                message: "Task unarchived successfully",
                duration: 2,
                actionMessage: "",
                action: () {},
              );
              cubit.clearControllers();
            },
          ),
        ),
        Expanded(
          child: MyIconButton(
            icon: Icons.delete,
            text: "Delete",
            onTap: () {
              var deletedTask = cubit.archivedTasks[index]['task'];
              var deletedDescription = cubit.archivedTasks[index]['description'];
              var deletedDate = cubit.archivedTasks[index]['date'];
              var deletedTime = cubit.archivedTasks[index]['time'];
              Navigator.pop(context);
              cubit.deleteFromDataBase(id: cubit.archivedTasks[index]['id']);
              showSnackBar(
                context: context,
                message: "Task deleted.",
                duration: 3,
                actionMessage: "UNDO",
                action: () {
                  cubit.insertIntoDataBase(
                    task: deletedTask,
                    description: deletedDescription,
                    date: deletedDate,
                    time: deletedTime,
                    status: "archived",
                  );
                  deletedTask = '';
                  deletedDescription = '';
                  deletedDate = '';
                  deletedTime = '';
                },
              );
              cubit.clearControllers();
            },
          ),
        ),
      ],
    );
  }
}
