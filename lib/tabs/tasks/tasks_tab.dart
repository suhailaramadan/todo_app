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
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(children: [
      Column(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Stack(
            children: [
              Container(color: AppTheme.primary, height: 150),
              PositionedDirectional(
                  top: 30,
                  start: 10,
                  child: Text("To Do List",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppTheme.white, fontSize: 28))),
              Padding(
                padding: const EdgeInsets.only(top:110),
                child: EasyInfiniteDateTimeLine(
                    dayProps: EasyDayProps(
                        height: 80,
                        width: 60,
                        activeDayStyle: DayStyle(
                            monthStrStyle: TextStyle(
                              color:AppTheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                            ),
                            dayNumStyle: TextStyle(
                                color:AppTheme.primary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700
                              ),
                              dayStrStyle: TextStyle(
                                color:AppTheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(5))),
                        inactiveDayStyle: DayStyle(
                              dayNumStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600
                              ),
                              dayStrStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                              ),
                              monthStrStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                              ),  
                          decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)))),
                    firstDate: DateTime.now().subtract(Duration(days: 50)),
                    focusDate: tasksProvider.selectedDate,
                    lastDate: DateTime.now().add(Duration(days: 30)),
                    showTimelineHeader: false,
                    onDateChange: (selectedDate) {
                      tasksProvider.changeSelectedDate(selectedDate);
                      tasksProvider.getTasks();
                    }),
              )
            ],
          ),
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
    ]);
  }
}
