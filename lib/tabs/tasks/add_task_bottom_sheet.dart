import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController descriptionControl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat=DateFormat("dd/MM/yyyy");
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.55,
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "Add new task",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 15,
            ),
            DefaultTextFormField(
              controller: titleControl,
              hintText: "Enter task title",
              validator: (value) {
                if(value==null|| value.trim().isEmpty){
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
                if(value==null||value.trim().isEmpty){
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
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()async { 
              DateTime? dateTime=await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: selectedDate,
                  initialEntryMode: DatePickerEntryMode.calendarOnly);
                  if(dateTime!=null){
                    selectedDate=dateTime;
                    setState(() {
                      
                    });
                  }},
              child: Text(
                dateFormat.format(selectedDate),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height:20,),
            DefaultElevatedBottom(lable:  "submit", onPressed:(){ 
              if(formKey.currentState!.validate()){
                addTask();}
            })
          ],
        ),
      ),
    );
  }
  void addTask(){

  }
}
