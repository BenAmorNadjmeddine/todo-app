import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/empty_page_message.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/my_icon_text_button.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/separator.dart';
import 'package:todo_app/Shared/Components/ReusableWidgets/tasks_item.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Components/dialox_boxes.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';
import 'package:todo_app/Shared/Cubit/states.dart';

import 'DoneTasksUIComponents/done_tasks.dart';

class DoneTasksUI extends StatelessWidget {
  const DoneTasksUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.doneTasks.isNotEmpty
            ? DoneTasks(cubit: cubit)
            : EmptyPageMessage(
                cubit: cubit,
                icon: Icons.menu,
                message: "No done tasks.",
              );
      },
    );
  }
}
