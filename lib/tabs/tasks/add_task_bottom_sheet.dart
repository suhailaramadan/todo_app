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
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color:settingsProvider.isDark?AppTheme.black:AppTheme.white ),
          height: MediaQuery.of(context).size.height * .6,
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.addTask,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
                ),
                SizedBox(
                  height: 15,
                ),
                DefaultTextFormField(
                  controller: titleControl,
                  hintText: AppLocalizations.of(context)!.title,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.validateTitle;
                    }
                    return null;
                  },
                ),
                DefaultTextFormField(
                  controller: descriptionControl,
                  hintText:AppLocalizations.of(context)!.desc,
                  maxLine: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.validateDesc;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.seclectTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight:settingsProvider.Language=="ar"?FontWeight.w600: FontWeight.w400,color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
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
                  height: 50,
                ),
                DefaultElevatedBottom(
                    lable:AppLocalizations.of(context)!.submit,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addTask();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userId=Provider.of<UserProvider>(context,listen: false).currentUser!.id;
    FirebaseFunctions.addTaskToFirestore(TaskModel(
            title: titleControl.text,
            date: selectedDate,
            description: descriptionControl.text
            ),userId)
        .then((_){
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
      Fluttertoast.showToast(
        msg:AppLocalizations.of(context)!.msgAdd,
        toastLength: Toast.LENGTH_LONG,
        
        timeInSecForIosWeb: 5,
        backgroundColor:AppTheme.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg:AppLocalizations.of(context)!.msgWrong,
        toastLength: Toast.LENGTH_LONG,
        
        timeInSecForIosWeb: 5,
        backgroundColor:AppTheme.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    });
  }
}
