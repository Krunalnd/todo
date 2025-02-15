import 'package:flutter/material.dart';
import 'package:todo/extensions/space_exs.dart';
import 'package:todo/utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  /// Icons
  final List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.info_outline,
  ];

  /// Text
  final List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                AssetImage("assets/img/avatar.png"), // Use AssetImage directly
          ),
          SizedBox(height: 10), // Use SizedBox for spacing
          Text(
            "Rudra Patel",
            style: textTheme.displayMedium?.copyWith(color: Colors.black) ??
                TextStyle(color: Colors.black),
          ),
          Text(
            "Flutter Developer",
            style: textTheme.displaySmall?.copyWith(color: Colors.black) ??
                TextStyle(color: Colors.black),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print('${texts[index]} Item Tapped!');
                  },
                  child: Container(
                    margin: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(icons[index], size: 30),
                      title: Text(texts[index], style: TextStyle(fontSize: 20)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
