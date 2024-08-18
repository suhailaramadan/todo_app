import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection("tasks").withConverter<TaskModel>(
          fromFirestore: (docSnapshot, _) =>
              TaskModel.fromJson(docSnapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJeson());

  static Future<void> addTaskToFirestore(TaskModel task) async {
    CollectionReference<TaskModel> taskscollection=getTasksCollection();
  DocumentReference<TaskModel> docRef=  taskscollection.doc();
  task.id = docRef.id;
  return docRef.set(task);
  }
  static Future<List<TaskModel>> getAllTasksFromFirestore()async{
    CollectionReference<TaskModel> taskscollection=getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot= await taskscollection.get();
    return querySnapshot.docs.map((docSnapshot)=>docSnapshot.data()).toList();
  }
  static Future<void> deleteTaskFromFirestore(String taskId)async{
    CollectionReference<TaskModel> taskscollection=getTasksCollection();
  return taskscollection.doc(taskId).delete();
  }

  static Future<void> editTaskInFirestore(TaskModel task)async{
    if(task.id!=null&&task.id.isNotEmpty){
    CollectionReference<TaskModel>taskscollection=getTasksCollection();
    DocumentReference<TaskModel>docRefr=taskscollection.doc(task.id);
    //task.id=docRefr.id;

    return docRefr.update(task.toJeson());
  
    }
   // else return;
  }

}
