import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child:  Column(
        children:[ 
          SizedBox(height: 10,),
        Column(
          children: [
            SizedBox(height: 20,),
            EasyInfiniteDateTimeLine(
              firstDate:DateTime.now().subtract(Duration(days: 30)) ,
              focusDate:DateTime.now(),
              lastDate:DateTime.now().add(Duration(days: 30)),
              showTimelineHeader: false,),
          ],
          
        ),
          Expanded(
          child: ListView.builder(padding: EdgeInsets.only(top: 20),
          itemBuilder: 
          (context, index) => TaskItem(),itemCount: 10,),
        ),
      ])
    );
  }
}