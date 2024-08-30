import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
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
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextFieldArgs args =
        ModalRoute.of(context)!.settings.arguments as TextFieldArgs;
    if(titleControl.text.isEmpty) titleControl.text = args.title;
    if(descriptionControl.text.isEmpty)descriptionControl.text = args.desc;
    widget.id=args.id;
    widget.selectedDate=args.date;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: AppTheme.white,
          backgroundColor: AppTheme.primary,
          title: Text(AppLocalizations.of(context)!.todoList,
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
                      color: settingsProvider.isDark
                          ? AppTheme.black
                          : AppTheme.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.editTask,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: settingsProvider.isDark
                                        ? AppTheme.white
                                        : AppTheme.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultTextFormField(controller: titleControl),
                          SizedBox(height: 10),
                          DefaultTextFormField(
                            controller: descriptionControl,
                            maxLine: 5, 
                          ),                          
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.seclectTime,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: settingsProvider.isDark
                                        ? AppTheme.white
                                        : AppTheme.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                  locale: settingsProvider.Language == "ar"
                                      ? Locale("ar")
                                      : Locale("en"),
                                  context: context,
                                  firstDate:
                                      args.date.subtract(Duration(days: 30)),
                                  lastDate: args.date.add(Duration(days: 360)),
                                  initialDate: widget.selectedDate,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly);
                              if (dateTime != null) {
                                args.date = dateTime;
                                setState(() {});
                              }
                            },
                            child: Text(widget.dateFormat.format(args.date),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: settingsProvider.isDark
                                            ? AppTheme.white
                                            : AppTheme.black)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DefaultElevatedBottom(
                            lable: AppLocalizations.of(context)!.change,
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
    final userId=Provider.of<UserProvider>(context,listen: false).currentUser!.id;
    FirebaseFunctions.editTaskInFirestore(
      TaskModel(
          id: widget.id,
          title: titleControl.text,
          date: widget.selectedDate,
          description: descriptionControl.text),userId
    ).timeout(Duration(microseconds: 500), onTimeout: () {
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
      Fluttertoast.showToast(
          msg:AppLocalizations.of(context)!.msgEdit,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg:AppLocalizations.of(context)!.msgWrong,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
