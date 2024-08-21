import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';
import 'package:todo_app/tabs/tasks/edit_task.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}
class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController descriptionControl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return Container(
      color:settingsProvider.isDark?AppTheme.black:AppTheme.white ,
      height: MediaQuery.of(context).size.height * .55,
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "Add new task",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
            ),
            SizedBox(
              height: 15,
            ),
            DefaultTextFormField(
              controller: titleControl,
              hintText: "Enter task title",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Title can not be empty";
                }
                return null;
              },
            ),
            DefaultTextFormField(
              controller: descriptionControl,
              hintText: "Enter task description",
              maxLine: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Description can not be empty";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Date",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w400,color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialDate: selectedDate,
                    initialEntryMode: DatePickerEntryMode.calendarOnly);
                if (dateTime != null) {
                  selectedDate = dateTime;
                  setState(() {});
                }
              },
              child: Text(
                dateFormat.format(selectedDate),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500,color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultElevatedBottom(
                lable: "submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addTask();
                  }
                })
          ],
        ),
      ),
    );
  }

  void addTask() {
    FirebaseFunctions.addTaskToFirestore(TaskModel(
            title: titleControl.text,
            date: selectedDate,
            description: descriptionControl.text
            ))
        .timeout(Duration(microseconds: 500), onTimeout: () {
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getTasks();
      Fluttertoast.showToast(
        msg: "Task added successfully",
        toastLength: Toast.LENGTH_LONG,
        
        timeInSecForIosWeb: 5,
        backgroundColor:AppTheme.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_LONG,
        
        timeInSecForIosWeb: 5,
        backgroundColor:AppTheme.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    });
  }
}
