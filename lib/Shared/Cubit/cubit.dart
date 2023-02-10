import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/ArchivedTasks/archived_tasks_ui.dart';
import 'package:todo_app/Modules/DoneTasks/done_tasks_ui.dart';
import 'package:todo_app/Modules/NewTasks/new_tasks_ui.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Network/Local/cache_helper.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const NewTasksUI(),
    const DoneTasksUI(),
    const ArchivedTasksUI(),
  ];

  List<String> title = [
    'Tasks',
    'Done',
    'Archive',
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
    BottomNavigationBarItem(icon: Icon(Icons.done_all), label: "Done"),
    BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive"),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavigationBarState());
  }

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({bool? isDarkFromShared}) {
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool showFieldErrorMessage = false;

  void clearControllers() {
    taskController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
  }

  void showFieldError(showMessage) {
    showFieldErrorMessage = showMessage!;
    emit(AppFormErrorState());
  }

  late Database database;

  void createDataBase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) async {
      await database
          .execute(""
              "CREATE TABLE tasks ("
              "id INTEGER PRIMARY KEY, "
              "task TEXT, "
              "description TEXT, "
              "date TEXT, "
              "time TEXT, "
              "status TEXT"
              ")")
          .then((value) {
        getDataFromDataBase(database);
      }).catchError((error) {
        showToast(
          text: 'Error: ${error.toString()}',
          state: ToastStates.error,
        );
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void getDataFromDataBase(database) {
    newTasks.clear();
    doneTasks.clear();
    archivedTasks.clear();
    emit(AppGetFromDatabaseState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      newTasks = newTasks.reversed.toList();
      doneTasks = doneTasks.reversed.toList();
      archivedTasks = archivedTasks.reversed.toList();
      emit(AppGetFromDatabaseState());
    });
  }

  void insertIntoDataBase({
    required String task,
    required String description,
    required String date,
    required String time,
    required String status,
  }) async {
    await database
        .transaction((txn) => txn
                .rawInsert(""
                    "INSERT INTO tasks (task, description, date, time, status) "
                    "VALUES ('$task', '$description', '$date', '$time', '$status')")
                .then((value) {
              emit(AppInsertIntoDatabaseState());
              getDataFromDataBase(database);
            }).catchError((error) {
              showToast(
                text: 'Error: ${error.toString()}',
                state: ToastStates.error,
              );
            }))
        .catchError((error) {
      showToast(
        text: 'Error: ${error.toString()}',
        state: ToastStates.error,
      );
    });
  }

  void updateDataBaseEditTask({
    required int id,
    required String task,
    required String description,
    required String date,
    required String time,
  }) {
    database.rawUpdate(
      "UPDATE tasks SET task = ?, description = ?, date = ?, time = ? WHERE id = ?",
      [task, description, date, time, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseEditTaskState());
    }).catchError((error) {
      showToast(
        text: 'Error: ${error.toString()}',
        state: ToastStates.error,
      );
    });
  }

  void updateDataBaseTaskStatus({
    required int id,
    required String status,
    required BuildContext context,
  }) {
    database.rawUpdate(
      "UPDATE tasks SET status = ? WHERE id = ?",
      [status, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseTaskState());
    }).catchError((error) {
      showToast(
        text: 'Error: ${error.toString()}',
        state: ToastStates.error,
      );
    });
  }

  void deleteFromDataBase({required int id}) {
    database.rawDelete(
      "DELETE FROM tasks WHERE id = ?",
      [id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteFromDatabaseState());
    });
  }
}
