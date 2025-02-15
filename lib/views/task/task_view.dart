import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todo/extensions/space_exs.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/task/components/date_time_selection.dart';
import 'package:todo/views/task/components/rep_textfield.dart';
import 'package:todo/views/task/widget/task_view_appbar.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTextController,
    required this.descriptionTextController,
    required this.task,
  });

  final TextEditingController? titleTextController;
  final TextEditingController? descriptionTextController;
  final Task? task;

  //final Task task;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? date;
  DateTime? time;

  ///Time Show in String Formate
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMd().format(date).toString();
      }
    } else {
      return DateFormat("hh:mm a")
          .format(widget.task!.createdAtDate)
          .toString();
    }
  }

  ///Show Selected Date as a DateFormat for init time
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  ///Time Show in String Formate
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat("hh:mm a").format(DateTime.now()).toString();
      } else {
        return DateFormat("hh:mm a").format(time).toString();
      }
    } else {
      return DateFormat("hh:mm a")
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  ///if any Task already exist return true other wise false
  bool isTaskAlreadyExist() {
    if (widget.titleTextController?.text == null &&
        widget.descriptionTextController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  ///Main function for creating or updating tasks
  dynamic isTaskAlreadyExistUpdateOtherWisecreate() {
    ///hear update current page
    if (widget.titleTextController?.text != null &&
        widget.descriptionTextController?.text != null) {
      try {
        widget.titleTextController?.text = title;
        widget.descriptionTextController?.text = subTitle;

        widget.task?.save();

        Navigator.pop(context);
      } catch (e) {
        upadateTaskWarning(context);
      }
    }

    ///heare create new task
    else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          subtitle: subTitle,
          createdAtDate: date,
          createdAtTime: time,
        );

        /// Adding new task to Hive DB using inherited widget
        BaseWidget.of(context).dataStore.addTask(task: task);

        Navigator.pop(context);
      } else {
        ///warning
        emptyWarning(context);
      }
    }
  }

  /// Delete Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        ///Appbar
        appBar: TaskViewAppbar(),

        ///
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Top Side Texts
                buildTopSideTexts(textTheme),

                ///Main Task View Activity
                buildMainTaskViewActivity(textTheme, context),

                ///Bottom Side
                buildBottomSide()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Bottom Side
  Widget buildBottomSide() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              :

              ///Deleted Current Task Btn
              MaterialButton(
                  onPressed: () {
                    deleteTask();
                  },
                  minWidth: 150,
                  height: 55,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        AppStr.deleteTask,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),

          ///Add or Update  Current Task Btn
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWisecreate();
            },
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                //Icon(Icons.close,color: AppColors.primaryColor,),
                Text(
                  isTaskAlreadyExist()
                      ? AppStr.addNewTask
                      : AppStr.updateTaskString,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Main Task View Activity
  Widget buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title TextField
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          /// Task of Title
          RepTextField(
            controller: widget.titleTextController ?? TextEditingController(),
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          ///Task Title
          RepTextField(
            controller:
                widget.descriptionTextController ?? TextEditingController(),
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),

          ///Time Selection
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),
                    dateFormat: "HH:mm a ",
                    onChange: (_, __) {},
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdAtTime == null) {
                          time = dateTime;
                        } else {
                          widget.task!.createdAtTime = dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: AppStr.timeString,
            time: showTime(time),
            isTime: true,
          ),

          ///Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 6, 4),
                minDateTime: DateTime.now(),
                initialDateTime: showDateAsDateTime(date),
                onChange: (_, __) {},
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = dateTime;
                    } else {
                      widget.task!.createdAtDate = dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.dateString,
            time: showDate(date),
          ),
        ],
      ),
    );
  }

  ///Top Side Texts
  Widget buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Divider(thickness: 2),
          ),
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExist()
                  ? AppStr.addNewTask
                  : AppStr.updateCurrentTask,
              style: textTheme.titleLarge,
              children: [
                TextSpan(
                    text: AppStr.taskString,
                    style: TextStyle(fontWeight: FontWeight.w500))
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Divider(thickness: 2),
          ),
        ],
      ),
    );
  }
}
