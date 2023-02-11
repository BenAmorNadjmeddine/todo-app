import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/my_icon_text_button.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/separator.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/tasks_item.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({
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
      itemCount: cubit.newTasks.length,
    );
  }

  TasksItem buildTasksItem(int index, BuildContext context) {
    return TasksItem(
      tasks: cubit.newTasks[index],
      icon: Icons.done,
      iconText: "DONE",
      isDate: cubit.newTasks[index]['date'] == "" ? false : true,
      isTime: cubit.newTasks[index]['time'] == "" ? false : true,
      onPressedOnTask: () {
        onPressedOnTask(context, index);
      },
      onPressedOnIcon: () {
        onPressedOnIcon(context, index);
      },
    );
  }

  void onPressedOnTask(context, index) {
    cubit.taskController.text = cubit.newTasks[index]['task'];
    cubit.descriptionController.text = cubit.newTasks[index]['description'];
    cubit.dateController.text = cubit.newTasks[index]['date'];
    cubit.timeController.text = cubit.newTasks[index]['time'];
    showTaskDialogBox(
      context: context,
      id: cubit.newTasks[index]['id'],
      taskController: cubit.taskController,
      descriptionController: cubit.descriptionController,
      dateController: cubit.dateController,
      timeController: cubit.timeController,
      status: cubit.newTasks[index]['status'],
      isDate: cubit.newTasks[index]['date'] == "" ? false : true,
      isTime: cubit.newTasks[index]['time'] == "" ? false : true,
      iconButtons: [
        Expanded(
          child: MyIconButton(
            icon: Icons.copy,
            text: "Duplicate",
            onTap: () {
              cubit.taskController.text = cubit.newTasks[index]['task'];
              cubit.descriptionController.text = cubit.newTasks[index]['description'];
              cubit.dateController.text = cubit.newTasks[index]['date'];
              cubit.timeController.text = cubit.newTasks[index]['time'];
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
            icon: Icons.edit,
            text: "Edit",
            onTap: () {
              cubit.taskController.text = cubit.newTasks[index]['task'];
              cubit.descriptionController.text = cubit.newTasks[index]['description'];
              cubit.dateController.text = cubit.newTasks[index]['date'];
              cubit.timeController.text = cubit.newTasks[index]['time'];
              Navigator.pop(context);
              editTaskDialogBox(
                context: context,
                cubit: cubit,
                formKey: cubit.formKey,
                id: cubit.newTasks[index]['id'],
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
            icon: Icons.delete,
            text: "Delete",
            onTap: () {
              var deletedTask = cubit.newTasks[index]['task'];
              var deletedDescription = cubit.newTasks[index]['description'];
              var deletedDate = cubit.newTasks[index]['date'];
              var deletedTime = cubit.newTasks[index]['time'];
              Navigator.pop(context);
              cubit.deleteFromDataBase(id: cubit.newTasks[index]['id']);
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
                    status: "new",
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
      id: cubit.newTasks[index]['id'],
      status: "done",
      context: context,
    );
    showSnackBar(
      context: context,
      message: "Task done successfully",
      duration: 2,
      actionMessage: "",
      action: () {},
    );
    cubit.clearControllers();
  }
}
