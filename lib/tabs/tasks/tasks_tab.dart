import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider=Provider.of<TasksProvider>(context);
    return SafeArea(
        child: Column(children: [
      SizedBox(
        height: 10,
      ),
      SizedBox(height: 10,),
      Column(
        children: [
          SizedBox(height: 20,),
          EasyInfiniteDateTimeLine(
            dayProps:EasyDayProps(
              inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)))),
            firstDate:DateTime.now().subtract(Duration(days: 30)) ,
            focusDate:tasksProvider.selectedDate,
            lastDate:DateTime.now().add(Duration(days: 30)),
            showTimelineHeader: false,
            onDateChange: (selectedDate){
              tasksProvider.changeSelectedDate( selectedDate);
              tasksProvider.getTasks();
              }),
              
        ],

      ),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) => TaskItem(
          tasksProvider.tasks[index],
          ),
          itemCount: tasksProvider.tasks.length,
        ),
      ),
    ]));
  }
}
