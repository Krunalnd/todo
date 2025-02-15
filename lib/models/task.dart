import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) //Id
  final String id;
  @HiveField(1) // Title
  String title;
  @HiveField(2) //Subtitle
  String subtitle;
  @HiveField(3) //createdAtTime
  DateTime createdAtTime;
  @HiveField(4) //createdAtDate
  DateTime createdAtDate;
  @HiveField(5)//isCompleted
  bool isCompleted;

  ///Create new task
  factory Task.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: Uuid().v1(),
        title: title ??'',
        subtitle:subtitle ?? '',
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate:createdAtDate ?? DateTime.now() ,
        isCompleted: false,
      );
}
