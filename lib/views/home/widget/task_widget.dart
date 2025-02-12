import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          ///Check Icon
          leading: GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),

          ///Task title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ///Task Descrption
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descrption",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),

              ///Date of Task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Sub Date",
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}