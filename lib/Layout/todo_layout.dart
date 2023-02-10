import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';
import 'package:todo_app/Shared/Cubit/states.dart';

class TODOLayout extends StatelessWidget {
  const TODOLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
              style: Theme.of(context).textTheme.headline5,
            ),
            elevation: 1.0,
            actions: [
              GestureDetector(
                onTap: () {
                  cubit.changeAppMode();
                },
                child: Icon(cubit.isDark ? Icons.sunny : Icons.dark_mode, size: 28.0),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.bottomNavigationBarItems,
            elevation: 6.0,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              cubit.dateController.text = DateFormat.yMMMMd().format(DateTime.now());
              addTaskDialogBox(
                context: context,
                cubit: cubit,
                taskController: cubit.taskController,
                descriptionController: cubit.descriptionController,
                dateController: cubit.dateController,
                timeController: cubit.timeController,
              );
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            label: const Text("New Task"),
            icon: const Icon(Icons.add_task),
          ),
        );
      },
    );
  }
}
