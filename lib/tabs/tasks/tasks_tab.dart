import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/tasks_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(children: [
      Column(
        children: [
          Stack(
            children: [
              Container(color: AppTheme.primary, height: 150),
              PositionedDirectional(
                  top: 30,
                  start: 150,
                  child: Align(
                    child: Text("To Do List",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppTheme.white, fontSize: 28)),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: EasyInfiniteDateTimeLine(
                  locale: settingsProvider.Language=="ar"?"ar":"en",
                    dayProps: EasyDayProps(
                        height: 80,
                        width: 60,
                        todayStyle: DayStyle(
                            dayNumStyle:
                                tasksProvider.selectedDate == DateTime.now()
                                    ? TextStyle(
                                        color: AppTheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        color: settingsProvider.isDark
                                            ? AppTheme.white
                                            : AppTheme.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                            dayStrStyle:
                                tasksProvider.selectedDate == DateTime.now()
                                    ? TextStyle(
                                        color: AppTheme.primary,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : TextStyle(
                                        color: settingsProvider.isDark
                                            ? AppTheme.white
                                            : AppTheme.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w300,
                                      ),
                            monthStrStyle:
                                tasksProvider.selectedDate == DateTime.now()
                                    ? TextStyle(
                                        color: AppTheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : TextStyle(
                                        color: settingsProvider.isDark
                                            ? AppTheme.white
                                            : AppTheme.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                            decoration: BoxDecoration(
                                color: settingsProvider.isDark
                                    ? AppTheme.black
                                    : AppTheme.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: settingsProvider.isDark
                                      ? AppTheme.white
                                      : AppTheme.black,
                                ))),
                        activeDayStyle: DayStyle(
                            monthStrStyle: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            dayNumStyle: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700),
                            dayStrStyle: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            decoration: BoxDecoration(
                                color: settingsProvider.isDark
                                    ? AppTheme.black
                                    : AppTheme.white,
                                borderRadius: BorderRadius.circular(5))),
                        inactiveDayStyle: DayStyle(
                            dayNumStyle: TextStyle(
                                color: settingsProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                            dayStrStyle: TextStyle(
                                color: settingsProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            monthStrStyle: TextStyle(
                                color: settingsProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            decoration: BoxDecoration(
                                color: settingsProvider.isDark
                                    ? AppTheme.black
                                    : AppTheme.white,
                                borderRadius: BorderRadius.circular(5)))),
                    firstDate: DateTime.now().subtract(Duration(days: 50)),
                    focusDate: tasksProvider.selectedDate,
                    lastDate: DateTime.now().add(const Duration(days: 30)),
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
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (context, index) => TaskItem(
            tasksProvider.tasks[index],
          ),
          itemCount: tasksProvider.tasks.length,
        ),
      ),
    ]);
  }
}
