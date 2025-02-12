import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/add_task');
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
        ),
      ),
    );
  }
}
