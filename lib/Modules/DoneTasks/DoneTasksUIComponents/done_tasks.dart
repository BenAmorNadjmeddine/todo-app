import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/my_icon_text_button.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/separator.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/tasks_item.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({
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
      itemCount: cubit.doneTasks.length,
    );
  }

  TasksItem buildTasksItem(int index, BuildContext context) {
    return TasksItem(
      tasks: cubit.doneTasks[index],
      icon: Icons.archive,
      iconText: "ARCHIVE",
      isDate: cubit.doneTasks[index]['date'] == "" ? false : true,
      isTime: cubit.doneTasks[index]['time'] == "" ? false : true,
      onPressedOnTask: () {
        onPressedOnTask(context, index);
      },
      onPressedOnIcon: () {
        onPressedOnIcon(context, index);
      },
    );
  }

  void onPressedOnTask(context, index) {
    cubit.taskController.text = cubit.doneTasks[index]['task'];
    cubit.descriptionController.text = cubit.doneTasks[index]['description'];
    cubit.dateController.text = cubit.doneTasks[index]['date'];
    cubit.timeController.text = cubit.doneTasks[index]['time'];
    showTaskDialogBox(
      context: context,
      id: cubit.doneTasks[index]['id'],
      taskController: cubit.taskController,
      descriptionController: cubit.descriptionController,
      dateController: cubit.dateController,
      timeController: cubit.timeController,
      status: cubit.doneTasks[index]['status'],
      isDate: cubit.doneTasks[index]['date'] == "" ? false : true,
      isTime: cubit.doneTasks[index]['time'] == "" ? false : true,
      iconButtons: [
        Expanded(
          child: MyIconButton(
            icon: Icons.copy,
            text: "Duplicate",
            onTap: () {
              cubit.taskController.text = cubit.doneTasks[index]['task'];
              cubit.descriptionController.text = cubit.doneTasks[index]['description'];
              cubit.dateController.text = cubit.doneTasks[index]['date'];
              cubit.timeController.text = cubit.doneTasks[index]['time'];
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
            icon: Icons.remove_done,
            text: "Undo",
            onTap: () {
              Navigator.pop(context);
              cubit.updateDataBaseTaskStatus(
                id: cubit.doneTasks[index]['id'],
                status: "new",
                context: context,
              );
              showSnackBar(
                context: context,
                message: "Task undone successfully",
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
              var deletedTask = cubit.doneTasks[index]['task'];
              var deletedDescription = cubit.doneTasks[index]['description'];
              var deletedDate = cubit.doneTasks[index]['date'];
              var deletedTime = cubit.doneTasks[index]['time'];
              Navigator.pop(context);
              cubit.deleteFromDataBase(id: cubit.doneTasks[index]['id']);
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
                    status: "done",
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
  void onPressedOnIcon(context, index) {
    cubit.updateDataBaseTaskStatus(
      id: cubit.doneTasks[index]['id'],
      status: "archive",
      context: context,
    );
    showSnackBar(
      context: context,
      message: "Task archived successfully",
      duration: 2,
      actionMessage: "",
      action: () {},
    );
    cubit.clearControllers();
  }
}
