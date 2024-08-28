import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
          fromFirestore: (docSnapshot, _) =>
              UserModel.fromJson(docSnapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson());

  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
    getUserCollection().doc(userId).collection("tasks").withConverter<TaskModel>(
          fromFirestore: (docSnapshot, _) =>
              TaskModel.fromJson(docSnapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJson());

  static Future<void> addTaskToFirestore(TaskModel task,String userId) async {
    CollectionReference<TaskModel> taskscollection=getTasksCollection(userId);
  DocumentReference<TaskModel> docRef=  taskscollection.doc();
  task.id = docRef.id;
  return docRef.set(task);
  }
  static Future<List<TaskModel>> getAllTasksFromFirestore(String userId)async{
    CollectionReference<TaskModel> taskscollection=getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot= await taskscollection.get();
    return querySnapshot.docs.map((docSnapshot)=>docSnapshot.data()).toList();
  }
  static Future<void> deleteTaskFromFirestore(String taskId,String userId)async{
    CollectionReference<TaskModel> taskscollection=getTasksCollection(userId);
  return taskscollection.doc(taskId).delete();
  }

  static Future<void> editTaskInFirestore(TaskModel task,String userId)async{
    if(task.id!=null&&task.id.isNotEmpty){
    CollectionReference<TaskModel>taskscollection=getTasksCollection(userId);
    DocumentReference<TaskModel>docRefr=taskscollection.doc(task.id);
    return docRefr.update(task.toJson());
  
    }}
  static Future<UserModel> register(
      {required String name,
      required String email,
      required String password}) async {
      final credentials=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);
      final user=UserModel(
        id: credentials.user!.uid,
        name: name, 
        email: email);

      final userCollection=getUserCollection();
      await userCollection.doc(user.id).set(user);
      return user;
  }
  static Future<UserModel>login({
    required String email,
    required String password
  })async{
  final credentials=await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
    );
    final userCollection=getUserCollection();
    final docSnapshote=await userCollection.doc(credentials.user!.uid).get();
    return docSnapshote.data()!;

  }
  static Future<void>logout()async{
    FirebaseAuth.instance.signOut();
  }

  
}
