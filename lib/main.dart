import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/task.dart';
import 'package:todo/views/home/home_view.dart';
import 'package:todo/data/hive_data_store.dart';


Future<void> main() async {
  //Initial  DB before runApp
  await Hive.initFlutter();

  //Register Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  ///Open Box
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);

  box.values.forEach(
    (task) {
      if (task.createdAtDate.day != DateTime.now().day) {
        task.delete();
      } else {
        ///Do nothing
      }
    },
  );

  runApp(BaseWidget(child: MyApp()));
}

class BaseWidget extends InheritedWidget {
   BaseWidget({Key ? key, required this.child}): super(key: key, child: child);

  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();

    if(base != null) {
      return base;
    }else{
      throw StateError('No BaseWidget found in context');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(color: Colors.white, fontSize: 21),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
          headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: HomeView(),
      //home: TaskView(),
    );
  }
}





