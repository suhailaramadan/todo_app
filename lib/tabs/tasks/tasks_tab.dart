import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> task = List.generate(
        10,
        (index) => TaskModel(
            title: "Task #${index + 1} title",
            date: DateTime.now(),
            description: "Task #${index + 1} description"));
    return SafeArea(
        child: Column(children: [
      SizedBox(
        height: 10,
      ),
      // Container(
      //   height: 150,
      //   color: AppTheme.primary,
      //   child: Stack(
          
      //     children: [
      //       Container(
      //         color: AppTheme.primary,
      //         height: 150,
      //       ),
      //       Positioned(top: 0,
            
      //       //bottom: -10,
      //         child: EasyInfiniteDateTimeLine(
                
      //           dayProps: EasyDayProps(
      //             height: 75,width: 60,
      //               activeDayStyle: DayStyle(
      //                   decoration: BoxDecoration(
                          
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.circular(18),
      //                       border: Border.all(color:Color.fromARGB(255, 68, 33, 243),width: 3)),
      //                   dayNumStyle: TextStyle(
      //                       fontSize: 20,
      //                       color: AppTheme.primary,
      //                       fontWeight: FontWeight.w500),
      //                   monthStrStyle: TextStyle(
      //                       fontSize: 20,
      //                       color: AppTheme.primary,
      //                       fontWeight: FontWeight.w500),
      //                   dayStrStyle: TextStyle(
      //                       fontSize: 20,
      //                       color: AppTheme.primary,
      //                       fontWeight: FontWeight.w500)),
      //               inactiveDayStyle: DayStyle(
      //                   decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.circular(18)))),
      //           firstDate: DateTime.now().subtract(Duration(days: 30)),
      //           focusDate: DateTime.now(),
      //           lastDate: DateTime.now().add(Duration(days: 30)),
      //           showTimelineHeader: false,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
            focusDate:DateTime.now(),
            lastDate:DateTime.now().add(Duration(days: 30)),
            showTimelineHeader: false,),
        ],

      ),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) => TaskItem(
            task[index],
          ),
          itemCount: task.length,
        ),
      ),
    ]));
  }
}
