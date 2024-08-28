import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Create Account",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextFormField(
                  controller: nameControl,
                  hintText: "Name",
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return "Name can not be less than 3 char";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  controller: emailControl,
                  hintText: "Email",
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "Email can not be less than 6 char";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  controller: passwordControl,
                  hintText: "Password",
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return "Password can not be less than 8 char";
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                SizedBox(
                  height: 80,
                ),
                DefaultElevatedBottom(
                    lable: "Create Account", onPressed: register),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      "Already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppTheme.primary),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
          name: nameControl.text,
          email: emailControl.text,
          password: passwordControl.text
          ).then((user){
            Provider.of<UserProvider>(context,listen: false).updateUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }).catchError((error){
            String? massage;
            if(error is FirebaseAuthException){
              massage=error.message;
            }
            Fluttertoast.showToast(
              msg:massage??"Something went wrong",
              textColor: AppTheme.white,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor:AppTheme.red,
              timeInSecForIosWeb: 5
              );
          });
    }
  }
}
