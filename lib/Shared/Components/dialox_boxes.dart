import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

import 'ReusableWidgets/my_button.dart';
import 'ReusableWidgets/my_close_button.dart';
import 'ReusableWidgets/my_text_area.dart';
import 'ReusableWidgets/my_text_form_field.dart';
import 'ReusableWidgets/separator.dart';
import 'components.dart';

void addTaskDialogBox({
  required BuildContext context,
  required AppCubit cubit,
  required TextEditingController taskController,
  required TextEditingController descriptionController,
  required TextEditingController dateController,
  required TextEditingController timeController,
  bool? isFromNew,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add new task', style: Theme.of(context).textTheme.headline4),
                        MyCloseButton(
                          onTap: () {
                            cubit.showFieldError(false);
                            Navigator.pop(context);
                            taskController.clear();
                            descriptionController.clear();
                            timeController.clear();
                            dateController.clear();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    MyTextFormField(
                      textController: taskController,
                      text: "Task",
                      icon: Icons.task,
                      textInputAction: TextInputAction.done,
                      cursorColor: cubit.isDark ? Colors.grey.shade300 : Colors.black87,
                      onChanged: (String value) {
                        if (value.isEmpty && cubit.showFieldErrorMessage) {
                          cubit.showFieldError(true);
                        } else {
                          cubit.showFieldError(false);
                        }
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          cubit.showFieldError(true);
                        } else {
                          cubit.showFieldError(false);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    cubit.showFieldErrorMessage
                        ? Row(
                            children: [
                              const Icon(Icons.error, size: 12.0, color: Colors.red),
                              const SizedBox(width: 5.0),
                              Text(
                                'Task field should not be empty',
                                style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 12.0, color: Colors.red),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10.0),
                    MyTextArea(textController: descriptionController),
                    const SizedBox(height: 20.0),
                    MyTextFormField(
                      textController: dateController,
                      text: "Date",
                      icon: Icons.calendar_month,
                      enabled: false,
                      keyboardType: TextInputType.datetime,
                      cursorColor: cubit.isDark ? Colors.grey.shade300 : Colors.black87,
                      onChanged: (String value) {},
                      validator: (String? value) {
                        return null;
                      },
                      onTap: () {
                        DateTime now = DateTime.now();
                        showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year - 30, now.month, now.day),
                          lastDate: DateTime.parse(
                            DateTime(now.year + 30, now.month, now.day).toString(),
                          ),
                        ).then((value) {
                          if (value != null) {
                            dateController.text = DateFormat.yMMMMd().format(value);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    MyTextFormField(
                      textController: timeController,
                      text: "Time",
                      icon: Icons.watch_later,
                      enabled: false,
                      keyboardType: TextInputType.datetime,
                      cursorColor: cubit.isDark ? Colors.grey.shade300 : Colors.black87,
                      onChanged: (String value) {},
                      validator: (String? value) {
                        return null;
                      },
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            timeController.text = value.format(context);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 40.0),
                    MyButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          if (cubit.taskController.text.isEmpty) {
                            cubit.formKey.currentState!.save();
                          } else {
                            cubit.insertIntoDataBase(
                              task: taskController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                              time: timeController.text,
                              status: "new",
                            );
                            showSnackBar(
                              context: context,
                              message: "Task added successfully",
                              duration: 2,
                              actionMessage: "",
                              action: () {},
                            );
                            cubit.showFieldError(false);
                            Navigator.pop(context);
                            cubit.clearControllers();
                          }
                        }
                      },
                      text: 'Add',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void showTaskDialogBox({
  required BuildContext context,
  required int id,
  required TextEditingController taskController,
  required TextEditingController descriptionController,
  required TextEditingController dateController,
  required TextEditingController timeController,
  required String status,
  required bool isDate,
  required bool isTime,
  required List<Widget> iconButtons,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: status == "new"
                                        ? Colors.blueAccent
                                        : status == "done"
                                            ? Colors.green
                                            : Colors.grey,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                                  child: Center(
                                    child: Text(
                                      status == "new"
                                          ? "NEW"
                                          : status == "done"
                                              ? "DONE"
                                              : "ARCHIVED",
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0)
                              ],
                            ),
                            isDate || isTime
                                ? Row(
                                    children: [
                                      isDate
                                          ? Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    color: Colors.black87,
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                                                  child: Center(
                                                    child: Text(
                                                      dateController.text,
                                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8.0),
                                              ],
                                            )
                                          : const SizedBox(),
                                      isTime
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                color: Colors.black87,
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                                              child: Center(
                                                child: Text(
                                                  timeController.text,
                                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        MyCloseButton(
                          onTap: () {
                            Navigator.pop(context);
                            taskController.clear();
                            descriptionController.clear();
                            timeController.clear();
                            dateController.clear();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      taskController.text,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 10.0),
                    descriptionController.text != ""
                        ? Text(
                            descriptionController.text,
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey.shade500),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Separator(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(children: iconButtons),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void editTaskDialogBox({
  required BuildContext context,
  required AppCubit cubit,
  required formKey,
  required int id,
  required TextEditingController taskController,
  required TextEditingController descriptionController,
  required TextEditingController dateController,
  required TextEditingController timeController,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Edit task', style: Theme.of(context).textTheme.headline4),
                          MyCloseButton(
                            onTap: () {
                              cubit.showFieldError(false);
                              Navigator.pop(context);
                              cubit.clearControllers();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      MyTextFormField(
                        textController: cubit.taskController,
                        text: "Task",
                        icon: Icons.task,
                        textInputAction: TextInputAction.done,
                        cursorColor: AppCubit.get(context).isDark ? Colors.grey.shade300 : Colors.black87,
                        onChanged: (String value) {
                          if (value.isEmpty && cubit.showFieldErrorMessage) {
                            cubit.showFieldError(true);
                          } else {
                            cubit.showFieldError(false);
                          }
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            cubit.showFieldError(true);
                          } else {
                            cubit.showFieldError(false);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      cubit.showFieldErrorMessage
                          ? Row(
                              children: [
                                const Icon(Icons.error, size: 12.0, color: Colors.red),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Task field should not be empty',
                                  style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 12.0, color: Colors.red),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10.0),
                      MyTextArea(textController: cubit.descriptionController),
                      const SizedBox(height: 20.0),
                      MyTextFormField(
                        textController: cubit.dateController,
                        text: "Date",
                        icon: Icons.calendar_month,
                        enabled: false,
                        keyboardType: TextInputType.datetime,
                        cursorColor: AppCubit.get(context).isDark ? Colors.grey.shade300 : Colors.black87,
                        onChanged: (String value) {},
                        validator: (String? value) {
                          return null;
                        },
                        onTap: () {
                          DateTime now = DateTime.now();
                          showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(now.year - 30, now.month, now.day),
                            lastDate: DateTime.parse(
                              DateTime(now.year + 30, now.month, now.day).toString(),
                            ),
                          ).then((value) {
                            if (value != null) {
                              cubit.dateController.text = DateFormat.yMMMMd().format(value);
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      MyTextFormField(
                        textController: cubit.timeController,
                        text: "Time",
                        icon: Icons.watch_later,
                        enabled: false,
                        keyboardType: TextInputType.datetime,
                        cursorColor: AppCubit.get(context).isDark ? Colors.grey.shade300 : Colors.black87,
                        onChanged: (String value) {},
                        validator: (String? value) {
                          return null;
                        },
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            if (value != null) {
                              timeController.text = value.format(context);
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 40.0),
                      MyButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.taskController.text.isEmpty) {
                              formKey.currentState!.save();
                            } else {
                              cubit.updateDataBaseEditTask(
                                id: id,
                                task: cubit.taskController.text,
                                description: cubit.descriptionController.text,
                                date: cubit.dateController.text,
                                time: cubit.timeController.text,
                              );
                              // cubit.setDateTime(
                              //   isDate: cubit.dateController.text == "" ? false : true,
                              //   isTime: cubit.timeController.text == "" ? false : true,
                              // );
                              cubit.showFieldError(false);
                              Navigator.pop(context);
                              cubit.clearControllers();
                            }
                          }
                        },
                        text: 'Save',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
