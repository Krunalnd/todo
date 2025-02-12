import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/extensions/space_exs.dart';
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
  GlobalKey<SliderDrawerState> drawerKey =  GlobalKey<SliderDrawerState>();
  final List<int> testing = [2, 323, 23];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Fab(),
      body: SliderDrawer(
        key: drawerKey,
        animationDuration:1000,
        isDraggable: false,
        ///Drawer
        slider: CustomDrawer(),

        //appBar: HomeAppBar(drawerKey: drawerKey,),
        ///Main Body
        child: buildHomeBody(textTheme),
      ),
    );
  }

  /// Home Body
  Widget buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Custom App Bar
          Container(
            margin: EdgeInsets.only(top: 60, bottom: 10),
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
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
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
                    Text("1 of 3 tasks", style: textTheme.titleMedium),
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
          Expanded(
            child: testing.isNotEmpty

                /// Task list is not empty
                ? ListView.builder(
                    itemCount: testing.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            ///We Will remove the item from the list
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
                          key: Key(index.toString()),
                          child: TextWidget());
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
                            animate: testing.isNotEmpty ? false : true,
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
