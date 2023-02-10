import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/my_icon_text_button.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/separator.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/tasks_item.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';
import 'package:todo_app/Shared/Cubit/states.dart';

class DoneTasksUI extends StatelessWidget {
  const DoneTasksUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.doneTasks.isNotEmpty ? buildAllDoneTasks(cubit) : buildNoTasksMessage(context, cubit);
      },
    );
  }

  ListView buildAllDoneTasks(AppCubit cubit) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => TasksItem(
        tasks: cubit.doneTasks[index],
        icon: Icons.archive,
        iconText: "ARCHIVE",
        isDate: cubit.doneTasks[index]['date'] == "" ? false : true,
        isTime: cubit.doneTasks[index]['time'] == "" ? false : true,
        onPressedOnTask: () {
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
        },
        onPressedOnIcon: () {
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
        },
      ),
      separatorBuilder: (context, index) => const Separator(),
      itemCount: cubit.doneTasks.length,
    );
  }

  Center buildNoTasksMessage(context, AppCubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu, size: 65.0, color: Colors.grey),
          Text(
            "No done tasks.",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
