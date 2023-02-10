import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Layout/todo_layout.dart';
import 'Shared/Cubit/cubit.dart';
import 'Shared/Cubit/states.dart';
import 'Shared/Network/Local/cache_helper.dart';
import 'Shared/Styles/themes.dart';
import 'Shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: "isDark") ?? false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDark});

  bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeAppMode(isDarkFromShared: isDark)
        ..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Just Do It',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const TODOLayout(),
          );
        },
      ),
    );
  }
}
