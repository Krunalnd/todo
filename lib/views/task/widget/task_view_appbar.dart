import 'package:flutter/material.dart';

class TaskViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskViewAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
