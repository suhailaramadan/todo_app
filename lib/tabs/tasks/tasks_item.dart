import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskItem(this.taskModel);
  TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(12),padding: EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.rectangle,color: AppTheme.white,borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(height: 62,width: 4,decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(2),bottom: Radius.circular(2)),color: AppTheme.primary,),),
              ),
              SizedBox(width: 10,),
              Column(crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text(
                    taskModel.title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppTheme.primary),
                  ),
                  Text(taskModel.description,style: Theme.of(context).textTheme.titleSmall,)
                ],
              ),
              Spacer(),
              Container(margin: EdgeInsetsDirectional.only(end: 15),height: 34,width: 69,decoration: BoxDecoration(shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10),color:AppTheme.primary),
              child: Icon(Icons.check_rounded,color: Colors.white,size: 32 ),)
            ],
          
          )
        ],)
      );
  }
}