import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailControl = TextEditingController();
    TextEditingController passwordControl = TextEditingController();
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading :false,
        title: Text(
          "Login",
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
                controller: emailControl,
                hintText: "Email",
                validator: (value) {
                    if(value==null||value.trim().length<6){
                      return"Email can not be less than 6 char";
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
                    if(value==null||value.trim().length<8){
                      return"Password can not be less than 8 char";
                    }
                    return null;
                  },
                isPassword: true,
              ),
              SizedBox(
                height: 80,
              ),
              DefaultElevatedBottom(lable: "Login", onPressed: () {}),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text(
                    "Don't have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppTheme.primary),
                  ))
            ],
          ),
        ),
      ),
    );
    
  }
  void login(){
    if(formKey.currentState!.validate()){}
  }
}
