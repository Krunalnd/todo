import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/extensions/space_exs.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/home/components/fab.dart';
import 'package:todo/views/home/components/home_app_bar.dart';
import 'package:todo/views/home/components/slider_drawer.dart';
import 'package:todo/views/home/widget/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  /// Checking Done Tasks
  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  /// Checking The Value Of the Circle Indicator
  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        /// Sort Task List
        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          // Return the Scaffold directly
          // appBar: HomeAppBar(drawerKey: drawerKey),
          backgroundColor: Colors.white,
          floatingActionButton: Fab(),
          body: SliderDrawer(
            key: drawerKey,
            animationDuration: 1000,
            isDraggable: false,

            /// Drawer
            slider: CustomDrawer(),

            //appBar: HomeAppBar(drawerKey: drawerKey),

            /// Main Body
            child: buildHomeBody(tasks, base, textTheme),
          ),
        );
      },
    );
  }

  /// Home Body
  Widget buildHomeBody(List<Task> tasks, BaseWidget base, TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Custom App Bar
          Container(
            margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Progress Indicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
                // Space
                25.w,
                // Top level Task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),

          /// Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(thickness: 2, indent: 100),
          ),

          /// Task List
          SizedBox(
            width: double.infinity,
            height: 585,
            child: tasks.isNotEmpty

                /// Task list is not empty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      ///Single Task showing on the list
                      var task = tasks[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          base.dataStore.deleteTask(task: task);
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            8.w,
                            Text(
                              AppStr.deletedTask,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        key: Key(task.id),
                        child: TextWidget(task: task),
                      );
                    },
                  )

                /// Task list is empty
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                        child: Text(AppStr.doneAllTask),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
