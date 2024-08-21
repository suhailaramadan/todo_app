import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/edit_task.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskItem extends StatefulWidget {
  TaskItem(this.taskModel);
  TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      child: Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            children:[
              SlidableAction(
                onPressed: (context) {
                
                  FirebaseFunctions.deleteTaskFromFirestore(widget.taskModel.id)
                .timeout(Duration(microseconds: 500), onTimeout: () {
                    
                    Provider.of<TasksProvider>(context, listen: false)
                        .getTasks();
                    
                  }).catchError((error) {
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.msgWrong,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 5,
                    );
                  });
                },
                backgroundColor:AppTheme.red,
                foregroundColor: AppTheme.white,
                borderRadius: BorderRadius.circular(20),
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
        child: 
        InkWell(
        onTap: widget.taskModel.isDone==true
            ? null
            : () {
                Navigator.of(context).pushNamed(EditTask.routeName,
                    arguments: TextFieldArgs(
                        title: widget.taskModel.title,
                        date: widget.taskModel.date,
                        desc: widget.taskModel.description,
                        id: widget.taskModel.id));
              },
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(8),
              //height: 110,
              decoration: BoxDecoration(
                  color:settingsProvider.isDark?AppTheme.black:AppTheme.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 72,
                          width: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(2),
                                bottom: Radius.circular(2)),
                            color: widget.taskModel.isDone == true
                                ? AppTheme.green
                                : AppTheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.taskModel.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: widget.taskModel.isDone == true
                                        ? AppTheme.green
                                        : AppTheme.primary),
                          ),
                          Text(
                            widget.taskModel.description,
                            style: widget.taskModel.isDone == true
                                ? Theme.of(context)
                                    .textTheme.titleSmall
                                    : Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color:Color.fromARGB(255, 126, 122, 122)),
                              )
                            ],
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            setState(() {
                              tasksProvider
                                  .changeIconToText(widget.taskModel.isDone);
                              widget.taskModel.isDone = tasksProvider.isDone;
                              FirebaseFunctions.getTasksCollection()
                                  .doc(widget.taskModel.id)
                                  .update({"isDone": widget.taskModel.isDone});
                            });
                            print("clicked");
                          },
                          child: widget.taskModel.isDone == true
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                  settingsProvider.Language=="ar"?"تم": "Done",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppTheme.green,
                                          fontSize: 28,
                                        ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsetsDirectional.only(end: 15),
                                  height: 34,
                                  width: 69,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.primary),
                                  child: Icon(Icons.check_rounded,
                                      color: Colors.white, size: 32),
                                ))
                    ],
                  )
                ],
              )),
        ),
      )),
    );
  }
}

class TextFieldArgs {
  String title = '';
  String desc = '';
  DateTime date = DateTime.now();
  String id = "";
  TextFieldArgs(
      {required this.id,
      required this.title,
      required this.date,
      required this.desc});
}
