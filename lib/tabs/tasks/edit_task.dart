import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "/edit";
  EditTask({super.key});
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String id = "";
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController descriptionControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFieldArgs args =
        ModalRoute.of(context)!.settings.arguments as TextFieldArgs;
    titleControl.text = args.title;
    descriptionControl.text = args.desc;
    widget.id=args.id;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppTheme.white,
          backgroundColor: AppTheme.primary,
          title: Text("To Do List",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppTheme.white, fontSize: 30)),
        ),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: AppTheme.primary,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 50, start: 30),
                child: Container(
                    width: 350,
                    height: MediaQuery.of(context).size.height * .7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "Edit Task",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultTextFormField(controller: titleControl),
                          SizedBox(height: 1),
                          DefaultTextFormField(
                            controller: descriptionControl,
                            maxLine: 5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Selected time",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  firstDate: args.date,
                                  lastDate:
                                      DateTime.now().add(Duration(days: 30)),
                                      
                                  initialDate: args.date,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly);
                              if (dateTime != null) {
                                widget.selectedDate = dateTime;
                                setState(() {});
                              }
                            },
                            child: Text(widget.dateFormat.format(args.date),
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          DefaultElevatedBottom(
                            lable: "Save Changes",
                            onPressed: () {
                              editTask();
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void editTask() {
      FirebaseFunctions.editTaskInFirestore(
        TaskModel(
            id: widget.id,
            title: titleControl.text,
            date: widget.selectedDate,
            description: descriptionControl.text),
      ).timeout(Duration(microseconds: 500), onTimeout: () {
        Navigator.of(context).pop();
        print("poped");

        Provider.of<TasksProvider>(context, listen: false).getTasks();

        print("Task edit");
      }).catchError((error) {
        print("Error");
        print(error);
      });
    }
}
