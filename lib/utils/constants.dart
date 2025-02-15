import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/app_str.dart';

/// Lottie asset address
String lottieURL = "assets/lottie/1.json";

///Empty Title or SubTitle TextField Warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must fill all the fields',
    corner: 20.0,
    duration: 2000,
    padding: EdgeInsets.all(20),
  );
}

///Nothing Enter when user try to edit or update the task
dynamic upadateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must Edit the tasks then try to update it!',
    corner: 20.0,
    duration: 5000,
    padding: EdgeInsets.all(20),
  );
}

///No Task waring dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message:
        "There is no Task For Delete! \n Try adding some and then try to delete it!",
    buttonText: "Okey",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

///Delete all Task from DB dialog
dynamic deleteAllTaskWarning(BuildContext context) {
  PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        "Do you really want to delete all tasks? You will not be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
