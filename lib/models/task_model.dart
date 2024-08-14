class TaskModel{
  String title;
  String description;
  DateTime date;
  bool isDone;
  TaskModel({
    required this.title,
    required this.date,
    required this.description,
    this.isDone=false
    });  
}