import 'package:intl/intl.dart';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
  });

  factory Task.fromJson(Map<String,dynamic> item){
    
    return Task(
      id: int.parse(item['id']),
      title: item['title'],
      note: item['note'],
      isCompleted: int.parse(item['isCompleted']),
      date: item['date'],
      startTime: item['startTime'],
      endTime: item['endTime'],
      remind: int.parse(item['remind']),
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> item = new Map<String,dynamic>();
    item['id'] = this.id;
    item['title'] = this.title;
    item['note'] = this.note;
    item['isCompleted'] = this.isCompleted;
    item['date'] = this.date;
    item['startTime'] = this.startTime;
    item['endTime'] = this.endTime;
    item['remind'] = this.remind;

    return item;
  }
}